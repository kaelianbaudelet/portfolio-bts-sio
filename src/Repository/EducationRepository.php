<?php

namespace App\Repository;

use App\Entity\Education;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Education>
 */
class EducationRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Education::class);
    }

    public function findAllVisible(): array
    {
        return $this->createQueryBuilder('e')
            ->where('e.isVisible = :visible')
            ->setParameter('visible', true)
            ->orderBy('e.displayOrder', 'ASC')
            ->getQuery()
            ->getResult();
    }

    public function findAllOrdered(): array
    {
        return $this->createQueryBuilder('e')
            ->orderBy('e.displayOrder', 'ASC')
            ->getQuery()
            ->getResult();
    }
}
