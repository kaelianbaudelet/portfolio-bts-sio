<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20251107231421 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        // First drop NOT NULL constraint on end_date
        $this->addSql('ALTER TABLE internship ALTER end_date DROP NOT NULL');

        // Convert VARCHAR to DATE with explicit USING clause
        $this->addSql('ALTER TABLE internship ALTER start_date TYPE DATE USING start_date::date');
        $this->addSql('ALTER TABLE internship ALTER end_date TYPE DATE USING end_date::date');

        // Add doctrine comments
        $this->addSql('COMMENT ON COLUMN internship.start_date IS \'(DC2Type:date_immutable)\'');
        $this->addSql('COMMENT ON COLUMN internship.end_date IS \'(DC2Type:date_immutable)\'');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('ALTER TABLE internship ALTER start_date TYPE VARCHAR(100)');
        $this->addSql('ALTER TABLE internship ALTER end_date TYPE VARCHAR(100)');
        $this->addSql('ALTER TABLE internship ALTER end_date SET NOT NULL');
        $this->addSql('COMMENT ON COLUMN internship.start_date IS NULL');
        $this->addSql('COMMENT ON COLUMN internship.end_date IS NULL');
    }
}
