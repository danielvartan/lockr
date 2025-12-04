# lockr <a href = "https://danielvartan.github.io/lockr/"><img src = "man/figures/logo.svg" align="right" width="120" /></a>

<!-- quarto render -->

<!-- Install the package before rendering this file: `devtools::install()` -->

<!-- badges: start -->
[![Project Status: Active - The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![R build
status](https://github.com/danielvartan/lockr/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/danielvartan/lockr/actions)
[![](https://codecov.io/gh/danielvartan/lockr/branch/main/graph/badge.svg)](https://app.codecov.io/gh/danielvartan/lockr)
[![GNU GPLv3
License](https://img.shields.io/badge/license-GPLv3-bd0000.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Contributor Covenant 3.0 Code of
Conduct](https://img.shields.io/badge/Contributor%20Covenant-3.0-4baaaa.svg)](https://www.contributor-covenant.org/version/3/0/code_of_conduct/)
<!-- badges: end -->

## Overview

`lockr` is a simple and user-friendly R package designed for encrypting
and decrypting files.

## Installation

You can install `lockr` using the
[`remotes`](https://github.com/r-lib/remotes) package:

``` r
# install.packages("remotes")
remotes::install_github("danielvartan/lockr")
```

## Usage

`lockr` usage is very straightforward. The main functions are:

- [`lock_file`](https://danielvartan.github.io/lockr/reference/lock_file.html):
  Encrypt a file.
- [`unlock_file`](https://danielvartan.github.io/lockr/reference/unlock_file.html):
  Decrypt a locked file.

Along with these, there are helper functions to facilitate key
management and other tasks. Click
[here](https://danielvartan.github.io/lockr/reference/) to see the full
list of `lockr` functions.

## License

[![](https://img.shields.io/badge/license-GPLv3-bd0000.svg)](https://www.gnu.org/licenses/gpl-3.0)

``` text
Copyright (C) 2025 Daniel Vartanian

lockr is free software: you can redistribute it and/or modify it under the
terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program. If not, see <https://www.gnu.org/licenses/>.
```

## Contributing

[![](https://img.shields.io/badge/Contributor%20Covenant-3.0-4baaaa.svg)](https://www.contributor-covenant.org/version/3/0/code_of_conduct/)

Contributions are always welcome! Whether you want to report bugs,
suggest new features, or help improve the code or documentation, your
input makes a difference.

Before opening a new issue, please check the [issues
tab](https://github.com/danielvartan/lockr/issues) to see if your topic
has already been reported.
