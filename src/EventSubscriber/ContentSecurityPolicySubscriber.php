<?php

namespace App\EventSubscriber;

use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Symfony\Component\HttpKernel\Event\ResponseEvent;
use Symfony\Component\HttpKernel\KernelEvents;

class ContentSecurityPolicySubscriber implements EventSubscriberInterface
{
    public static function getSubscribedEvents(): array
    {
        return [
            KernelEvents::RESPONSE => ['onKernelResponse', -128],
        ];
    }

    public function onKernelResponse(ResponseEvent $event): void
    {
        if (!$event->isMainRequest()) {
            return;
        }

        $response = $event->getResponse();
        $request = $event->getRequest();

        // Récupérer le nonce s'il existe
        $nonce = $request->attributes->get('csp_nonce');
        $nonceDirective = $nonce ? " 'nonce-{$nonce}'" : " 'unsafe-inline'";

        // Configuration CSP
        $cspDirectives = [
            // Scripts: autorise les scripts du même origine, nonce et Google Maps
            "script-src 'self'{$nonceDirective} https://maps.googleapis.com https://maps.gstatic.com",

            // Workers: autorise uniquement les workers du même origine
            "worker-src 'self' blob:",

            // Styles: autorise les styles du même origine et Google Maps
            "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com",

            // Images: autorise les images locales, data URIs et Google Maps
            "img-src 'self' data: https://maps.googleapis.com https://maps.gstatic.com https://*.googleusercontent.com",

            // Fonts: autorise les fonts locales et Google Fonts
            "font-src 'self' data: https://fonts.gstatic.com",

            // Frames: autorise Google Maps et YouTube
            "frame-src 'self' https://www.google.com https://www.youtube.com",

            // Connexions: autorise les connexions au même origine et Google Maps
            "connect-src 'self' https://maps.googleapis.com",

            // Objets: interdit les plugins
            "object-src 'none'",

            // Base URI: restreint aux URIs du même origine
            "base-uri 'self'",

            // Form actions: autorise uniquement les soumissions au même origine
            "form-action 'self'",

            // Frame ancestors: empêche l'inclusion dans des iframes externes
            "frame-ancestors 'self'",

            // Upgrade insecure requests en HTTPS
            "upgrade-insecure-requests",
        ];

        $cspHeader = implode('; ', $cspDirectives);
        $response->headers->set('Content-Security-Policy', $cspHeader);

        // Headers de sécurité additionnels
        $response->headers->set('X-Content-Type-Options', 'nosniff');
        $response->headers->set('X-Frame-Options', 'SAMEORIGIN');
        $response->headers->set('X-XSS-Protection', '1; mode=block');
        $response->headers->set('Referrer-Policy', 'strict-origin-when-cross-origin');

        // Permissions Policy (anciennement Feature Policy)
        $permissionsPolicy = [
            'geolocation=(self)',
            'microphone=()',
            'camera=()',
            'payment=()',
            'usb=()',
            'magnetometer=()',
            'gyroscope=()',
            'accelerometer=()',
        ];
        $response->headers->set('Permissions-Policy', implode(', ', $permissionsPolicy));
    }
}
