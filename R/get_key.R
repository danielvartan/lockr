#' Get a private/public key of a package
#'
#' @description
#'
#' `r lifecycle::badge("maturing")`
#'
#' `get_private_key()` and `get_public_key()` returns the a
#' [`rsa`][openssl::read_key] object with the data of a private/public key
#' inside an R package.
#'
#' `get_private_key_path()` and `get_public_key_path()` returns a string with
#' the location of a private/public key inside an R package.
#'
#' @details
#'
#' The keys must be in a directory named `ssh` that must be present in the
#' package system folder (for [source packages](https://bit.ly/3F4Wqwz) that is
#' usually the `inst` directory). The private and public keys must be named
#' `id_rsa` and `id_rsa.pub`, respectively.
#'
#' @return A [`rsa`][openssl::read_key] object with the data of a private/public
#'   key or a string with the path of a private/public key.
#'
#' @template param_a
#' @family utility functions
#' @export
#'
#' @examples
#' \dontrun{
#' get_private_key()
#' get_public_key()
#' get_private_key_path()
#' get_public_key_path()
#' }
get_private_key <- function(package = gutils:::get_package_name(),
                            devtools_load = FALSE) {
    checkmate::assert_string(package)
    checkmate::assert_flag(devtools_load)

    devtools_load(devtools_load)
    assert_private_key(package)

    password_warning()

    openssl::read_key(get_private_key_path(package))
}

#' @rdname get_private_key
#' @export
get_public_key <- function(package = gutils:::get_package_name(),
                           devtools_load = FALSE) {
    checkmate::assert_string(package)
    checkmate::assert_flag(devtools_load)

    devtools_load(devtools_load)
    assert_public_key(package)

    openssl::read_pubkey(get_public_key_path(package))
}

#' @rdname get_private_key
#' @export
get_private_key_path <- function(package = gutils:::get_package_name(),
                                 devtools_load = FALSE) {
    checkmate::assert_string(package)
    checkmate::assert_flag(devtools_load)

    devtools_load(devtools_load)
    assert_private_key(package)

    file.path(gutils:::find_path("ssh", package), "id_rsa")
}

#' @rdname get_private_key
#' @export
get_public_key_path <- function(package = gutils:::get_package_name(),
                                devtools_load = FALSE) {
    checkmate::assert_string(package)
    checkmate::assert_flag(devtools_load)

    devtools_load(devtools_load)
    assert_public_key(package)

    file.path(gutils:::find_path("ssh", package), "id_rsa.pub")
}
