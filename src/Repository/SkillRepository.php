<?php

namespace App\Repository;

use App\Entity\Skill;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Skill>
 */
class SkillRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Skill::class);
    }

    public function findAllVisible(): array
    {
        return $this->createQueryBuilder('s')
            ->where('s.isVisible = :visible')
            ->setParameter('visible', true)
            ->orderBy('s.code', 'ASC')
            ->addOrderBy('s.displayOrder', 'ASC')
            ->getQuery()
            ->getResult();
    }

    public function findAllOrdered(): array
    {
        return $this->createQueryBuilder('s')
            ->orderBy('s.code', 'ASC')
            ->addOrderBy('s.displayOrder', 'ASC')
            ->getQuery()
            ->getResult();
    }

    public function findByCode(string $code): array
    {
        return $this->createQueryBuilder('s')
            ->where('s.code = :code')
            ->andWhere('s.isVisible = :visible')
            ->setParameter('code', $code)
            ->setParameter('visible', true)
            ->orderBy('s.displayOrder', 'ASC')
            ->getQuery()
            ->getResult();
    }
}
