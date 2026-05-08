<?php

namespace App\Controller;

use App\Repository\TechWatchArticleRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class TechWatchController extends AbstractController
{
    public function __construct(
        private TechWatchArticleRepository $articleRepository
    ) {}

    #[Route('/tech-watch', name: 'app_tech_watch')]
    public function index(): Response
    {
        $articles = $this->articleRepository->findVisibleArticles();

        return $this->render('tech_watch/tech_watch.html.twig', [
            'articles' => $articles,
        ]);
    }
}
