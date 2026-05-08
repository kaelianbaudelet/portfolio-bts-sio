<?php

namespace App\DataFixtures;

use App\Entity\User;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;

class AppFixtures extends Fixture
{
    public function __construct(
        private UserPasswordHasherInterface $passwordHasher
    ) {}

    public function load(ObjectManager $manager): void
    {
        // Créer un utilisateur admin par défaut
        $admin = new User();
        $admin->setUsername('admin');
        $admin->setEmail('admin@kaelian.dev');
        $admin->setRoles(['ROLE_ADMIN']);

        // Hash le mot de passe
        $hashedPassword = $this->passwordHasher->hashPassword(
            $admin,
            'admin123' // À CHANGER EN PRODUCTION !
        );
        $admin->setPassword($hashedPassword);

        $manager->persist($admin);
        $manager->flush();

        echo "✓ Utilisateur admin créé avec succès!\n";
        echo "  Username: admin\n";
        echo "  Password: admin123\n";
        echo "  ⚠️  ATTENTION: Changez ce mot de passe en production!\n";
    }
}
