<?php

namespace App\Repository;

use App\Entity\ProjectFile;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

class ProjectFileRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ProjectFile::class);
    }

    public function findByProject(int $projectId): array
    {
        return $this->createQueryBuilder('pf')
            ->andWhere('pf.project = :projectId')
            ->setParameter('projectId', $projectId)
            ->orderBy('pf.uploadedAt', 'DESC')
            ->getQuery()
            ->getResult();
    }
}
