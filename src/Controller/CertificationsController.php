<?php

namespace App\Controller;

use App\Repository\CertificationRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class CertificationsController extends AbstractController
{
    public function __construct(
        private CertificationRepository $certificationRepository
    ) {}

    #[Route('/certifications', name: 'app_certifications')]
    public function index(): Response
    {
        $certifications = $this->certificationRepository->findAllVisible();
        $years = $this->certificationRepository->findAllYears(true);
        $issuers = $this->certificationRepository->findAllIssuers(true);

        return $this->render('certifications/certifications.html.twig', [
            'certifications' => $certifications,
            'years' => $years,
            'issuers' => $issuers,
        ]);
    }
}
