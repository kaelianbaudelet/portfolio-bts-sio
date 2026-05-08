<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

final class Version20260403010000 extends AbstractMigration
{
    public function getDescription(): string
    {
        return 'Create preuve table linked to project and skill';
    }

    public function up(Schema $schema): void
    {
        $this->addSql('CREATE SEQUENCE preuve_id_seq INCREMENT BY 1 MINVALUE 1 START 1');
        $this->addSql('CREATE TABLE preuve (
            id INT NOT NULL DEFAULT nextval(\'preuve_id_seq\'),
            project_id INT NOT NULL,
            skill_id INT NOT NULL,
            title VARCHAR(255) NOT NULL,
            description TEXT DEFAULT NULL,
            filename VARCHAR(255) NOT NULL,
            display_order INT NOT NULL DEFAULT 0,
            created_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
            PRIMARY KEY(id)
        )');
        $this->addSql('CREATE INDEX IDX_preuve_project ON preuve (project_id)');
        $this->addSql('CREATE INDEX IDX_preuve_skill ON preuve (skill_id)');
        $this->addSql('COMMENT ON COLUMN preuve.created_at IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('ALTER TABLE preuve ADD CONSTRAINT FK_preuve_project FOREIGN KEY (project_id) REFERENCES project (id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE preuve ADD CONSTRAINT FK_preuve_skill FOREIGN KEY (skill_id) REFERENCES skill (id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE');
    }

    public function down(Schema $schema): void
    {
        $this->addSql('ALTER TABLE preuve DROP CONSTRAINT FK_preuve_project');
        $this->addSql('ALTER TABLE preuve DROP CONSTRAINT FK_preuve_skill');
        $this->addSql('DROP TABLE preuve');
        $this->addSql('DROP SEQUENCE preuve_id_seq');
    }
}
