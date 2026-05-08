<?php

namespace App\Repository;

use App\Entity\Internship;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Internship>
 */
class InternshipRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Internship::class);
    }

    /**
     * Find all visible internships ordered by year and display order
     */
    public function findAllVisible(): array
    {
        return $this->createQueryBuilder('i')
            ->where('i.isVisible = :visible')
            ->setParameter('visible', true)
            ->orderBy('i.year', 'DESC')
            ->addOrderBy('i.displayOrder', 'ASC')
            ->getQuery()
            ->getResult();
    }

    /**
     * Find all internships for admin panel
     */
    public function findAllOrdered(): array
    {
        return $this->createQueryBuilder('i')
            ->orderBy('i.year', 'DESC')
            ->addOrderBy('i.displayOrder', 'ASC')
            ->getQuery()
            ->getResult();
    }

    /**
     * Find internships grouped by year
     */
    public function findGroupedByYear(): array
    {
        $internships = $this->findAllVisible();
        $grouped = [];

        foreach ($internships as $internship) {
            $year = $internship->getYear();
            if (!isset($grouped[$year])) {
                $grouped[$year] = [];
            }
            $grouped[$year][] = $internship;
        }

        krsort($grouped); // Sort by year descending
        return $grouped;
    }
}
