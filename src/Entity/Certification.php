<?php

namespace App\Entity;

use App\Repository\CertificationRepository;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;

#[ORM\Entity(repositoryClass: CertificationRepository::class)]
#[ORM\HasLifecycleCallbacks]
class Certification
{
    // Types de documents
    public const TYPE_CERTIFICATION = 'certification';
    public const TYPE_DIPLOME = 'diplome';
    public const TYPE_ATTESTATION = 'attestation';

    public const TYPES = [
        'Certification' => self::TYPE_CERTIFICATION,
        'Diplôme' => self::TYPE_DIPLOME,
        'Attestation' => self::TYPE_ATTESTATION,
    ];

    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    #[Assert\NotBlank(message: 'Le nom est obligatoire')]
    #[Assert\Length(
        max: 255,
        maxMessage: 'Le nom ne peut pas dépasser {{ limit }} caractères'
    )]
    private ?string $name = null;

    #[ORM\Column(length: 50)]
    #[Assert\NotBlank(message: 'Le type est obligatoire')]
    #[Assert\Choice(
        choices: [self::TYPE_CERTIFICATION, self::TYPE_DIPLOME, self::TYPE_ATTESTATION],
        message: 'Type invalide'
    )]
    private ?string $type = self::TYPE_CERTIFICATION;

    #[ORM\Column(length: 255)]
    #[Assert\NotBlank(message: 'L\'émetteur est obligatoire')]
    #[Assert\Length(
        max: 255,
        maxMessage: 'Le nom de l\'émetteur ne peut pas dépasser {{ limit }} caractères'
    )]
    private ?string $issuer = null;

    #[ORM\Column(length: 100)]
    #[Assert\NotBlank(message: 'L\'identifiant de l\'émetteur est obligatoire')]
    #[Assert\Length(
        max: 100,
        maxMessage: 'L\'identifiant ne peut pas dépasser {{ limit }} caractères'
    )]
    #[Assert\Regex(
        pattern: '/^[a-z0-9-]+$/',
        message: 'L\'identifiant ne peut contenir que des lettres minuscules, chiffres et tirets'
    )]
    private ?string $issuerSlug = null;

    #[ORM\Column(type: Types::TEXT, nullable: true)]
    #[Assert\Length(
        max: 1000,
        maxMessage: 'La description ne peut pas dépasser {{ limit }} caractères'
    )]
    private ?string $description = null;

    #[ORM\Column(length: 255, nullable: true)]
    #[Assert\Length(
        max: 255,
        maxMessage: 'Le sous-titre ne peut pas dépasser {{ limit }} caractères'
    )]
    private ?string $subtitle = null;

    #[ORM\Column(type: Types::DATE_MUTABLE)]
    #[Assert\NotBlank(message: 'La date d\'obtention est obligatoire')]
    private ?\DateTimeInterface $obtainedAt = null;

    #[ORM\Column(type: Types::DATE_MUTABLE, nullable: true)]
    #[Assert\GreaterThan(
        propertyPath: 'obtainedAt',
        message: 'La date d\'expiration doit être postérieure à la date d\'obtention'
    )]
    private ?\DateTimeInterface $expiresAt = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $pdfFile = null;

    #[ORM\Column(length: 255, nullable: true)]
    #[Assert\Url(message: 'L\'URL de vérification doit être valide')]
    private ?string $verificationUrl = null;

    #[ORM\Column(length: 100, nullable: true)]
    private ?string $credentialId = null;

    #[ORM\Column]
    private ?bool $isVisible = true;

    #[ORM\Column]
    private ?int $displayOrder = 0;

    #[ORM\Column]
    private ?\DateTimeImmutable $createdAt = null;

    #[ORM\Column]
    private ?\DateTimeImmutable $updatedAt = null;

    public function __construct()
    {
        $this->createdAt = new \DateTimeImmutable();
        $this->updatedAt = new \DateTimeImmutable();
        $this->isVisible = true;
        $this->displayOrder = 0;
    }

    #[ORM\PreUpdate]
    public function setUpdatedAtValue(): void
    {
        $this->updatedAt = new \DateTimeImmutable();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): static
    {
        $this->name = $name;

        return $this;
    }

    public function getType(): ?string
    {
        return $this->type;
    }

    public function setType(string $type): static
    {
        $this->type = $type;

        return $this;
    }

    public function getTypeLabel(): string
    {
        return match($this->type) {
            self::TYPE_CERTIFICATION => 'Certification',
            self::TYPE_DIPLOME => 'Diplôme',
            self::TYPE_ATTESTATION => 'Attestation',
            default => $this->type,
        };
    }

    public function getIssuer(): ?string
    {
        return $this->issuer;
    }

    public function setIssuer(string $issuer): static
    {
        $this->issuer = $issuer;

        return $this;
    }

    public function getIssuerSlug(): ?string
    {
        return $this->issuerSlug;
    }

    public function setIssuerSlug(string $issuerSlug): static
    {
        $this->issuerSlug = $issuerSlug;

        return $this;
    }

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function setDescription(?string $description): static
    {
        $this->description = $description;

        return $this;
    }

    public function getSubtitle(): ?string
    {
        return $this->subtitle;
    }

    public function setSubtitle(?string $subtitle): static
    {
        $this->subtitle = $subtitle;

        return $this;
    }

    public function getObtainedAt(): ?\DateTimeInterface
    {
        return $this->obtainedAt;
    }

    public function setObtainedAt(\DateTimeInterface $obtainedAt): static
    {
        $this->obtainedAt = $obtainedAt;

        return $this;
    }

    public function getObtainedYear(): ?int
    {
        return $this->obtainedAt ? (int) $this->obtainedAt->format('Y') : null;
    }

    public function getObtainedAtFormatted(): ?string
    {
        if (!$this->obtainedAt) {
            return null;
        }

        $months = [
            1 => 'Janvier', 2 => 'Février', 3 => 'Mars', 4 => 'Avril',
            5 => 'Mai', 6 => 'Juin', 7 => 'Juillet', 8 => 'Août',
            9 => 'Septembre', 10 => 'Octobre', 11 => 'Novembre', 12 => 'Décembre'
        ];

        $month = (int) $this->obtainedAt->format('n');
        $year = $this->obtainedAt->format('Y');

        return $months[$month] . ' ' . $year;
    }

    public function getExpiresAt(): ?\DateTimeInterface
    {
        return $this->expiresAt;
    }

    public function setExpiresAt(?\DateTimeInterface $expiresAt): static
    {
        $this->expiresAt = $expiresAt;

        return $this;
    }

    public function isExpired(): bool
    {
        if (!$this->expiresAt) {
            return false;
        }

        return $this->expiresAt < new \DateTime();
    }

    public function getPdfFile(): ?string
    {
        return $this->pdfFile;
    }

    public function setPdfFile(?string $pdfFile): static
    {
        $this->pdfFile = $pdfFile;

        return $this;
    }

    public function getPdfUrl(): ?string
    {
        if (!$this->pdfFile) {
            return null;
        }

        return '/uploads/' . $this->pdfFile;
    }

    public function getVerificationUrl(): ?string
    {
        return $this->verificationUrl;
    }

    public function setVerificationUrl(?string $verificationUrl): static
    {
        $this->verificationUrl = $verificationUrl;

        return $this;
    }

    public function getCredentialId(): ?string
    {
        return $this->credentialId;
    }

    public function setCredentialId(?string $credentialId): static
    {
        $this->credentialId = $credentialId;

        return $this;
    }

    public function isVisible(): ?bool
    {
        return $this->isVisible;
    }

    public function setIsVisible(bool $isVisible): static
    {
        $this->isVisible = $isVisible;

        return $this;
    }

    public function getDisplayOrder(): ?int
    {
        return $this->displayOrder;
    }

    public function setDisplayOrder(int $displayOrder): static
    {
        $this->displayOrder = $displayOrder;

        return $this;
    }

    public function getCreatedAt(): ?\DateTimeImmutable
    {
        return $this->createdAt;
    }

    public function setCreatedAt(\DateTimeImmutable $createdAt): static
    {
        $this->createdAt = $createdAt;

        return $this;
    }

    public function getUpdatedAt(): ?\DateTimeImmutable
    {
        return $this->updatedAt;
    }

    public function setUpdatedAt(\DateTimeImmutable $updatedAt): static
    {
        $this->updatedAt = $updatedAt;

        return $this;
    }
}
