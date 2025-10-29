<?php
declare(strict_types = 1);
namespace Slothsoft\Server\DanielSchulz\Tests;

use Slothsoft\Farah\FarahUrl\FarahUrlAuthority;
use Slothsoft\FarahTesting\Module\AbstractModuleTest;

class AssetsModuleTest extends AbstractModuleTest {

    protected static function getManifestAuthority(): FarahUrlAuthority {
        return FarahUrlAuthority::createFromVendorAndModule('slothsoft', 'daniel-schulz.slothsoft.net');
    }
}