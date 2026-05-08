<?php

namespace App\Controller;

use App\Repository\InternshipRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class InternshipsController extends AbstractController
{
    #[Route('/internships', name: 'app_internships')]
    public function index(InternshipRepository $internshipRepository): Response
    {
        $internshipsByYear = $internshipRepository->findGroupedByYear();

        return $this->render('internships/internships.html.twig', [
            'internshipsByYear' => $internshipsByYear,
        ]);
    }

    #[Route('/api/internships/{id}', name: 'api_internship_details', methods: ['GET'])]
    public function getInternshipDetails(int $id, InternshipRepository $internshipRepository): JsonResponse
    {
        $internship = $internshipRepository->find($id);

        if (!$internship || !$internship->isVisible()) {
            return new JsonResponse(['error' => 'Stage non trouvé'], 404);
        }

        $projects = [];
        foreach ($internship->getProjects() as $project) {
            $projects[] = [
                'id' => $project->getId(),
                'title' => $project->getTitle(),
                'shortDescription' => $project->getShortDescription(),
                'image' => $project->getImage(),
            ];
        }

        // Build logo URL
        $logoUrl = null;
        if ($internship->getCompanyLogo()) {
            $logoUrl = '/uploads/' . $internship->getCompanyLogo();
        }

        return new JsonResponse([
            'id' => $internship->getId(),
            'title' => $internship->getTitle(),
            'company' => $internship->getCompany(),
            'companyLogo' => $logoUrl,
            'startDate' => $internship->getStartDate()?->format('Y-m-d'),
            'endDate' => $internship->getEndDate()?->format('Y-m-d'),
            'shortDescription' => $internship->getShortDescription(),
            'fullDescription' => $internship->getFullDescription(),
            'tasks' => $internship->getTasks(),
            'projects' => $projects,
            'year' => $internship->getYear(),
        ]);
    }
}
