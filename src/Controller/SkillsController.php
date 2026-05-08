<?php

namespace App\Controller;

use App\Repository\SkillRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class SkillsController extends AbstractController
{
    #[Route('/skills', name: 'app_skills')]
    public function index(SkillRepository $skillRepository): Response
    {
        $skills = $skillRepository->findBy(
            ['isVisible' => true],
            ['displayOrder' => 'ASC', 'code' => 'ASC']
        );

        return $this->render('skills/skills.html.twig', [
            'skills' => $skills,
        ]);
    }

    #[Route('/api/skills/{id}/projects', name: 'api_skill_projects', methods: ['GET'])]
    public function getSkillProjects(int $id, SkillRepository $skillRepository): JsonResponse
    {
        $skill = $skillRepository->find($id);

        if (!$skill || !$skill->isVisible()) {
            return new JsonResponse(['error' => 'Skill not found'], 404);
        }

        $projects = [];
        foreach ($skill->getProjects() as $project) {
            if ($project->isVisible()) {
                $projects[] = [
                    'id' => $project->getId(),
                    'title' => $project->getTitle(),
                    'shortDescription' => $project->getShortDescription(),
                    'image' => $project->getImage(),
                ];
            }
        }

        return new JsonResponse($projects);
    }
}
