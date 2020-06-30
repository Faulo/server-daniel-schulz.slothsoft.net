<?php
declare(strict_types = 1);
namespace Slothsoft\DanielSchulz\Assets;

use Slothsoft\Core\IO\Sanitizer\StringSanitizer;
use Slothsoft\Farah\Module\Asset\ParameterFilterStrategy\AbstractMapParameterFilter;

class BuildParameterFilter extends AbstractMapParameterFilter
{

    protected function createValueSanitizers(): array
    {
        return [
            'project' => new StringSanitizer(),
            'branch' => new StringSanitizer()
        ];
    }
}

