# Daniel Schulz's Portfolio Website

[![Test Status](../../actions/workflows/ci-tests.yml/badge.svg)](../../actions/workflows/ci-tests.yml)
[![license badge](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

## Development

Start the local PHP 8.5 environment with DDEV:

```bash
ddev start
```

The website is then available at <https://daniel-schulz.ddev.site>. Run the
test suite in the project runtime with:

```bash
ddev exec vendor/bin/phpunit
```
