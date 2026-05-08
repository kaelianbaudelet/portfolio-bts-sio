<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20251107224725 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE internship (id SERIAL NOT NULL, title VARCHAR(255) NOT NULL, company VARCHAR(255) NOT NULL, company_logo VARCHAR(255) DEFAULT NULL, start_date VARCHAR(100) NOT NULL, end_date VARCHAR(100) NOT NULL, short_description TEXT DEFAULT NULL, full_description TEXT DEFAULT NULL, tasks JSON DEFAULT NULL, year INT NOT NULL, display_order INT NOT NULL, is_visible BOOLEAN NOT NULL, created_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, updated_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, PRIMARY KEY(id))');
        $this->addSql('COMMENT ON COLUMN internship.created_at IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('COMMENT ON COLUMN internship.updated_at IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('CREATE TABLE internship_project (internship_id INT NOT NULL, project_id INT NOT NULL, PRIMARY KEY(internship_id, project_id))');
        $this->addSql('CREATE INDEX IDX_95A333747A4A70BE ON internship_project (internship_id)');
        $this->addSql('CREATE INDEX IDX_95A33374166D1F9C ON internship_project (project_id)');
        $this->addSql('ALTER TABLE internship_project ADD CONSTRAINT FK_95A333747A4A70BE FOREIGN KEY (internship_id) REFERENCES internship (id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE internship_project ADD CONSTRAINT FK_95A33374166D1F9C FOREIGN KEY (project_id) REFERENCES project (id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('ALTER TABLE internship_project DROP CONSTRAINT FK_95A333747A4A70BE');
        $this->addSql('ALTER TABLE internship_project DROP CONSTRAINT FK_95A33374166D1F9C');
        $this->addSql('DROP TABLE internship');
        $this->addSql('DROP TABLE internship_project');
    }
}
