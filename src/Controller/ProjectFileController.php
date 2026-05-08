<?php

namespace App\Controller;

use App\Entity\Project;
use App\Entity\ProjectFile;
use App\Repository\ProjectFileRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\String\Slugger\SluggerInterface;

#[Route('/admin/project/{projectId}/files')]
class ProjectFileController extends AbstractController
{
    #[Route('', name: 'admin_project_files', methods: ['GET'])]
    public function index(int $projectId, ProjectFileRepository $repository): JsonResponse
    {
        $files = $repository->findByProject($projectId);

        $filesData = array_map(function (ProjectFile $file) {
            return [
                'id' => $file->getId(),
                'filename' => $file->getFilename(),
                'originalName' => $file->getOriginalName(),
                'fileType' => $file->getFileType(),
                'fileSize' => $file->getFileSize(),
                'fileSizeFormatted' => $file->getFileSizeFormatted(),
                'mimeType' => $file->getMimeType(),
                'url' => '/uploads/' . $file->getFilename(),
                'uploadedAt' => $file->getUploadedAt()->format('Y-m-d H:i:s'),
                'icon' => $file->getIcon(),
            ];
        }, $files);

        return new JsonResponse($filesData);
    }

    #[Route('/upload', name: 'admin_project_files_upload', methods: ['POST'])]
    public function upload(
        int $projectId,
        Request $request,
        EntityManagerInterface $em,
        SluggerInterface $slugger
    ): JsonResponse {
        $project = $em->getRepository(Project::class)->find($projectId);
        if (!$project) {
            return new JsonResponse(['error' => 'Projet non trouvé'], 404);
        }

        $file = $request->files->get('file');
        if (!$file) {
            return new JsonResponse(['error' => 'Aucun fichier fourni'], 400);
        }

        $mimeType = $file->getMimeType();

        // Types de fichiers autorisés
        $allowedMimeTypes = [
            'application/pdf',
            'application/msword',
            'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
            'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
            'application/vnd.ms-excel',
            'text/plain',
            'application/zip',
            'application/x-rar-compressed',
            'application/x-7z-compressed',
            'application/x-tar',
            'application/gzip',
        ];

        if (!in_array($mimeType, $allowedMimeTypes)) {
            return new JsonResponse(['error' => 'Type de fichier non autorisé'], 400);
        }

        // Max 20MB
        if ($file->getSize() > 20 * 1024 * 1024) {
            return new JsonResponse(['error' => 'Le fichier est trop volumineux (max 20MB)'], 400);
        }

        $originalFilename = $file->getClientOriginalName();
        $safeFilename = $slugger->slug(pathinfo($originalFilename, PATHINFO_FILENAME));
        $extension = $file->guessExtension();
        $newFilename = $safeFilename . '-' . uniqid() . '.' . $extension;

        // Store file size BEFORE moving
        $fileSize = $file->getSize();

        try {
            $uploadsDir = $this->getParameter('kernel.project_dir') . '/public/uploads';
            if (!is_dir($uploadsDir)) {
                mkdir($uploadsDir, 0755, true);
            }

            $file->move($uploadsDir, $newFilename);

            // Créer l'entité ProjectFile
            $projectFile = new ProjectFile();
            $projectFile->setProject($project);
            $projectFile->setFilename($newFilename);
            $projectFile->setOriginalName($originalFilename);
            $projectFile->setMimeType($mimeType);
            $projectFile->setFileSize($fileSize);
            $projectFile->setFileType($this->getFileType($mimeType));

            $em->persist($projectFile);
            $em->flush();

            return new JsonResponse([
                'success' => true,
                'file' => [
                    'id' => $projectFile->getId(),
                    'filename' => $projectFile->getFilename(),
                    'originalName' => $projectFile->getOriginalName(),
                    'fileType' => $projectFile->getFileType(),
                    'fileSize' => $projectFile->getFileSize(),
                    'fileSizeFormatted' => $projectFile->getFileSizeFormatted(),
                    'url' => '/uploads/' . $projectFile->getFilename(),
                    'icon' => $projectFile->getIcon(),
                ]
            ]);
        } catch (FileException $e) {
            return new JsonResponse(['error' => 'Erreur lors de l\'upload: ' . $e->getMessage()], 500);
        }
    }

    #[Route('/attach', name: 'admin_project_files_attach', methods: ['POST'])]
    public function attach(
        int $projectId,
        Request $request,
        EntityManagerInterface $em
    ): JsonResponse {
        $project = $em->getRepository(Project::class)->find($projectId);
        if (!$project) {
            return new JsonResponse(['error' => 'Projet non trouvé'], 404);
        }

        $data = json_decode($request->getContent(), true);
        $filename = $data['filename'] ?? null;

        if (!$filename) {
            return new JsonResponse(['error' => 'Nom de fichier manquant'], 400);
        }

        // Vérifier que le fichier existe physiquement
        $filePath = $this->getParameter('kernel.project_dir') . '/public/uploads/' . $filename;
        if (!file_exists($filePath)) {
            return new JsonResponse(['error' => 'Fichier non trouvé sur le serveur'], 404);
        }

        // Vérifier si le fichier n'est pas déjà attaché au projet
        $existingFile = $em->getRepository(ProjectFile::class)->findOneBy([
            'project' => $project,
            'filename' => $filename
        ]);

        if ($existingFile) {
            return new JsonResponse(['error' => 'Ce fichier est déjà attaché au projet'], 400);
        }

        // Récupérer les infos du fichier
        $fileSize = filesize($filePath);
        $mimeType = mime_content_type($filePath);
        $originalName = $filename; // On garde le nom du fichier comme nom original

        // Créer l'entité ProjectFile
        $projectFile = new ProjectFile();
        $projectFile->setProject($project);
        $projectFile->setFilename($filename);
        $projectFile->setOriginalName($originalName);
        $projectFile->setMimeType($mimeType);
        $projectFile->setFileSize($fileSize);
        $projectFile->setFileType($this->getFileType($mimeType));

        $em->persist($projectFile);
        $em->flush();

        return new JsonResponse([
            'success' => true,
            'file' => [
                'id' => $projectFile->getId(),
                'filename' => $projectFile->getFilename(),
                'originalName' => $projectFile->getOriginalName(),
                'fileType' => $projectFile->getFileType(),
                'fileSize' => $projectFile->getFileSize(),
                'fileSizeFormatted' => $projectFile->getFileSizeFormatted(),
                'url' => '/uploads/' . $projectFile->getFilename(),
                'icon' => $projectFile->getIcon(),
            ]
        ]);
    }

    #[Route('/{fileId}', name: 'admin_project_files_delete', methods: ['DELETE'])]
    public function delete(int $projectId, int $fileId, EntityManagerInterface $em): JsonResponse
    {
        $projectFile = $em->getRepository(ProjectFile::class)->find($fileId);

        if (!$projectFile || $projectFile->getProject()->getId() !== $projectId) {
            return new JsonResponse(['error' => 'Fichier non trouvé'], 404);
        }

        // Ne pas supprimer le fichier physique, juste détacher du projet
        // Le fichier reste dans la galerie et peut être réutilisé

        // Supprimer uniquement l'entité (le lien entre le fichier et le projet)
        $em->remove($projectFile);
        $em->flush();

        return new JsonResponse(['success' => true]);
    }

    private function getFileType(string $mimeType): string
    {
        if (in_array($mimeType, ['application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'text/plain'])) {
            return 'document';
        }
        if (in_array($mimeType, ['application/zip', 'application/x-rar-compressed', 'application/x-7z-compressed', 'application/x-tar', 'application/gzip'])) {
            return 'archive';
        }
        return 'other';
    }
}
