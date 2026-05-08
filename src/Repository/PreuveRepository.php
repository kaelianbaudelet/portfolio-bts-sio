<?php

namespace App\Repository;

use App\Entity\Preuve;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Preuve>
 */
class PreuveRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Preuve::class);
    }

    /**
     * Find all preuves for a specific project and skill
     */
    public function findByProjectAndSkill(int $projectId, int $skillId): array
    {
        return $this->createQueryBuilder('p')
            ->where('p.project = :projectId')
            ->andWhere('p.skill = :skillId')
            ->setParameter('projectId', $projectId)
            ->setParameter('skillId', $skillId)
            ->orderBy('p.displayOrder', 'ASC')
            ->addOrderBy('p.createdAt', 'ASC')
            ->getQuery()
            ->getResult();
    }

    /**
     * Find all preuves for a project
     */
    public function findByProject(int $projectId): array
    {
        return $this->createQueryBuilder('p')
            ->where('p.project = :projectId')
            ->setParameter('projectId', $projectId)
            ->orderBy('p.displayOrder', 'ASC')
            ->addOrderBy('p.createdAt', 'ASC')
            ->getQuery()
            ->getResult();
    }
}
