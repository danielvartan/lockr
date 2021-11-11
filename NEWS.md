<!--- https://devguide.ropensci.org/releasing.html -->
<!--- https://style.tidyverse.org/news.html -->
<!--- https://semver.org/ -->

# encryptrpak (development version)




# encryptrpak 0.2.0 (2021-11-11)

* `get_private_key_path()` and `get_public_key_path()` are now exported 
functions.
* An argument called `devtools_load` was added to `get_private_key()`,
`get_public_key()`, `get_private_key_path()`, `get_public_key_path()`,
`encrypt_extdata()`, and `decrypt_extdata()`. This allows developers to load
packages to memory before running the functions. The `devtools_load` argument is
always set to `FALSE`.


# encryptrpak 0.1.0 (2021-11-04)

* First `encryptrpak` release. 🎉


# encryptrpak 0.0.0.9000

* Added a `NEWS.md` file to track changes to the package.
