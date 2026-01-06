<?php
declare(strict_types = 1);
namespace Slothsoft\Server\DanielSchulz\Assets;

use Slothsoft\Core\IO\Writable\Delegates\DOMWriterFromElementDelegate;
use Slothsoft\Farah\FarahUrl\FarahUrlArguments;
use Slothsoft\Farah\Module\Asset\AssetInterface;
use Slothsoft\Farah\Module\Asset\ExecutableBuilderStrategy\ExecutableBuilderStrategyInterface;
use Slothsoft\Farah\Module\Executable\ExecutableStrategies;
use Slothsoft\Farah\Module\Executable\ResultBuilderStrategy\DOMWriterResultBuilder;
use DOMDocument;
use DOMElement;

final class BuildInfoBuilder implements ExecutableBuilderStrategyInterface {
    
    public function buildExecutableStrategies(AssetInterface $context, FarahUrlArguments $args): ExecutableStrategies {
        $project = $args->get('project');
        $branch = $args->get('branch');
        
        $closure = function (DOMDocument $targetDoc) use ($context, $args, $project, $branch): DOMElement {
            $rootNode = $targetDoc->createElement('builds');
            $rootNode->setAttribute('url', (string) $context->createUrl($args));
            $projects = [];
            foreach (BuildInfo::loadBuilds($project, $branch) as $build) {
                $projects[$build->project] = true;
                $url = $context->createUrl(FarahUrlArguments::createFromValueList([
                    'project' => $build->project,
                    'branch' => $build->branch
                ]));
                $buildNode = $targetDoc->createElement('build-info');
                $buildNode->setAttribute('url', (string) $url);
                foreach ($build->getAttributes() as $key => $val) {
                    $buildNode->setAttribute($key, (string) $val);
                }
                if ($build->indexDocument) {
                    $buildNode->appendChild($targetDoc->importNode($build->indexDocument->documentElement, true));
                }
                $rootNode->appendChild($buildNode);
            }
            foreach (array_keys($projects) as $project) {
                $node = $targetDoc->createElement('project');
                $node->textContent = $project;
                $rootNode->appendChild($node);
            }
            return $rootNode;
        };
        $writer = new DOMWriterFromElementDelegate($closure);
        $resultBuilder = new DOMWriterResultBuilder($writer, 'builds.xml');
        return new ExecutableStrategies($resultBuilder);
    }
}

