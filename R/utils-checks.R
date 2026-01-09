test_public_key <- function(
  public_key = here::here(".ssh", "id_rsa.pub")
) {
  if (checkmate::test_class(public_key, "rsa")) {
    if (inherits(public_key, "pubkey")) {
      TRUE
    } else {
      FALSE
    }
  } else {
    checkmate::assert_file_exists(public_key)

    test <-
      public_key |>
      openssl::read_pubkey() |>
      try(silent = TRUE)

    if (!inherits(test, "try-error")) {
      TRUE
    } else {
      FALSE
    }
  }
}

assert_public_key <- function(
  public_key = here::here(".ssh", "id_rsa.pub")
) {
  if (!test_public_key(public_key)) {
    cli::cli_abort(paste(
      "The public key is not valid."
    ))
  }

  invisible(NULL)
}

test_private_key <- function(
  private_key = here::here(".ssh", "id_rsa"),
  password = NULL
) {
  checkmate::assert_string(password, null.ok = TRUE)

  if (checkmate::test_class(private_key, "rsa")) {
    if (inherits(private_key, "key")) {
      TRUE
    } else {
      FALSE
    }
  } else {
    checkmate::assert_file_exists(private_key)

    test <-
      private_key |>
      openssl::read_key(password = password) |>
      try(silent = TRUE)

    if (!inherits(test, "try-error")) {
      TRUE
    } else {
      FALSE
    }
  }
}

assert_private_key <- function(
  private_key = here::here(".ssh", "id_rsa"),
  password = NULL
) {
  if (!test_private_key(private_key, password)) {
    cli::cli_abort(paste(
      "The private key is not valid or ",
      "the password provided doesn't work with the key."
    ))
  }

  invisible(NULL)
}

assert_staticrypt <- function() {
  test <- staticrypt_command()

  if (test == "") {
    if (isTRUE(attr(test, "npm_missing"))) {
      cli::cli_abort(
        paste0(
          "The {.strong {cli::col_red('npm')}} command from ",
          "Node.js is not available. ",
          "Please install Node.js from https://nodejs.org ",
          "to use the staticrypt functionality."
        )
      )
    } else {
      cli::cli_abort(
        paste0(
          "The {.strong {cli::col_red('staticrypt')}} package is not ",
          "installed. Please run ",
          "{.strong {cli::col_blue('npm install staticrypt')}} ",
          "in a terminal to install it locally, or ",
          "{.strong {cli::col_blue('npm install -g staticrypt')}} ",
          "to install it globally."
        )
      )
    }
  } else {
    TRUE
  }
}
