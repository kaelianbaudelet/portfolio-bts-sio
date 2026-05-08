<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20251106234630 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE project ADD type VARCHAR(100) DEFAULT NULL');
        $this->addSql('ALTER TABLE project ADD category VARCHAR(100) DEFAULT NULL');
        $this->addSql('ALTER TABLE project ADD start_date DATE DEFAULT NULL');
        $this->addSql('ALTER TABLE project ADD end_date DATE DEFAULT NULL');
        $this->addSql('COMMENT ON COLUMN project.start_date IS \'(DC2Type:date_immutable)\'');
        $this->addSql('COMMENT ON COLUMN project.end_date IS \'(DC2Type:date_immutable)\'');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('ALTER TABLE project DROP type');
        $this->addSql('ALTER TABLE project DROP category');
        $this->addSql('ALTER TABLE project DROP start_date');
        $this->addSql('ALTER TABLE project DROP end_date');
    }
}
