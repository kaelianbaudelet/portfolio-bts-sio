<?php

namespace App\Form;

use App\Entity\Certification;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Component\Form\Extension\Core\Type\FileType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\UrlType;
use Symfony\Component\Form\Extension\Core\Type\CheckboxType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Validator\Constraints\File;

class CertificationType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('name', TextType::class, [
                'label' => 'Nom de la certification',
                'attr' => [
                    'placeholder' => 'Ex: AWS Solutions Architect Associate',
                    'class' => 'form-control'
                ],
                'required' => true,
            ])
            ->add('type', ChoiceType::class, [
                'label' => 'Type',
                'choices' => Certification::TYPES,
                'attr' => ['class' => 'form-select'],
                'required' => true,
            ])
            ->add('issuer', TextType::class, [
                'label' => 'Émetteur (nom complet)',
                'attr' => [
                    'placeholder' => 'Ex: Amazon Web Services',
                    'class' => 'form-control'
                ],
                'required' => true,
                'help' => 'Nom complet de l\'organisme émetteur'
            ])
            ->add('issuerSlug', TextType::class, [
                'label' => 'Identifiant de l\'émetteur',
                'attr' => [
                    'placeholder' => 'Ex: aws, linkedin, google',
                    'class' => 'form-control',
                    'pattern' => '[a-z0-9-]+'
                ],
                'required' => true,
                'help' => 'Identifiant unique en minuscules (lettres, chiffres et tirets uniquement). Utilisé pour le logo et les filtres.'
            ])
            ->add('subtitle', TextType::class, [
                'label' => 'Sous-titre',
                'attr' => [
                    'placeholder' => 'Ex: Professional Certificate',
                    'class' => 'form-control'
                ],
                'required' => false,
                'help' => 'Sous-titre ou spécialisation (optionnel)'
            ])
            ->add('description', TextareaType::class, [
                'label' => 'Description',
                'attr' => [
                    'placeholder' => 'Description courte de la certification (1-2 phrases)',
                    'class' => 'form-control',
                    'rows' => 3
                ],
                'required' => false,
                'help' => 'Description affichée sur la carte (1-2 phrases recommandées)'
            ])
            ->add('obtainedAt', DateType::class, [
                'label' => 'Date d\'obtention',
                'widget' => 'single_text',
                'attr' => ['class' => 'form-control'],
                'required' => true,
            ])
            ->add('expiresAt', DateType::class, [
                'label' => 'Date d\'expiration',
                'widget' => 'single_text',
                'attr' => ['class' => 'form-control'],
                'required' => false,
                'help' => 'Laisser vide si la certification n\'expire pas'
            ])
            ->add('credentialId', TextType::class, [
                'label' => 'ID de certification',
                'attr' => [
                    'placeholder' => 'Ex: ABC-123-XYZ',
                    'class' => 'form-control'
                ],
                'required' => false,
                'help' => 'Numéro de certification ou identifiant unique (optionnel)'
            ])
            ->add('verificationUrl', UrlType::class, [
                'label' => 'URL de vérification',
                'attr' => [
                    'placeholder' => 'https://...',
                    'class' => 'form-control'
                ],
                'required' => false,
                'help' => 'Lien vers la page de vérification de la certification (optionnel)'
            ])
            ->add('pdfFileUpload', FileType::class, [
                'label' => 'Fichier PDF',
                'mapped' => false,
                'required' => false,
                'attr' => [
                    'class' => 'form-control',
                    'accept' => '.pdf'
                ],
                'constraints' => [
                    new File([
                        'maxSize' => '10M',
                        'mimeTypes' => [
                            'application/pdf',
                            'application/x-pdf',
                        ],
                        'mimeTypesMessage' => 'Veuillez uploader un fichier PDF valide',
                    ])
                ],
                'help' => 'PDF de la certification (max 10 Mo). Laisser vide pour conserver le fichier actuel.'
            ])
            ->add('displayOrder', IntegerType::class, [
                'label' => 'Ordre d\'affichage',
                'attr' => [
                    'class' => 'form-control',
                    'min' => 0
                ],
                'required' => false,
                'help' => 'Ordre d\'affichage sur la page (0 = automatique)'
            ])
            ->add('isVisible', CheckboxType::class, [
                'label' => 'Visible sur le site',
                'required' => false,
                'attr' => ['class' => 'form-check-input'],
                'help' => 'Décocher pour masquer temporairement cette certification'
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Certification::class,
        ]);
    }
}
