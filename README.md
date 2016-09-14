# enzo

[![No Maintenance Intended](http://unmaintained.tech/badge.svg)](http://unmaintained.tech/)

Validate [API blueprints][1] via CLI using [Apiary][2] and [Blueprint][3] APIs.

## Usage

Run it with the name you are using for hosting on [Apiary][2]:

```bash
$ ./.build/debug/enzo parse contentfulcda
Could not parse blueprint: unknown type of mson value
```

Enzo will download your blueprint and parse it via the [Blueprint][3] API. It will
display any errors/warnings and exit with a non-zero status code if any issues are present.
Otherwise it will print `OK` and exit with zero.

:warning: Due to limitations of the underlying HTTP client, enzo uses an unencrypted
connection.

## Installation

Enzo requires Swift 2.2, as it uses the [Swift Package Manager][4]. You can compile
it by just running:

```bash
$ make
```

By default, the CLI tool will be located in `.build/debug/enzo`.

[1]: https://github.com/apiaryio/api-blueprint/blob/master/API%20Blueprint%20Specification.md
[2]: https://apiary.io/
[3]: https://apiblueprint.org
[4]: https://swift.org/package-manager/
