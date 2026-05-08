<?php

namespace App\EventSubscriber;

use App\Repository\UserRepository;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpKernel\Event\RequestEvent;
use Symfony\Component\HttpKernel\KernelEvents;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;

class SetupCheckSubscriber implements EventSubscriberInterface
{
    public function __construct(
        private UserRepository $userRepository,
        private UrlGeneratorInterface $urlGenerator
    ) {
    }

    public static function getSubscribedEvents(): array
    {
        return [
            KernelEvents::REQUEST => ['onKernelRequest', 0],
        ];
    }

    public function onKernelRequest(RequestEvent $event): void
    {
        // Only check on the main request
        if (!$event->isMainRequest()) {
            return;
        }

        $request = $event->getRequest();
        $currentRoute = $request->attributes->get('_route');

        // Skip checks for specific routes
        $allowedRoutes = ['app_setup', 'app_setup_create', '_wdt', '_profiler'];

        // Skip if accessing setup page or profiler/debug routes
        if (in_array($currentRoute, $allowedRoutes) || str_starts_with($currentRoute ?? '', '_')) {
            return;
        }

        // Skip for asset files and static resources
        $pathInfo = $request->getPathInfo();
        if (preg_match('/\.(css|js|png|jpg|jpeg|gif|svg|ico|woff|woff2|ttf|eot)$/i', $pathInfo)) {
            return;
        }

        // Check if any users exist
        if (!$this->userRepository->hasUsers()) {
            // Redirect to setup page
            $setupUrl = $this->urlGenerator->generate('app_setup');
            $event->setResponse(new RedirectResponse($setupUrl));
        }
    }
}
