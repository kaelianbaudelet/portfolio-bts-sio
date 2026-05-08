<?php

namespace App\Controller;

use App\Entity\ContactMessage;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Mime\Email;

final class ContactController extends AbstractController
{
    #[Route('/contact', name: 'app_contact', methods: ['GET', 'POST'])]
    public function index(Request $request, MailerInterface $mailer, EntityManagerInterface $entityManager): Response
    {
        $success = false;
        $error = null;
        $name = '';
        $email = '';
        $subject = '';
        $message = '';

        if ($request->isMethod('POST')) {
            // Récupération des données du formulaire
            $name = trim($request->request->get('name', ''));
            $email = trim($request->request->get('email', ''));
            $subject = trim($request->request->get('subject', ''));
            $message = trim($request->request->get('message', ''));

            // Validation basique
            if (empty($name) || empty($email) || empty($subject) || empty($message)) {
                $error = 'Tous les champs sont obligatoires.';
            } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
                $error = 'L\'adresse email n\'est pas valide.';
            } else {
                try {
                    // Sauvegarde dans la base de données
                    $contactMessage = new ContactMessage();
                    $contactMessage->setName($name);
                    $contactMessage->setEmail($email);
                    $contactMessage->setSubject($subject);
                    $contactMessage->setMessage($message);

                    $entityManager->persist($contactMessage);
                    $entityManager->flush();

                    // Création de l'email pour vous
                    $emailToSend = (new Email())
                        ->from('contact@kaelian.dev')
                        ->to('contact@kaelian.dev')
                        ->replyTo($email)
                        ->subject('Portfolio - Nouveau message : ' . $subject)
                        ->html($this->renderEmailContent($name, $email, $subject, $message));

                    // Envoi de l'email
                    $mailer->send($emailToSend);

                    $success = true;
                    // Réinitialiser les champs après envoi réussi
                    $name = '';
                    $email = '';
                    $subject = '';
                    $message = '';
                } catch (\Exception $e) {
                    $error = 'Une erreur est survenue lors de l\'envoi du message. Veuillez réessayer plus tard.';
                    // Pour le débogage (à retirer en production)
                    // $error = 'Erreur : ' . $e->getMessage();
                }
            }
        }

        return $this->render('contact/contact.html.twig', [
            'success' => $success,
            'error' => $error,
            'name' => $name,
            'email' => $email,
            'subject' => $subject,
            'message' => $message,
        ]);
    }

    private function renderEmailContent(string $name, string $email, string $subject, string $message): string
    {
        return sprintf(
            '<html>
                <head>
                    <style>
                        body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
                        .container { max-width: 600px; margin: 0 auto; padding: 20px; }
                        .header { background: linear-gradient(135deg, #0ea5e9, #38bdf8); color: white; padding: 20px; border-radius: 8px 8px 0 0; }
                        .content { background: #f8f9fa; padding: 30px; border-radius: 0 0 8px 8px; }
                        .info-row { margin-bottom: 15px; }
                        .label { font-weight: bold; color: #0ea5e9; }
                        .message-box { background: white; padding: 20px; border-left: 4px solid #0ea5e9; margin-top: 20px; }
                    </style>
                </head>
                <body>
                    <div class="container">
                        <div class="header">
                            <h2>Nouveau message depuis le portfolio</h2>
                        </div>
                        <div class="content">
                            <div class="info-row">
                                <span class="label">De :</span> %s
                            </div>
                            <div class="info-row">
                                <span class="label">Email :</span> <a href="mailto:%s">%s</a>
                            </div>
                            <div class="info-row">
                                <span class="label">Sujet :</span> %s
                            </div>
                            <div class="message-box">
                                <p><strong>Message :</strong></p>
                                <p>%s</p>
                            </div>
                        </div>
                    </div>
                </body>
            </html>',
            htmlspecialchars($name),
            htmlspecialchars($email),
            htmlspecialchars($email),
            htmlspecialchars($subject),
            nl2br(htmlspecialchars($message))
        );
    }
}
