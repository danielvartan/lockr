#' Get a private/public key of a package
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' `get_private_key()` and `get_public_key()` returns the data of a
#' private/public key inside an R package.
#'
#' @details
#'
#' The keys must be in a folder named `ssh` that must be present in the system
#' folder (`inst`). The private and public keys must be named `id_rsa` and
#' `id_rsa.pub`, respectively.
#'
#' @return The data of a private/public key.
#'
#' @template param_a
#' @family utility functions
#' @export
#'
#' @examples
#' \dontrun{
#' get_private_key()
#' get_public_key()
#' }
get_private_key <- function(package = encryptrpak:::get_package_name()) {
    checkmate::assert_string(package)
    assert_private_key()
    openssl::read_key(get_private_key_path(package))
}

#' @rdname get_private_key
#' @export
get_public_key <- function(package = encryptrpak:::get_package_name()) {
    checkmate::assert_string(package)
    assert_public_key()
    openssl::read_pubkey(get_public_key_path(package))
}

get_private_key_path <- function(package = encryptrpak:::get_package_name()) {
    file.path(system.file("ssh", package = package), "id_rsa")
}

get_public_key_path <- function(package = encryptrpak:::get_package_name()) {
    file.path(system.file("ssh", package = package), "id_rsa.pub")
}
