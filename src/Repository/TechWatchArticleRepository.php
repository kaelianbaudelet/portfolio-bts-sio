<?php

namespace App\Repository;

use App\Entity\TechWatchArticle;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<TechWatchArticle>
 */
class TechWatchArticleRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, TechWatchArticle::class);
    }

    /**
     * Find all articles ordered by display order and date
     */
    public function findAllOrdered(): array
    {
        return $this->createQueryBuilder('t')
            ->orderBy('t.displayOrder', 'ASC')
            ->addOrderBy('t.publishedAt', 'DESC')
            ->getQuery()
            ->getResult();
    }

    /**
     * Find all visible articles ordered by display order and date
     */
    public function findVisibleArticles(): array
    {
        return $this->createQueryBuilder('t')
            ->where('t.isVisible = :visible')
            ->setParameter('visible', true)
            ->orderBy('t.displayOrder', 'ASC')
            ->addOrderBy('t.publishedAt', 'DESC')
            ->getQuery()
            ->getResult();
    }
}
