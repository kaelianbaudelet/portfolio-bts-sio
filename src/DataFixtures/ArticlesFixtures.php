<?php

namespace App\DataFixtures;

use App\Entity\TechWatchArticle;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Bundle\FixturesBundle\FixtureGroupInterface;
use Doctrine\Persistence\ObjectManager;
use DateTimeImmutable;

class ArticlesFixtures extends Fixture implements FixtureGroupInterface
{
    public static function getGroups(): array
    {
        return ['articles', 'techwatch'];
    }

    public function load(ObjectManager $manager): void
    {
        $articlesData = [
            [
                'title' => 'React 19.2 : Les 2 nouveautés à ne pas manquer',
                'description' => 'Analyse purement technique sur l\'arrivée du composant Activity pour le pré-rendu en arrière-plan et du hook useEffectEvent.',
                'author' => 'Coding Tech',
                'publishedAt' => new \DateTime('2025-10-15'),
                'url' => 'https://www.coding-tech.fr/blog/react-19-2-les-nouveautes-a-ne-pas-manquer',
                'category' => 'React'
            ],
            [
                'title' => 'Nouveautés d\'Angular 21',
                'description' => 'Bilan exhaustif détaillant l\'impact du mode "Zoneless" et l\'introduction des Signal Forms pour une réactivité accrue.',
                'author' => 'Angular.fr',
                'publishedAt' => new \DateTime('2025-11-20'),
                'url' => 'https://angular.fr/news/angular21',
                'category' => 'Angular'
            ],
            [
                'title' => 'Vulnérabilité dans React Server Components',
                'description' => 'Bulletin de sécurité CERT-FR décryptant une faille critique de type exécution de code à distance (RCE) touchant les RSC.',
                'author' => 'CERT-FR',
                'publishedAt' => new \DateTime('2026-01-10'),
                'url' => 'https://www.cert.ssi.gouv.fr/alerte/CERTFR-2025-ALE-014/',
                'category' => 'Sécurité'
            ],
            [
                'title' => 'L\'avenir de React.js : Tendances et évolutions pour 2026',
                'description' => 'Étude analysant l\'impact du compilateur React (Forget) et de Next.js sur les performances et l\'expérience développeur.',
                'author' => 'Polara Studio',
                'publishedAt' => new \DateTime('2026-01-05'),
                'url' => 'https://www.polarastudio.fr/blog/lavenir-de-react-js-tendances-et-evolutions-pour-2026',
                'category' => 'React'
            ],
            [
                'title' => 'L\'avenir de React : Tendances et évolutions en 2026',
                'description' => 'Analyse de la roadmap officielle, du support TypeScript natif et de la stratégie de Meta pour l\'écosystème React.',
                'author' => 'Dyma',
                'publishedAt' => new \DateTime('2026-01-20'),
                'url' => 'https://dyma.fr/blog/quel-futur-pour-react/',
                'category' => 'React'
            ],
            [
                'title' => 'Les meilleurs boilerplates Svelte pour votre SaaS en 2025',
                'description' => 'Tour d\'horizon de l\'écosystème Svelte 5 et de sa compilation sans Virtual DOM pour des architectures web ultra-légères.',
                'author' => 'SaaS Boilerplate',
                'publishedAt' => new \DateTime('2025-09-30'),
                'url' => 'https://saasboilerplate.fr/frameworks/svelte',
                'category' => 'Svelte'
            ],
            [
                'title' => 'Framework JavaScript 2025 : guide d\'évolution',
                'description' => 'Rétrospective sur les paradigmes (SolidJS, Svelte) qui s\'affranchissent du Virtual DOM pour plus de performance.',
                'author' => 'Business to Web',
                'publishedAt' => new \DateTime('2025-10-05'),
                'url' => 'https://www.business-to-web.fr/framework-javascript/',
                'category' => 'Web'
            ],
            [
                'title' => 'Exploitation d\'une vulnérabilité critique dans les RSC',
                'description' => 'Décryptage technique de la faille CVE-2025-55182 touchant React et Next.js, avec recommandations de remédiation.',
                'author' => 'Palo Alto Networks',
                'publishedAt' => new \DateTime('2025-12-12'),
                'url' => 'https://unit42.paloaltonetworks.com/fr/cve-2025-55182-react-and-cve-2025-66478-next/',
                'category' => 'Sécurité'
            ],
            [
                'title' => 'Migration d\'un éditeur graphique de React vers Svelte 5',
                'description' => 'Retour d\'expérience sur le passage incrémental d\'une application complexe vers la réactivité par "runes".',
                'author' => 'OSS Directory',
                'publishedAt' => new \DateTime('2025-12-20'),
                'url' => 'https://www.ossdirectory.com/fr/success-stories/details/react-to-svelte',
                'category' => 'Svelte'
            ],
            [
                'title' => 'React vs Vue vs Angular 2026 : Guide complet',
                'description' => 'Bilan sur les performances, la taille des bundles et l\'impact du SSR sur le choix technologique en 2026.',
                'author' => 'Bluewave',
                'publishedAt' => new \DateTime('2025-12-28'),
                'url' => 'https://bluewave.fr/blog/react-vs-vue-vs-angular-comparatif-complet-des-frameworks-javascript-pour-2026',
                'category' => 'Web'
            ],
            [
                'title' => 'Les 10 Meilleurs Frameworks JavaScript en 2026',
                'description' => 'Analyse prospective soulignant la montée en puissance de SvelteKit et Qwik face aux géants traditionnels.',
                'author' => 'Industrie du Futur',
                'publishedAt' => new \DateTime('2026-03-15'),
                'url' => 'https://industrie-du-futur.tv/developpement-informatique/10-meilleurs-frameworks-javascript-a-utiliser-en-2022/',
                'category' => 'Web'
            ],
            [
                'title' => 'Écrire son propre injecteur de dépendances en TypeScript',
                'description' => 'Comprendre le fonctionnement interne de l\'injection de dépendances en recréant un moteur simple et typé.',
                'author' => 'Nathanaël Cherrier',
                'publishedAt' => new \DateTime('2026-02-19'),
                'url' => 'https://mindsers.blog/fr/post/ecrire-injecteur-dependance-javascript/',
                'category' => 'TypeScript'
            ],
            [
                'title' => 'Pourquoi apprendre React Native en 2025 ?',
                'description' => 'Les avantages du cross-platform avec React Native face aux solutions hybrides et natives traditionnelles.',
                'author' => 'Nathanaël Cherrier',
                'publishedAt' => new \DateTime('2025-04-23'),
                'url' => 'https://mindsers.blog/fr/post/pourquoi-apprendre-react-native-en-2025/',
                'category' => 'Mobile'
            ],
            [
                'title' => 'Les meilleures pratiques pour un SaaS performant',
                'description' => 'Architecture, scalabilité et performance : faire les bons choix techniques dès le début du projet.',
                'author' => 'Nathanaël Cherrier',
                'publishedAt' => new \DateTime('2025-05-08'),
                'url' => 'https://mindsers.blog/fr/post/les-meilleures-pratiques-pour-un-saas-performant/',
                'category' => 'Architecture'
            ],
            [
                'title' => 'Développeur Freelance : ma toolbox 2025',
                'description' => 'Les outils indispensables pour gagner en productivité et en sérénité en tant que freelance tech.',
                'author' => 'Nathanaël Cherrier',
                'publishedAt' => new \DateTime('2025-05-21'),
                'url' => 'https://mindsers.blog/fr/post/developpeur-freelance-toolbox-2025-pour-etre-plus-rapide-serein/',
                'category' => 'Productivité'
            ],
            [
                'title' => 'Quelle évolution de carrière pour un développeur ?',
                'description' => 'Explorer les trajectoires possibles après quelques années d\'expérience : Senior, Lead, Staff ou Manager.',
                'author' => 'Nathanaël Cherrier',
                'publishedAt' => new \DateTime('2025-05-14'),
                'url' => 'https://mindsers.blog/fr/post/quelle-evolution-de-carriere-pour-un-developpeur/',
                'category' => 'Carrière'
            ],
            [
                'title' => 'Comprendre les rôles dans la tech : du Développeur au CTO',
                'description' => 'Décryptage des responsabilités et des attentes pour chaque niveau de séniorité dans une équipe technique.',
                'author' => 'Nathanaël Cherrier',
                'publishedAt' => new \DateTime('2025-04-30'),
                'url' => 'https://mindsers.blog/fr/post/comprendre-roles-tech-developpeur-au-cto/',
                'category' => 'Carrière'
            ],
            [
                'title' => 'Allez plus loin avec les scripts du package.json',
                'description' => 'Optimiser son workflow de développement en utilisant toute la puissance des scripts npm/yarn.',
                'author' => 'Nathanaël Cherrier',
                'publishedAt' => new \DateTime('2024-02-28'),
                'url' => 'https://mindsers.blog/fr/post/plus-loin-scripts-package-json-npm/',
                'category' => 'Node.js'
            ],
            [
                'title' => 'Récapitulatif technique 2025',
                'description' => 'Un bilan des évolutions majeures du web en 2025 : frameworks, outils et nouvelles APIs navigateurs.',
                'author' => 'Grafikart',
                'publishedAt' => new \DateTime('2025-12-20'),
                'url' => 'https://grafikart.fr/blog/recap-2025',
                'category' => 'Web'
            ],
            [
                'title' => 'Pourquoi je n\'aime pas Next.js',
                'description' => 'Une critique constructive sur la complexité croissante et les choix architecturaux de Next.js.',
                'author' => 'Grafikart',
                'publishedAt' => new \DateTime('2025-06-15'),
                'url' => 'https://grafikart.fr/blog/nextjs-dislike',
                'category' => 'Next.js'
            ],
            [
                'title' => 'Je ne déteste plus TailwindCSS',
                'description' => 'Retour sur un changement d\'avis concernant les frameworks CSS utility-first après usage intensif.',
                'author' => 'Grafikart',
                'publishedAt' => new \DateTime('2025-03-10'),
                'url' => 'https://grafikart.fr/blog/je-deteste-plus-tailwindcss',
                'category' => 'CSS'
            ],
            [
                'title' => 'Windsurf, le meilleur éditeur IA ?',
                'description' => 'Test approfondi du nouvel éditeur de code intégrant l\'IA nativement pour booster la productivité.',
                'author' => 'Grafikart',
                'publishedAt' => new \DateTime('2025-11-05'),
                'url' => 'https://grafikart.fr/blog/windsurf-editor-ia',
                'category' => 'IA'
            ],
            [
                'title' => 'L\'impact de l\'IA sur le métier de Freelance',
                'description' => 'Comment l\'IA transforme la manière de travailler, de deviser et de livrer des projets en freelance.',
                'author' => 'Grafikart',
                'publishedAt' => new \DateTime('2026-02-15'),
                'url' => 'https://grafikart.fr/blog/impact-llm-freelance-ia',
                'category' => 'Carrière'
            ],
            [
                'title' => 'Je crée mon propre métamoteur de recherche',
                'description' => 'Retour sur la création d\'un outil de recherche personnalisé pour centraliser ses ressources tech.',
                'author' => 'Grafikart',
                'publishedAt' => new \DateTime('2025-04-10'),
                'url' => 'https://grafikart.fr/blog/grafisearch-metamoteur-recherche',
                'category' => 'Web'
            ],
            [
                'title' => 'AeroSpace, un gestionnaire de fenêtre pour MacOS',
                'description' => 'Découverte d\'un outil de tiling window management pour optimiser son espace de travail sur Mac.',
                'author' => 'Grafikart',
                'publishedAt' => new \DateTime('2026-01-20'),
                'url' => 'https://grafikart.fr/blog/aerospace-tiling-window-manager-macos',
                'category' => 'Productivité'
            ],
            [
                'title' => 'Créer et implémenter un serveur MCP en TypeScript',
                'description' => 'Découvrez comment créer un serveur Model Context Protocol pour enrichir le contexte des LLMs.',
                'author' => 'Eleven Labs',
                'publishedAt' => new \DateTime('2026-02-25'),
                'url' => 'https://blog.eleven-labs.com/fr/model-context-protocol/',
                'category' => 'IA'
            ],
            [
                'title' => 'ESLint Plugin : Créer une règle personnalisée',
                'description' => 'Guide pour créer son propre plugin ESLint avec la flat config et le publier sur npm.',
                'author' => 'Eleven Labs',
                'publishedAt' => new \DateTime('2026-01-30'),
                'url' => 'https://blog.eleven-labs.com/fr/creer-plugin-eslint/',
                'category' => 'Tooling'
            ],
            [
                'title' => 'Concevoir une barre de recherche accessible avec React',
                'description' => 'Méthodes et bonnes pratiques pour une recherche conforme au RGAA en utilisant React et MUI.',
                'author' => 'Eleven Labs',
                'publishedAt' => new \DateTime('2025-11-15'),
                'url' => 'https://blog.eleven-labs.com/fr/concevoir-barre-recherche-accessible-react-html/',
                'category' => 'Accessibilité'
            ],
            [
                'title' => 'La nouvelle Anchor positioning API en CSS',
                'description' => 'Comment lier dynamiquement des éléments en pur CSS sans passer par JavaScript.',
                'author' => 'Eleven Labs',
                'publishedAt' => new \DateTime('2025-08-20'),
                'url' => 'https://blog.eleven-labs.com/fr/css-anchor-positioning-api/',
                'category' => 'CSS'
            ],
            [
                'title' => 'Construire un Design System robuste avec React',
                'description' => 'Les fondations essentielles pour concevoir une interface cohérente et évolutive avec React.',
                'author' => 'Eleven Labs',
                'publishedAt' => new \DateTime('2025-07-12'),
                'url' => 'https://blog.eleven-labs.com/fr/design-system-react/',
                'category' => 'React'
            ],
            [
                'title' => 'Micro frontend : solution pour la maintenabilité',
                'description' => 'Comprendre et mettre en place des architectures micro-frontends pour de grandes applications web.',
                'author' => 'Eleven Labs',
                'publishedAt' => new \DateTime('2025-03-05'),
                'url' => 'https://blog.eleven-labs.com/fr/micro-frontend/',
                'category' => 'Architecture'
            ],
            [
                'title' => 'Atomic Design : pour des interfaces modulaires',
                'description' => 'Appliquer l\'approche Atomic Design pour créer des composants réutilisables et cohérents.',
                'author' => 'Eleven Labs',
                'publishedAt' => new \DateTime('2025-02-10'),
                'url' => 'https://blog.eleven-labs.com/fr/atomic-design/',
                'category' => 'Design'
            ],
            [
                'title' => 'Maîtriser les types avancés en TypeScript',
                'description' => 'Exploration des types conditionnels et des types utilitaires pour des codebases plus robustes.',
                'author' => 'Julien Pradet',
                'publishedAt' => new \DateTime('2024-03-11'),
                'url' => 'https://www.julienpradet.fr/tutoriels/typescript-types-avances/',
                'category' => 'TypeScript'
            ],
            [
                'title' => '3 Règles d\'or en TypeScript',
                'description' => 'Les bonnes pratiques indispensables pour éviter de polluer son code avec des types "any".',
                'author' => 'Julien Pradet',
                'publishedAt' => new \DateTime('2024-03-04'),
                'url' => 'https://www.julienpradet.fr/tutoriels/typescript-bonnes-pratiques/',
                'category' => 'TypeScript'
            ],
            [
                'title' => 'Comment utiliser l\'API View Transitions ?',
                'description' => 'Animer les transitions entre les pages avec cette nouvelle API navigateur ultra-puissante.',
                'author' => 'Julien Pradet',
                'publishedAt' => new \DateTime('2024-02-06'),
                'url' => 'https://www.julienpradet.fr/tutoriels/view-transitions/',
                'category' => 'Web'
            ],
            [
                'title' => 'Manipulation robuste des URL avec URLSearchParams',
                'description' => 'Pourquoi et comment utiliser l\'objet natif URL pour une gestion propre des paramètres query.',
                'author' => 'Christophe Porteneuve',
                'publishedAt' => new \DateTime('2023-04-10'),
                'url' => 'https://delicious-insights.com/fr/articles-et-tutos/url-search-params/',
                'category' => 'JavaScript'
            ],
            [
                'title' => 'JS protip : Array.from() ou Array#fill() ?',
                'description' => 'Comparaison et cas d\'usage pour l\'initialisation de tableaux en JavaScript moderne.',
                'author' => 'Christophe Porteneuve',
                'publishedAt' => new \DateTime('2023-03-22'),
                'url' => 'https://delicious-insights.com/fr/articles-et-tutos/js-protip-array-from-fill/',
                'category' => 'JavaScript'
            ],
            [
                'title' => 'Faire une pause avec setTimeout() en mode await',
                'description' => 'Encapsuler les timers classiques dans des promesses pour un code plus lisible et séquentiel.',
                'author' => 'Christophe Porteneuve',
                'publishedAt' => new \DateTime('2023-02-08'),
                'url' => 'https://delicious-insights.com/fr/articles-et-tutos/js-protip-timers-promises/',
                'category' => 'JavaScript'
            ],
            [
                'title' => 'Apprendre React : Le guide complet pour débuter',
                'description' => 'Un parcours pédagogique pour comprendre les bases de React et construire sa première application.',
                'author' => 'Alex Soyes',
                'publishedAt' => new \DateTime('2024-05-15'),
                'url' => 'https://alexsoyes.com/apprendre-react/',
                'category' => 'React'
            ],
            [
                'title' => 'Pourquoi j\'utilise TypeScript dans tous mes projets',
                'description' => 'Retour d\'expérience sur le gain de productivité et la réduction de bugs grâce au typage statique.',
                'author' => 'Nathanaël Cherrier',
                'publishedAt' => new \DateTime('2024-11-20'),
                'url' => 'https://mindsers.blog/fr/post/pourquoi-j-utilise-typescript/',
                'category' => 'TypeScript'
            ],
        ];

        foreach ($articlesData as $index => $data) {
            $article = new TechWatchArticle();
            $article->setTitle($data['title']);
            $article->setDescription($data['description']);
            $article->setAuthor($data['author']);
            
            // Handle both DateTime and strings for flexibility
            $date = $data['publishedAt'] instanceof \DateTimeInterface 
                ? $data['publishedAt'] 
                : new \DateTime($data['publishedAt']);
            
            $article->setPublishedAt(\DateTimeImmutable::createFromInterface($date));
            $article->setArticleUrl($data['url']);
            $article->setImage(null);
            $article->setIsVisible(true);
            $article->setDisplayOrder($index); // Use loop index as order

            $manager->persist($article);
        }

        $manager->flush();

        printf("✓ %d articles de veille technologique ont été créés avec succès!\n", count($articlesData));
    }
}
