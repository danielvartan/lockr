
<!-- README.md is generated from README.Rmd. Please edit that file -->

# lockr

<!-- badges: start -->

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://lifecycle.r-lib.org/articles/stages.html#maturing)
[![R-CMD-check](https://github.com/giperbio/lockr/workflows/R-CMD-check/badge.svg)](https://github.com/giperbio/lockr/actions)
[![Codecov test
coverage](https://codecov.io/gh/giperbio/lockr/branch/main/graph/badge.svg)](https://app.codecov.io/gh/giperbio/lockr?branch=main)
[![License:
MIT](https://img.shields.io/badge/license-MIT-green)](https://choosealicense.com/licenses/mit/)
[![Contributor
Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg)](https://giperbio.github.io/lockr/CODE_OF_CONDUCT.html)
<!-- badges: end -->

## Overview

`lockr` is a user-friendly R package designed for encrypting/decrypting
files, with the aim of facilitating the storage and sharing of research
compendiums using R.

The creation of this package was inspired by Ben Marwick, Carl Boettiger
& Lincoln Mullen’s article [Packaging Data Analytical Work Reproducibly
Using R (and Friends)](https://doi.org/10.1080/00031305.2017.1375986).

## Prerequisites

To use the main functions of `lockr`, some familiarity with the [R
programming language](https://www.r-project.org/) is required.

If you are not comfortable with R, we strongly recommend checking out
Hadley Wickham and Garrett Grolemund’s free online book [R for Data
Science](https://r4ds.had.co.nz/), as well as the Coursera course [Data
Science: Foundations using
R](https://www.coursera.org/specializations/data-science-foundations-r)
from John Hopkins University (free for audit students).

## Installation

You can install `lockr` using:

``` r
# install.packages("remotes")
remotes::install_github("giperbio/lockr")
```

## Citation

If you use `lockr` in your research, please consider citing it. We have
put a lot of work into building and maintaining this free and
open-source R package. The citation can be found below.

``` r
citation("lockr")
#> 
#> To cite {lockr} in publications use:
#> 
#>   Vartanian, D. (2023). {lockr}: easily encrypt/decrypt files. R
#>   package version 0.3.0. https://giperbio.github.io/lockr/
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Unpublished{,
#>     title = {{lockr}: easily encrypt/decrypt files},
#>     author = {Daniel Vartanian},
#>     year = {2023},
#>     url = {https://giperbio.github.io/lockr/},
#>     note = {R package version 0.3.0},
#>   }
```

## Contributing

We welcome contributions, including bug reports.

Please take a moment to review our [Guidelines for
Contributing](https://giperbio.github.io/lockr/CONTRIBUTING.html).

<br>

Become a supporter of `lockr`!

Click [here](https://github.com/sponsors/danielvartan) to make a
donation. Please indicate the `lockr` package in your donation message.
