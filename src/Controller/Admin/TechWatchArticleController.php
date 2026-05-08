<?php

namespace App\Controller\Admin;

use App\Entity\TechWatchArticle;
use App\Repository\TechWatchArticleRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/admin/tech-watch-articles')]
#[IsGranted('ROLE_ADMIN')]
class TechWatchArticleController extends AbstractController
{
    public function __construct(
        private EntityManagerInterface $entityManager,
        private TechWatchArticleRepository $articleRepository
    ) {}

    #[Route('', name: 'admin_tech_watch_articles')]
    public function index(): Response
    {
        $articles = $this->articleRepository->findAllOrdered();

        return $this->render('admin/tech_watch_articles/index.html.twig', [
            'articles' => $articles,
        ]);
    }

    #[Route('/new', name: 'admin_tech_watch_article_new', methods: ['GET', 'POST'])]
    public function new(Request $request): Response
    {
        if ($request->isMethod('POST')) {
            $article = new TechWatchArticle();
            $this->populateArticleFromRequest($article, $request);

            $this->entityManager->persist($article);
            $this->entityManager->flush();

            $this->addFlash('success', 'Article de veille technologique créé avec succès !');
            return $this->redirectToRoute('admin_tech_watch_articles');
        }

        return $this->render('admin/tech_watch_articles/form.html.twig', [
            'article' => null,
        ]);
    }

    #[Route('/{id}/edit', name: 'admin_tech_watch_article_edit', methods: ['GET', 'POST'])]
    public function edit(int $id, Request $request): Response
    {
        $article = $this->articleRepository->find($id);

        if (!$article) {
            throw $this->createNotFoundException('Article non trouvé');
        }

        if ($request->isMethod('POST')) {
            $this->populateArticleFromRequest($article, $request);
            $article->setUpdatedAt(new \DateTimeImmutable());

            $this->entityManager->flush();

            $this->addFlash('success', 'Article modifié avec succès !');
            return $this->redirectToRoute('admin_tech_watch_articles');
        }

        return $this->render('admin/tech_watch_articles/form.html.twig', [
            'article' => $article,
        ]);
    }

    #[Route('/{id}/delete', name: 'admin_tech_watch_article_delete', methods: ['POST'])]
    public function delete(int $id): JsonResponse
    {
        $article = $this->articleRepository->find($id);

        if (!$article) {
            return new JsonResponse(['success' => false, 'error' => 'Article non trouvé'], 404);
        }

        $this->entityManager->remove($article);
        $this->entityManager->flush();

        return new JsonResponse(['success' => true]);
    }

    private function populateArticleFromRequest(TechWatchArticle $article, Request $request): void
    {
        $article->setTitle($request->request->get('title'));
        $article->setDescription($request->request->get('description'));
        $article->setAuthor($request->request->get('author'));
        $article->setArticleUrl($request->request->get('articleUrl'));
        $article->setImage($request->request->get('image'));
        $article->setDisplayOrder((int) $request->request->get('displayOrder', 0));
        $article->setIsVisible($request->request->get('isVisible') === '1');

        // Published date
        $publishedAt = $request->request->get('publishedAt');
        if ($publishedAt) {
            $article->setPublishedAt(new \DateTimeImmutable($publishedAt));
        }
    }
}
