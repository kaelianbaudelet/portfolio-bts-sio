<?php

namespace App\Controller;

use App\Repository\ProjectRepository;
use App\Repository\ProjectFileRepository;
use App\Repository\ProjectImageRepository;
use App\Repository\PreuveRepository;
use App\Twig\MarkdownExtension;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class ProjectsController extends AbstractController
{
    #[Route('/projects', name: 'app_projects')]
    public function index(ProjectRepository $projectRepository): Response
    {
        // Récupérer tous les projets visibles, triés par ordre d'affichage
        $projects = $projectRepository->findBy(
            ['isVisible' => true],
            ['displayOrder' => 'ASC', 'createdAt' => 'DESC']
        );

        return $this->render('projects/projects.html.twig', [
            'projects' => $projects,
        ]);
    }

    #[Route('/api/projects/{id}', name: 'api_project_details', methods: ['GET'])]
    public function getProjectDetails(int $id, ProjectRepository $projectRepository, ProjectFileRepository $fileRepository, ProjectImageRepository $imageRepository, PreuveRepository $preuveRepository, MarkdownExtension $markdownExtension): JsonResponse
    {
        $project = $projectRepository->find($id);

        if (!$project || !$project->isVisible()) {
            return new JsonResponse(['error' => 'Project not found'], 404);
        }

        // Récupérer les fichiers du projet
        $files = $fileRepository->findByProject($id);
        $filesData = array_map(function ($file) {
            return [
                'id' => $file->getId(),
                'filename' => $file->getFilename(),
                'originalName' => $file->getOriginalName(),
                'fileType' => $file->getFileType(),
                'fileSize' => $file->getFileSizeFormatted(),
                'url' => '/uploads/' . $file->getFilename(),
                'icon' => $file->getIcon(),
            ];
        }, $files);

        // Récupérer les images du carrousel
        $images = $imageRepository->findByProject($id);
        $imagesData = array_map(function ($image) {
            return [
                'id' => $image->getId(),
                'filename' => $image->getFilename(),
                'url' => '/uploads/' . $image->getFilename(),
                'displayOrder' => $image->getDisplayOrder(),
            ];
        }, $images);

        // Serialize technologies
        $technologiesData = [];
        foreach ($project->getTechnologies() as $tech) {
            $technologiesData[] = [
                'id' => $tech->getId(),
                'name' => $tech->getName(),
                'slug' => $tech->getSlug(),
                'icon' => $tech->getIcon(),
            ];
        }

        // Serialize skills
        $skillsData = [];
        foreach ($project->getSkills() as $skill) {
            $skillsData[] = [
                'id' => $skill->getId(),
                'name' => $skill->getName(),
                'code' => $skill->getCode(),
                'description' => $skill->getDescription(),
                'icon' => $skill->getIcon(),
            ];
        }

        // Serialize preuves grouped by skill
        $preuves = $preuveRepository->findByProject($id);
        $preuvesData = [];
        foreach ($preuves as $preuve) {
            $skillId = $preuve->getSkill()?->getId();
            if ($skillId) {
                if (!isset($preuvesData[$skillId])) {
                    $preuvesData[$skillId] = [];
                }
                $preuvesData[$skillId][] = [
                    'id' => $preuve->getId(),
                    'title' => $preuve->getTitle(),
                    'description' => $preuve->getDescription(),
                    'filename' => $preuve->getFilename(),
                    'url' => '/uploads/' . $preuve->getFilename(),
                ];
            }
        }

        // Parse Markdown to HTML
        $fullDescriptionHtml = $markdownExtension->parseMarkdown($project->getFullDescription());

        sleep(1.5);
        return new JsonResponse([
            'id' => $project->getId(),
            'title' => $project->getTitle(),
            'shortDescription' => $project->getShortDescription(),
            'fullDescription' => $project->getFullDescription(),
            'fullDescriptionHtml' => $fullDescriptionHtml,
            'image' => $project->getImage(),
            'images' => $imagesData,
            'technologies' => $technologiesData,
            'skills' => $skillsData,
            'preuves' => $preuvesData,
            'githubUrl' => $project->getGithubUrl(),
            'liveUrl' => $project->getLiveUrl(),
            'startedAt' => $project->getStartDate()?->format('Y-m-d'),
            'endedAt' => $project->getEndDate()?->format('Y-m-d'),
            'createdAt' => $project->getCreatedAt()?->format('Y-m-d'),
            'files' => $filesData,
        ]);
    }
}
