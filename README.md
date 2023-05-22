# Teapot  

Teapot is micro web framework for [Pharo Smalltalk](https://pharo.org) on top of
the [Zinc HTTP components](https://github.com/svenvc/zinc), that focuses on
simplicity and ease of use. It's around 600 lines of code, not counting the tests.

**[Explore the docs](/docs)**

[![Unit Tests](https://github.com/zeroflag/Teapot/actions/workflows/unit-tests.yml/badge.svg)](https://github.com/zeroflag/Teapot/actions/workflows/unit-tests.yml/badge.svg)
[![Coverage Status](https://codecov.io/github/zeroflag/Teapot/coverage.svg?branch=master)](https://codecov.io/gh/zeroflag/Teapot/branch/master)
[![Baseline Groups](https://github.com/zeroflag/Teapot/actions/workflows/loading-groups.yml/badge.svg)](https://github.com/zeroflag/Teapot/actions/workflows/loading-groups.yml)
[![Markdown Lint](https://github.com/zeroflag/Teapot/actions/workflows/markdown-lint.yml/badge.svg)](https://github.com/zeroflag/Teapot/actions/workflows/markdown-lint.yml)

[![GitHub release](https://img.shields.io/github/release/zeroflag/Teapot.svg)](https://github.com/zeroflag/Teapot/releases/latest)
[![Pharo 9.0](https://img.shields.io/badge/Pharo-9.0-informational)](https://pharo.org)
[![Pharo 10](https://img.shields.io/badge/Pharo-10-informational)](https://pharo.org)
[![Pharo 11](https://img.shields.io/badge/Pharo-11-informational)](https://pharo.org)

> *Name origin*: [418 I'm a teapot](http://en.wikipedia.org/wiki/List_of_HTTP_status_codes)
> (RFC 2324) is an HTTP status code.

This code was defined in 1998 as one of the traditional IETF April Fools' jokes,
in RFC 2324, Hyper Text Coffee Pot Control Protocol. The RFC specifies this code
should be returned by tea pots requested to brew coffee.

## License

- The code is licensed under [MIT](LICENSE).
- The documentation is licensed under [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/).

## Quick Start

- Download the latest [Pharo 64 bits VM](https://get.pharo.org/64/).
- Download a ready to use image from the [release page](http://github.com/zeroflag/Teapot/releases/latest)
- Explore the [documentation](docs/).

```smalltalk
Metacello new
  baseline: 'Teapot';
  repository: 'github://zeroflag/Teapot/source';
  load.
```

## Installation

To load the project in a Pharo image, or declare it as a dependency of your own
project follow this [instructions](docs/Installation.md)

## Contributing

Check the [Contribution Guidelines](CONTRIBUTING.md)

## Other

If you want to lively work with Teapot or quickly implement REST services with
it, we recommend having a look at the [Tealight project](https://github.com/astares/Tealight)
a thin layer on top of Teapot to quickly experiment and deliver
