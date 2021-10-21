test_private_key <- function() {
    if (file.exists(get_private_key_path())) {
        TRUE
    } else {
        FALSE
    }
}

assert_private_key <- function() {
    if (!test_private_key()) {
        stop("The private key file ('id_rsa') cannot be found in the 'ssh' ",
             "directory. Ask for the key to the repository administrators.",
             call. = FALSE)
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
        stop("The public key file ('id_rsa') cannot be found in the 'ssh' ",
             "directory. Ask for the key to the repository administrators.",
             call. = FALSE)
    }
}
