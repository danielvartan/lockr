
<!-- README.md is generated from README.Rmd. Please edit that file -->

# encryptrpak <a href='https://giperbio.github.io/encryptrpak/'><img src='man/figures/logo.png' align="right" height="139" /></a>

<!-- badges: start -->

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://lifecycle.r-lib.org/articles/stages.html#maturing)
[![R-CMD-check](https://github.com/giperbio/encryptrpak/workflows/R-CMD-check/badge.svg)](https://github.com/giperbio/encryptrpak/actions)
[![Codecov test
coverage](https://codecov.io/gh/giperbio/encryptrpak/branch/main/graph/badge.svg)](https://app.codecov.io/gh/giperbio/encryptrpak?branch=main)
[![License:
MIT](https://img.shields.io/badge/license-MIT-green)](https://choosealicense.com/licenses/mit/)
[![Contributor
Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg)](https://giperbio.github.io/encryptrpak/CODE_OF_CONDUCT.html)
<!-- badges: end -->

## Overview

`encryptrpak` is an extension for the
[encryptr](https://github.com/SurgicalInformatics/encryptr) package,
adding new features to encrypt/decrypt files of R packages.

Please note that `encryptrpak` is not related in any way with the
`encryptr` developer team.

## Prerequisites

You need to have some familiarity with the [R programming
language](https://www.r-project.org/) and with the
[encryptr](https://github.com/SurgicalInformatics/encryptr) package to
use `encryptrpak` main functions.

If you don’t feel comfortable with R, we strongly recommend checking
Hadley Wickham and Garrett Grolemund free and online book [R for Data
Science](https://r4ds.had.co.nz/) and the Coursera course from John
Hopkins University [Data Science: Foundations using
R](https://www.coursera.org/specializations/data-science-foundations-r)
(free for audit students).

Please refer to the [encryptr](https://encrypt-r.org/) package
documentation to learn more about it.

## Installation

You can install `encryptrpak` with:

``` r
# install.packages("remotes")
remotes::install_github("giperbio/encryptrpak")
```

We don’t intend to publish this package to CRAN.

## Citation

If you use `encryptrpak` in your research, please consider citing it. We
put a lot of work to build and maintain a free and open-source R
package. You can find the `encryptrpak` citation below.

``` r
citation("encryptrpak")
#> 
#> To cite {encryptrpak} in publications use:
#> 
#>   Vartanian, D. (2023). {encryptrpak}: encrypt/decrypt files of R
#>   packages. R package version 0.2.0.9000.
#>   https://giperbio.github.io/encryptrpak/
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Unpublished{,
#>     title = {{encryptrpak}: encrypt/decrypt files of R packages},
#>     author = {Daniel Vartanian},
#>     year = {2023},
#>     url = {https://giperbio.github.io/encryptrpak/},
#>     note = {R package version 0.0.0.9000},
#>   }
```

## Contributing

We welcome contributions, including bug reports.

Take a moment to review our [Guidelines for
Contributing](https://giperbio.github.io/encryptrpak/CONTRIBUTING.html).

<br>

Become an `encryptrpak` supporter!

Click [here](https://github.com/sponsors/danielvartan) to make a
donation. Please indicate the `encryptrpak` package in your donation
message.
