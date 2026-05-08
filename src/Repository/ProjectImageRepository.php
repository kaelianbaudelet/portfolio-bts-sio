<?php

namespace App\Repository;

use App\Entity\ProjectImage;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<ProjectImage>
 */
class ProjectImageRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ProjectImage::class);
    }

    /**
     * Find all images for a project ordered by display order
     */
    public function findByProject(int $projectId): array
    {
        return $this->createQueryBuilder('pi')
            ->where('pi.project = :projectId')
            ->setParameter('projectId', $projectId)
            ->orderBy('pi.displayOrder', 'ASC')
            ->addOrderBy('pi.createdAt', 'ASC')
            ->getQuery()
            ->getResult();
    }
}
