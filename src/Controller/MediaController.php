<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\String\Slugger\SluggerInterface;

#[Route('/admin/media')]
class MediaController extends AbstractController
{
    #[Route('', name: 'admin_media')]
    public function index(): Response
    {
        $uploadsDir = $this->getParameter('kernel.project_dir') . '/public/uploads';

        if (!is_dir($uploadsDir)) {
            mkdir($uploadsDir, 0755, true);
        }

        $files = [];

        if (is_dir($uploadsDir)) {
            $scannedFiles = scandir($uploadsDir);
            foreach ($scannedFiles as $file) {
                if ($file !== '.' && $file !== '..') {
                    $filePath = $uploadsDir . '/' . $file;
                    if (is_file($filePath)) {
                        $mimeType = mime_content_type($filePath);
                        $files[] = [
                            'name' => $file,
                            'size' => filesize($filePath),
                            'date' => filemtime($filePath),
                            'url' => '/uploads/' . $file,
                            'type' => $this->getFileType($mimeType),
                            'mimeType' => $mimeType,
                        ];
                    }
                }
            }
        }

        // Trier par date (plus récent en premier)
        usort($files, fn($a, $b) => $b['date'] <=> $a['date']);

        return $this->render('admin/media.html.twig', [
            'files' => $files,
        ]);
    }

    private function getFileType(string $mimeType): string
    {
        if (str_starts_with($mimeType, 'image/')) {
            return 'image';
        }
        if (in_array($mimeType, ['application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'text/plain'])) {
            return 'document';
        }
        if (in_array($mimeType, ['application/zip', 'application/x-rar-compressed', 'application/x-7z-compressed'])) {
            return 'archive';
        }
        return 'other';
    }

    #[Route('/upload', name: 'admin_media_upload', methods: ['POST'])]
    public function upload(Request $request, SluggerInterface $slugger): JsonResponse
    {
        $file = $request->files->get('file');
        $fileType = $request->request->get('fileType', 'image'); // 'image' or 'file'

        if (!$file) {
            return new JsonResponse(['error' => 'Aucun fichier fourni'], 400);
        }

        $mimeType = $file->getMimeType();

        // Définir les types autorisés selon le type de fichier
        if ($fileType === 'image') {
            $allowedMimeTypes = ['image/jpeg', 'image/png', 'image/gif', 'image/webp', 'image/svg+xml'];
            $maxSize = 5 * 1024 * 1024; // 5MB
        } else {
            // Autoriser PDF, documents, archives
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
            $maxSize = 20 * 1024 * 1024; // 20MB
        }

        if (!in_array($mimeType, $allowedMimeTypes)) {
            return new JsonResponse(['error' => 'Type de fichier non autorisé.'], 400);
        }

        if ($file->getSize() > $maxSize) {
            $maxSizeMB = $maxSize / (1024 * 1024);
            return new JsonResponse(['error' => "Le fichier est trop volumineux (max {$maxSizeMB}MB)"], 400);
        }

        $originalFilename = pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME);
        $safeFilename = $slugger->slug($originalFilename);
        $extension = $file->guessExtension();
        $newFilename = $safeFilename . '-' . uniqid() . '.' . $extension;

        // Store file size before moving
        $fileSize = $file->getSize();

        try {
            $uploadsDir = $this->getParameter('kernel.project_dir') . '/public/uploads';
            if (!is_dir($uploadsDir)) {
                mkdir($uploadsDir, 0755, true);
            }

            $file->move($uploadsDir, $newFilename);

            return new JsonResponse([
                'success' => true,
                'filename' => $newFilename,
                'url' => '/uploads/' . $newFilename,
                'type' => $this->getFileType($mimeType),
                'size' => $fileSize,
            ]);
        } catch (FileException $e) {
            return new JsonResponse(['error' => 'Erreur lors de l\'upload: ' . $e->getMessage()], 500);
        } catch (\Exception $e) {
            return new JsonResponse(['error' => 'Erreur inattendue: ' . $e->getMessage()], 500);
        }
    }

    #[Route('/api/images', name: 'admin_media_api_images', methods: ['GET'])]
    public function getImages(): JsonResponse
    {
        $uploadsDir = $this->getParameter('kernel.project_dir') . '/public/uploads';

        if (!is_dir($uploadsDir)) {
            return new JsonResponse(['images' => []]);
        }

        $images = [];

        if (is_dir($uploadsDir)) {
            $scannedFiles = scandir($uploadsDir);
            foreach ($scannedFiles as $file) {
                if ($file !== '.' && $file !== '..') {
                    $filePath = $uploadsDir . '/' . $file;
                    if (is_file($filePath)) {
                        $mimeType = mime_content_type($filePath);
                        // Ne récupérer que les images
                        if (str_starts_with($mimeType, 'image/')) {
                            $images[] = [
                                'name' => $file,
                                'url' => '/uploads/' . $file,
                                'size' => filesize($filePath),
                                'date' => filemtime($filePath),
                            ];
                        }
                    }
                }
            }
        }

        // Trier par date (plus récent en premier)
        usort($images, fn($a, $b) => $b['date'] <=> $a['date']);

        return new JsonResponse(['images' => $images]);
    }

    #[Route('/api/files', name: 'admin_media_api_files', methods: ['GET'])]
    public function getFiles(): JsonResponse
    {
        $uploadsDir = $this->getParameter('kernel.project_dir') . '/public/uploads';

        if (!is_dir($uploadsDir)) {
            return new JsonResponse(['files' => []]);
        }

        $files = [];

        if (is_dir($uploadsDir)) {
            $scannedFiles = scandir($uploadsDir);
            foreach ($scannedFiles as $file) {
                if ($file !== '.' && $file !== '..') {
                    $filePath = $uploadsDir . '/' . $file;
                    if (is_file($filePath)) {
                        $mimeType = mime_content_type($filePath);
                        $files[] = [
                            'name' => $file,
                            'url' => '/uploads/' . $file,
                            'size' => filesize($filePath),
                            'date' => filemtime($filePath),
                            'type' => $this->getFileType($mimeType),
                            'mimeType' => $mimeType,
                        ];
                    }
                }
            }
        }

        // Trier par date (plus récent en premier)
        usort($files, fn($a, $b) => $b['date'] <=> $a['date']);

        return new JsonResponse(['files' => $files]);
    }

    #[Route('/api/pdfs', name: 'admin_media_api_pdfs', methods: ['GET'])]
    public function getPdfs(): JsonResponse
    {
        $uploadsDir = $this->getParameter('kernel.project_dir') . '/public/uploads';

        if (!is_dir($uploadsDir)) {
            return new JsonResponse(['files' => []]);
        }

        $pdfs = [];

        if (is_dir($uploadsDir)) {
            $scannedFiles = scandir($uploadsDir);
            foreach ($scannedFiles as $file) {
                if ($file !== '.' && $file !== '..') {
                    $filePath = $uploadsDir . '/' . $file;
                    if (is_file($filePath)) {
                        $mimeType = mime_content_type($filePath);
                        // Ne récupérer que les PDFs
                        if ($mimeType === 'application/pdf') {
                            $pdfs[] = [
                                'name' => $file,
                                'url' => '/uploads/' . $file,
                                'size' => filesize($filePath),
                                'date' => filemtime($filePath),
                                'type' => 'document',
                                'mimeType' => $mimeType,
                            ];
                        }
                    }
                }
            }
        }

        // Trier par date (plus récent en premier)
        usort($pdfs, fn($a, $b) => $b['date'] <=> $a['date']);

        return new JsonResponse(['files' => $pdfs]);
    }

    #[Route('/delete/{filename}', name: 'admin_media_delete', methods: ['POST'])]
    public function delete(string $filename): JsonResponse
    {
        $uploadsDir = $this->getParameter('kernel.project_dir') . '/public/uploads';
        $filePath = $uploadsDir . '/' . $filename;

        // Sécurité: vérifier que le fichier est bien dans le dossier uploads
        $realPath = realpath($filePath);
        $realUploadsDir = realpath($uploadsDir);

        if (!$realPath || !str_starts_with($realPath, $realUploadsDir)) {
            return new JsonResponse(['error' => 'Fichier non autorisé'], 403);
        }

        if (file_exists($filePath) && is_file($filePath)) {
            unlink($filePath);
            return new JsonResponse(['success' => true]);
        }

        return new JsonResponse(['error' => 'Fichier non trouvé'], 404);
    }
}
