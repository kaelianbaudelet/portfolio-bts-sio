<?php

namespace App\Controller\Admin;

use App\Entity\Certification;
use App\Form\CertificationType;
use App\Repository\CertificationRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;
use Symfony\Component\String\Slugger\SluggerInterface;

#[Route('/admin/certifications')]
#[IsGranted('ROLE_ADMIN')]
class CertificationController extends AbstractController
{
    public function __construct(
        private EntityManagerInterface $entityManager,
        private CertificationRepository $certificationRepository,
        private SluggerInterface $slugger,
        private string $certificationsDirectory = 'uploads/certifications'
    ) {}

    #[Route('', name: 'admin_certifications_index', methods: ['GET'])]
    public function index(): Response
    {
        $certifications = $this->certificationRepository->findAllForAdmin();

        $stats = [
            'total' => count($certifications),
            'visible' => count(array_filter($certifications, fn($c) => $c->isVisible())),
            'expired' => count(array_filter($certifications, fn($c) => $c->isExpired())),
            'by_type' => $this->certificationRepository->countByType(false),
        ];

        return $this->render('admin/certifications/index.html.twig', [
            'certifications' => $certifications,
            'stats' => $stats,
        ]);
    }

    #[Route('/new', name: 'admin_certifications_new', methods: ['GET', 'POST'])]
    public function new(Request $request): Response
    {
        $certification = new Certification();
        $form = $this->createForm(CertificationType::class, $certification);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            // Check if a PDF file was selected from the media library
            $selectedPdfFile = $request->request->get('pdfFile');

            if ($selectedPdfFile) {
                // Use the file from the media library
                $certification->setPdfFile($selectedPdfFile);
            } else {
                // Handle PDF file upload (fallback for direct upload)
                /** @var UploadedFile $pdfFile */
                $pdfFile = $form->get('pdfFileUpload')->getData();

                if ($pdfFile) {
                    $newFilename = $this->handleFileUpload($pdfFile);
                    $certification->setPdfFile($newFilename);
                }
            }

            // Set display order if not set
            if ($certification->getDisplayOrder() === 0) {
                $maxOrder = $this->certificationRepository
                    ->createQueryBuilder('c')
                    ->select('MAX(c.displayOrder)')
                    ->getQuery()
                    ->getSingleScalarResult();
                $certification->setDisplayOrder(($maxOrder ?? 0) + 1);
            }

            $this->entityManager->persist($certification);
            $this->entityManager->flush();

            $this->addFlash('success', 'La certification a été créée avec succès.');

            return $this->redirectToRoute('admin_certifications_index');
        }

        return $this->render('admin/certifications/form.html.twig', [
            'certification' => $certification,
            'form' => $form,
            'page_title' => 'Nouvelle certification',
        ]);
    }

    #[Route('/{id}/edit', name: 'admin_certifications_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Certification $certification): Response
    {
        $form = $this->createForm(CertificationType::class, $certification);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            // Check if a PDF file was selected from the media library
            $selectedPdfFile = $request->request->get('pdfFile');

            if ($selectedPdfFile) {
                // Use the file from the media library (don't delete the old one, it might be used elsewhere)
                $certification->setPdfFile($selectedPdfFile);
            } elseif ($selectedPdfFile === '') {
                // Empty string means the user removed the PDF
                $certification->setPdfFile(null);
            } else {
                // Handle PDF file upload (fallback for direct upload)
                /** @var UploadedFile $pdfFile */
                $pdfFile = $form->get('pdfFileUpload')->getData();

                if ($pdfFile) {
                    // Don't delete the old file as it might be used in other certifications
                    $newFilename = $this->handleFileUpload($pdfFile);
                    $certification->setPdfFile($newFilename);
                }
            }

            $this->entityManager->flush();

            $this->addFlash('success', 'La certification a été modifiée avec succès.');

            return $this->redirectToRoute('admin_certifications_index');
        }

        return $this->render('admin/certifications/form.html.twig', [
            'certification' => $certification,
            'form' => $form,
            'page_title' => 'Modifier la certification',
        ]);
    }

    #[Route('/{id}/delete', name: 'admin_certifications_delete', methods: ['POST'])]
    public function delete(Request $request, Certification $certification): Response
    {
        if ($this->isCsrfTokenValid('delete'.$certification->getId(), $request->request->get('_token'))) {
            // Don't delete the PDF file from the media library
            // It might be used elsewhere or the user might want to reuse it

            $this->entityManager->remove($certification);
            $this->entityManager->flush();

            $this->addFlash('success', 'La certification a été supprimée avec succès.');
        }

        return $this->redirectToRoute('admin_certifications_index');
    }

    #[Route('/{id}/toggle-visibility', name: 'admin_certifications_toggle_visibility', methods: ['POST'])]
    public function toggleVisibility(Certification $certification): JsonResponse
    {
        $certification->setIsVisible(!$certification->isVisible());
        $this->entityManager->flush();

        return new JsonResponse([
            'success' => true,
            'isVisible' => $certification->isVisible(),
        ]);
    }

    #[Route('/reorder', name: 'admin_certifications_reorder', methods: ['POST'])]
    public function reorder(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        $order = $data['order'] ?? [];

        foreach ($order as $position => $id) {
            $certification = $this->certificationRepository->find($id);
            if ($certification) {
                $certification->setDisplayOrder($position + 1);
            }
        }

        $this->entityManager->flush();

        return new JsonResponse(['success' => true]);
    }

    #[Route('/{id}/delete-pdf', name: 'admin_certifications_delete_pdf', methods: ['POST'])]
    public function deletePdf(Certification $certification): JsonResponse
    {
        if ($certification->getPdfFile()) {
            $this->deleteFile($certification->getPdfFile());
            $certification->setPdfFile(null);
            $this->entityManager->flush();

            return new JsonResponse(['success' => true]);
        }

        return new JsonResponse(['success' => false, 'error' => 'Aucun fichier à supprimer'], 400);
    }

    /**
     * Handle file upload and return the new filename
     * Files are uploaded to /public/uploads to be consistent with the media library
     */
    private function handleFileUpload(UploadedFile $file): string
    {
        $originalFilename = pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME);
        $safeFilename = $this->slugger->slug($originalFilename);
        $newFilename = $safeFilename.'-'.uniqid().'.'.$file->guessExtension();

        try {
            $uploadsDir = $this->getParameter('kernel.project_dir') . '/public/uploads';
            if (!is_dir($uploadsDir)) {
                mkdir($uploadsDir, 0755, true);
            }

            $file->move($uploadsDir, $newFilename);
        } catch (FileException $e) {
            throw new \RuntimeException('Erreur lors de l\'upload du fichier: ' . $e->getMessage());
        }

        return $newFilename;
    }
}
