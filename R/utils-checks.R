test_private_key <- function(package = gutils:::get_package_name()) {
    checkmate::assert_string(package)

    if (file.exists_(get_private_key_path(package))) {
        TRUE
    } else {
        FALSE
    }
}

assert_private_key <- function(package = gutils:::get_package_name()) {
    checkmate::assert_string(package)

    if (!test_private_key(package)) {
        cli::cli_abort(paste(
            "The private key file ({.strong {cli::col_red('id_rsa')}})",
            "cannot be found in the {.strong {cli::col_blue('ssh')}}",
            "directory. Ask for the key to the repository administrators."
        ))
    }

    invisible(NULL)
}

test_public_key <- function(package = gutils:::get_package_name()) {
    checkmate::assert_string(package)

    if (file.exists_(get_public_key_path(package))) {
        TRUE
    } else {
        FALSE
    }
}

assert_public_key <- function(package = gutils:::get_package_name()) {
    checkmate::assert_string(package)

    if (!test_public_key(package)) {
        cli::cli_abort(paste(
            "The public key file ({.strong {cli::col_red('id_rsa.pub')}})",
            "cannot be found in the {.strong {cli::col_blue('ssh')}}",
            "directory. Ask for the key to the repository administrators."
        ))
    }

    invisible(NULL)
}
