
<!-- README.md is generated from README.Rmd. Please edit that file -->

# encryptrpak <a href='https://gipso.github.io/encryptrpak'><img src='man/figures/logo.png' align="right" height="139" /></a>

<!-- badges: start -->

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/gipso/encryptrpak/workflows/R-CMD-check/badge.svg)](https://github.com/gipso/encryptrpak/actions)
[![Codecov test
coverage](https://codecov.io/gh/gipso/encryptrpak/branch/main/graph/badge.svg)](https://codecov.io/gh/gipso/encryptrpak?branch=main)
[![License:
MIT](https://img.shields.io/badge/license-MIT-green)](https://choosealicense.com/licenses/mit/)
<!-- badges: end -->

`encryptrpak` is an extension for the
[encryptr](https://github.com/SurgicalInformatics/encryptr) package,
adding new features to help encrypt/decrypt files of R packages.

Please note that `encryptrpak` is not related in any way with the
`encryptr` developer team.

## Installation

`encryptrpak` is still at the
[experimental](https://lifecycle.r-lib.org/articles/stages.html#experimental)
stage of development. That means people can use the package and provide
feedback, but it comes with no promises for long term stability.

You can install `encryptrpak` from GitHub with:

``` r
# install.packages("remotes")
remotes::install_github("gipso/encryptrpak")
```

## Citation

If you use `encryptrpak` in your research, please consider citing it. We
put a lot of work to build and maintain a free and open-source R
package. You can find the `encryptrpak` citation below.

``` r
citation("encryptrpak")
#> 
#> To cite {encryptrpak} in publications use:
#> 
#>   Vartanian, D., Pedrazzoli, M. (2021). {encryptrpak}: an R Package to
#>   help encrypt/decrypt files of R packages. Retrieved from
#>   https://gipso.github.io/encryptrpak/.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Unpublished{,
#>     title = {{encryptrpak}: an R Package to help encrypt/decrypt files of R packages},
#>     author = {Daniel Vartanian and Mario Pedrazzoli},
#>     year = {2021},
#>     url = {https://gipso.github.io/encryptrpak/},
#>     note = {Lifecycle: experimental},
#>   }
```
