# Teapot  

Teapot is micro web framework for [Pharo Smalltalk](https://pharo.org) on top of the [Zinc HTTP components](https://github.com/svenvc/zinc), that focuses on simplicity and ease of use. It's around 600 lines of code, not counting the tests.

**[Explore the docs](/docs)**

[![Build Status](https://travis-ci.com/zeroflag/Teapot.svg?branch=master)](https://travis-ci.com/zeroflag/Teapot)
[![Coverage Status](https://coveralls.io/repos/github/zeroflag/Teapot/badge.svg?branch=master)](https://coveralls.io/github/zeroflag/Teapot?branch=master)

> *Name origin*: [418 I'm a teapot](http://en.wikipedia.org/wiki/List_of_HTTP_status_codes) (RFC 2324) is an HTTP status code.

This code was defined in 1998 as one of the traditional IETF April Fools' jokes, in RFC 2324, Hyper Text Coffee Pot Control Protocol. The RFC specifies this code should be returned by tea pots requested to brew coffee.

## License
- The code is licensed under [MIT](LICENSE).
- The documentation is licensed under [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/).

## Quick Start

- Download the latest [Pharo 32](https://get.pharo.org/) or [64 bits VM](https://get.pharo.org/64/).
- Download a ready to use image from the [release page](http://github.com/zeroflag/Teapot/releases/latest)
- Explore the [documentation](docs/).

```
Metacello new
	baseline: 'Teapot';
	repository: 'github://zeroflag/Teapot/source';
	load.
```


## Installation

To load the project in a Pharo image, or declare it as a dependency of your own project follow this [instructions](docs/Installation.md)

## Contributing

Check the [Contribution Guidelines](CONTRIBUTING.md)

## Other

If you want to lively work with Teapot or quickly implement REST services with it we recommend to have a look at the [Tealight project](https://github.com/astares/Tealight) - a thin layer on top of Teapot to quickly experiment and deliver
