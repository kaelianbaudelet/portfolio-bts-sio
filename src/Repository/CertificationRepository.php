<?php

namespace App\Repository;

use App\Entity\Certification;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Certification>
 */
class CertificationRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Certification::class);
    }

    /**
     * Find all visible certifications ordered by display order and date
     *
     * @return Certification[]
     */
    public function findAllVisible(): array
    {
        return $this->createQueryBuilder('c')
            ->where('c.isVisible = :visible')
            ->setParameter('visible', true)
            ->orderBy('c.displayOrder', 'ASC')
            ->addOrderBy('c.obtainedAt', 'DESC')
            ->getQuery()
            ->getResult();
    }

    /**
     * Find all certifications for admin (including hidden)
     *
     * @return Certification[]
     */
    public function findAllForAdmin(): array
    {
        return $this->createQueryBuilder('c')
            ->orderBy('c.displayOrder', 'ASC')
            ->addOrderBy('c.obtainedAt', 'DESC')
            ->getQuery()
            ->getResult();
    }

    /**
     * Find certifications by type
     *
     * @return Certification[]
     */
    public function findByType(string $type, bool $onlyVisible = true): array
    {
        $qb = $this->createQueryBuilder('c')
            ->where('c.type = :type')
            ->setParameter('type', $type);

        if ($onlyVisible) {
            $qb->andWhere('c.isVisible = :visible')
                ->setParameter('visible', true);
        }

        return $qb->orderBy('c.displayOrder', 'ASC')
            ->addOrderBy('c.obtainedAt', 'DESC')
            ->getQuery()
            ->getResult();
    }

    /**
     * Find certifications by issuer
     *
     * @return Certification[]
     */
    public function findByIssuer(string $issuerSlug, bool $onlyVisible = true): array
    {
        $qb = $this->createQueryBuilder('c')
            ->where('c.issuerSlug = :issuerSlug')
            ->setParameter('issuerSlug', $issuerSlug);

        if ($onlyVisible) {
            $qb->andWhere('c.isVisible = :visible')
                ->setParameter('visible', true);
        }

        return $qb->orderBy('c.displayOrder', 'ASC')
            ->addOrderBy('c.obtainedAt', 'DESC')
            ->getQuery()
            ->getResult();
    }

    /**
     * Find certifications by year
     *
     * @return Certification[]
     */
    public function findByYear(int $year, bool $onlyVisible = true): array
    {
        $startDate = new \DateTime("$year-01-01 00:00:00");
        $endDate = new \DateTime("$year-12-31 23:59:59");

        $qb = $this->createQueryBuilder('c')
            ->where('c.obtainedAt BETWEEN :startDate AND :endDate')
            ->setParameter('startDate', $startDate)
            ->setParameter('endDate', $endDate);

        if ($onlyVisible) {
            $qb->andWhere('c.isVisible = :visible')
                ->setParameter('visible', true);
        }

        return $qb->orderBy('c.displayOrder', 'ASC')
            ->addOrderBy('c.obtainedAt', 'DESC')
            ->getQuery()
            ->getResult();
    }

    /**
     * Get all unique years from certifications
     *
     * @return array
     */
    public function findAllYears(bool $onlyVisible = true): array
    {
        $qb = $this->createQueryBuilder('c')
            ->select('c.obtainedAt');

        if ($onlyVisible) {
            $qb->where('c.isVisible = :visible')
                ->setParameter('visible', true);
        }

        $results = $qb->orderBy('c.obtainedAt', 'DESC')
            ->getQuery()
            ->getResult();

        // Extract unique years from dates
        $years = [];
        foreach ($results as $result) {
            if ($result['obtainedAt'] instanceof \DateTimeInterface) {
                $year = (int) $result['obtainedAt']->format('Y');
                if (!in_array($year, $years)) {
                    $years[] = $year;
                }
            }
        }

        return $years;
    }

    /**
     * Get all unique issuers
     *
     * @return array
     */
    public function findAllIssuers(bool $onlyVisible = true): array
    {
        $qb = $this->createQueryBuilder('c')
            ->select('DISTINCT c.issuerSlug, c.issuer');

        if ($onlyVisible) {
            $qb->where('c.isVisible = :visible')
                ->setParameter('visible', true);
        }

        return $qb->orderBy('c.issuer', 'ASC')
            ->getQuery()
            ->getResult();
    }

    /**
     * Count certifications by type
     *
     * @return array
     */
    public function countByType(bool $onlyVisible = true): array
    {
        $qb = $this->createQueryBuilder('c')
            ->select('c.type, COUNT(c.id) as count')
            ->groupBy('c.type');

        if ($onlyVisible) {
            $qb->where('c.isVisible = :visible')
                ->setParameter('visible', true);
        }

        $results = $qb->getQuery()->getResult();

        $counts = [];
        foreach ($results as $result) {
            $counts[$result['type']] = $result['count'];
        }

        return $counts;
    }

    /**
     * Find expired certifications
     *
     * @return Certification[]
     */
    public function findExpired(): array
    {
        return $this->createQueryBuilder('c')
            ->where('c.expiresAt IS NOT NULL')
            ->andWhere('c.expiresAt < :now')
            ->setParameter('now', new \DateTime())
            ->orderBy('c.expiresAt', 'ASC')
            ->getQuery()
            ->getResult();
    }

    /**
     * Find certifications expiring soon (within given days)
     *
     * @return Certification[]
     */
    public function findExpiringSoon(int $days = 30): array
    {
        $now = new \DateTime();
        $futureDate = (new \DateTime())->modify("+{$days} days");

        return $this->createQueryBuilder('c')
            ->where('c.expiresAt IS NOT NULL')
            ->andWhere('c.expiresAt BETWEEN :now AND :futureDate')
            ->setParameter('now', $now)
            ->setParameter('futureDate', $futureDate)
            ->orderBy('c.expiresAt', 'ASC')
            ->getQuery()
            ->getResult();
    }
}
