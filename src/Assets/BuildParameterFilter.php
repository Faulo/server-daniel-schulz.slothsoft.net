<?php
declare(strict_types = 1);
namespace Slothsoft\Server\DanielSchulz\Assets;

use Slothsoft\Core\IO\Sanitizer\StringSanitizer;
use Slothsoft\Farah\Module\Asset\ParameterFilterStrategy\AbstractMapParameterFilter;

final class BuildParameterFilter extends AbstractMapParameterFilter {
    
    protected function createValueSanitizers(): array {
        return [
            'project' => new StringSanitizer(),
            'branch' => new StringSanitizer()
        ];
    }
}

