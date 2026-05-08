<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20251102173710 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE contact_message (id SERIAL NOT NULL, name VARCHAR(255) NOT NULL, email VARCHAR(255) NOT NULL, subject VARCHAR(255) NOT NULL, message TEXT NOT NULL, created_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, is_read BOOLEAN NOT NULL, PRIMARY KEY(id))');
        $this->addSql('COMMENT ON COLUMN contact_message.created_at IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('CREATE TABLE education (id SERIAL NOT NULL, degree VARCHAR(255) NOT NULL, institution VARCHAR(255) NOT NULL, start_date VARCHAR(100) NOT NULL, end_date VARCHAR(100) NOT NULL, description TEXT DEFAULT NULL, display_order INT NOT NULL, is_visible BOOLEAN NOT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE TABLE experience (id SERIAL NOT NULL, position VARCHAR(255) NOT NULL, company VARCHAR(255) NOT NULL, start_date VARCHAR(100) NOT NULL, end_date VARCHAR(100) NOT NULL, description TEXT DEFAULT NULL, responsibilities JSON DEFAULT NULL, display_order INT NOT NULL, is_visible BOOLEAN NOT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE TABLE project (id SERIAL NOT NULL, title VARCHAR(255) NOT NULL, short_description TEXT NOT NULL, full_description TEXT DEFAULT NULL, image VARCHAR(255) DEFAULT NULL, technologies JSON NOT NULL, github_url VARCHAR(255) DEFAULT NULL, live_url VARCHAR(255) DEFAULT NULL, display_order INT NOT NULL, is_visible BOOLEAN NOT NULL, created_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, updated_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, PRIMARY KEY(id))');
        $this->addSql('COMMENT ON COLUMN project.created_at IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('COMMENT ON COLUMN project.updated_at IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('CREATE TABLE skill (id SERIAL NOT NULL, name VARCHAR(255) NOT NULL, category VARCHAR(100) NOT NULL, proficiency INT DEFAULT NULL, icon VARCHAR(255) DEFAULT NULL, display_order INT NOT NULL, is_visible BOOLEAN NOT NULL, PRIMARY KEY(id))');
        $this->addSql('ALTER TABLE "user" ADD username VARCHAR(180) NOT NULL');
        $this->addSql('CREATE UNIQUE INDEX UNIQ_8D93D649F85E0677 ON "user" (username)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('DROP TABLE contact_message');
        $this->addSql('DROP TABLE education');
        $this->addSql('DROP TABLE experience');
        $this->addSql('DROP TABLE project');
        $this->addSql('DROP TABLE skill');
        $this->addSql('DROP INDEX UNIQ_8D93D649F85E0677');
        $this->addSql('ALTER TABLE "user" DROP username');
    }
}
