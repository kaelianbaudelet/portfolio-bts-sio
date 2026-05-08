<?php

namespace App\Service;

use Symfony\Component\HttpFoundation\RequestStack;

class CspNonceGenerator
{
    private ?string $nonce = null;

    public function __construct(
        private readonly RequestStack $requestStack
    ) {
    }

    public function getNonce(): string
    {
        if ($this->nonce === null) {
            $this->nonce = base64_encode(random_bytes(16));

            // Stocker le nonce dans les attributs de la requête pour l'utiliser dans le subscriber
            $request = $this->requestStack->getCurrentRequest();
            if ($request !== null) {
                $request->attributes->set('csp_nonce', $this->nonce);
            }
        }

        return $this->nonce;
    }
}
