<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class SitemapController extends AbstractController
{
    #[Route('/sitemap', name: 'app_sitemap')]
    public function sitemap(): Response
    {
        return $this->render('sitemap/sitemap.html.twig', []);
    }
}
