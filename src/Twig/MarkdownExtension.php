<?php

namespace App\Twig;

use League\CommonMark\CommonMarkConverter;
use League\CommonMark\Environment\Environment;
use League\CommonMark\Extension\CommonMark\CommonMarkCoreExtension;
use League\CommonMark\Extension\GithubFlavoredMarkdownExtension;
use League\CommonMark\Extension\Table\TableExtension;
use League\CommonMark\MarkdownConverter;
use Twig\Extension\AbstractExtension;
use Twig\TwigFilter;

class MarkdownExtension extends AbstractExtension
{
    private MarkdownConverter $converter;

    public function __construct()
    {
        // Configure the Environment with all the CommonMark extensions
        $environment = new Environment([
            'html_input' => 'escape',
            'allow_unsafe_links' => false,
            'max_nesting_level' => 10,
        ]);

        // Add CommonMark core extension
        $environment->addExtension(new CommonMarkCoreExtension());

        // Add GitHub Flavored Markdown (includes tables, strikethrough, autolinks, etc.)
        $environment->addExtension(new GithubFlavoredMarkdownExtension());

        $this->converter = new MarkdownConverter($environment);
    }

    public function getFilters(): array
    {
        return [
            new TwigFilter('markdown', [$this, 'parseMarkdown'], ['is_safe' => ['html']]),
        ];
    }

    public function parseMarkdown(?string $content): string
    {
        if (empty($content)) {
            return '';
        }

        return $this->converter->convert($content)->getContent();
    }
}
