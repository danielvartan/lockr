test_private_key <- function() {
    if (file.exists(get_private_key_path())) {
        TRUE
    } else {
        FALSE
    }
}

assert_private_key <- function() {
    if (!test_private_key()) {
        cli::cli_abort(paste0(
            "The private key file ({cli::col_red('id_rsa')}) cannot be found ",
            "in the {cli::col_blue('ssh')} directory. ",
            "Ask for the key to the repository administrators."
        ))
    }
}

test_public_key <- function() {
    if (file.exists(get_public_key_path())) {
        TRUE
    } else {
        FALSE
    }
}

assert_public_key <- function() {
    if (!test_public_key()) {
        cli::cli_abort(paste0(
            "The public key file ({cli::col_red('id_rsa.pub')}) cannot be ",
            "found in the {cli::col_blue('ssh')} directory. ",
            "Ask for the key to the repository administrators."
        ))
    }
}
