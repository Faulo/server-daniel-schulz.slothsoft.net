<?php
declare(strict_types = 1);
namespace Slothsoft\DanielSchulz\Assets;

use DOMDocument;
use Slothsoft\Core\IO\Sanitizer\StringSanitizer;
use Slothsoft\Farah\Module\Asset\ParameterFilterStrategy\AbstractMapParameterFilter;
use Slothsoft\Core\DOMHelper;
use Slothsoft\Core\FileSystem;

class BuildInfo
{

    const BUILD_DIRECTORY = 'Builds';

    const INDEX_FILE = '/index.html';

    const SETTINGS_FILE = '/Build/Game.json';

    public static function loadBuilds(string $project, string $branch): iterable
    {
        foreach (FileSystem::scanDir(self::BUILD_DIRECTORY, FileSystem::SCANDIR_EXCLUDE_FILES) as $p) {
            foreach (FileSystem::scanDir(self::BUILD_DIRECTORY . DIRECTORY_SEPARATOR . $p, FileSystem::SCANDIR_EXCLUDE_FILES) as $b) {
                $build = new BuildInfo($p, $b);
                if ($build->project === $project and $build->branch === $branch) {
                    if ($build->isValid()) {
                        $build->load();
                    }
                }
                yield $build;
            }
        }
    }

    public $project;

    public $branch;

    public $settings;

    public $indexDocument;

    private function __construct(string $project, string $branch)
    {
        $this->project = $project;
        $this->branch = $branch;
    }

    public function getAttributes(): iterable
    {
        yield 'project' => $this->project;
        yield 'branch' => $this->branch;
        if ($this->isValid()) {
            yield 'timestamp' => FileSystem::changetime($this->getIndexFile());
            yield 'datetime' => date('d.m.y H:i:s', FileSystem::changetime($this->getIndexFile()));
        }
        if ($this->settings) {
            yield 'name' => $this->settings['productName'];
            yield 'credits' => $this->settings['companyName'];
            if (isset($this->settings['productVersion'])) {
                yield 'version' => $this->settings['productVersion'];
            }
        }
    }

    public function isValid(): bool
    {
        return file_exists($this->getIndexFile());
    }

    private function getIndexFile(): string
    {
        return self::BUILD_DIRECTORY . "/$this->project/$this->branch" . self::INDEX_FILE;
    }

    private function getSettings($textContent): array
    {
        if (preg_match('~"(Build/.+\.json)"~', $textContent, $match)) {
            $settingsFile = "/$match[1]";
        } else {
            $settingsFile = self::SETTINGS_FILE;
        }
        $file = self::BUILD_DIRECTORY . "/$this->project/$this->branch" . $settingsFile;
        if (is_file($file)) {
            return $this->parseSettings(file_get_contents($file));
        }
        if (preg_match('~var config = ({[^}]+})~', $textContent, $match)) {
            return $this->parseSettings($match[1]);
        }
        throw new \Exception('Unable to determine settings from index.html');
    }

    private function parseSettings($json): array
    {
        $json = trim($json);
        $json = str_replace('buildUrl + "', '"Build', $json);
        $json = preg_replace('~^([\w]+):~', '"$1":', $json);
        $json = preg_replace('~",\s+\}~', '"}', $json);
        return json_decode($json, true);
    }

    private function load()
    {
        $this->indexDocument = @DOMHelper::loadDocument($this->getIndexFile(), true);
        $this->settings = $this->getSettings($this->indexDocument->textContent);
    }
}