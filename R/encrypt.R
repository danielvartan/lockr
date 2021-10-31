#' Encrypt/decrypt files from the `extdata` folder
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' `encrypt_extdata()` and `decrypt_extdata()` encrypt/decrypt files from
#' the `extdata` folder of an R package.
#'
#' @details
#'
#' When decrypting, a dialog window will open asking for the key password for
#' each file that must be decrypted. You can only run `decrypt_extdata()` in
#' [interactive][interactive()] mode.
#'
#' The keys must be in a folder named `ssh` that must be present in the system
#' folder (`inst`). The private and public keys must be named `id_rsa` and
#' `id_rsa.pub`, respectively.
#'
#' @param type (optional) a string indicating the folder of the `file` argument.
#'   If `NULL` the function will encrypt/decrypt all files in the `extdata`
#'   folder (default: `NULL`).
#' @param file (optional) a string indicating the file to encrypt/decrypt. If
#'   `file` is `NULL` and `type` is assigned, the function will encrypt/decrypt
#'   all files in the `type` folder (default: `NULL`).
#' @param remove_file (optional) a [`logical`][logical()] value indicating if
#'   the original file must be removed after the encryption/decryption (default:
#'   `TRUE`).
#' @param devtools_load (optional) a [`logical`][logical()] value indicating if
#'   the function must call `devtools::load_all(".")` before running. This is
#'   useful if you use [devtools][devtools::devtools-package] for package
#'   development. If `devtools_load = FALSE` and the dev package is not loaded,
#'   the function will use a installed version of the package.
#'
#' @template param_a
#' @family encrypt/decrypt functions
#' @export
#'
#' @examples
#' \dontrun{
#' encrypt_extdata()
#' decrypt_extdata()
#' }
encrypt_extdata <- function(type = NULL, file = NULL, remove_file = TRUE,
                            package = gutils:::get_package_name(),
                            devtools_load = TRUE) {
    checkmate::assert_string(package)
    root <- gutils:::find_path("extdata", package = package)

    assert_public_key()
    checkmate::assert_choice(type, list.files(root), null.ok = TRUE)
    checkmate::assert_character(file, min.len = 1, null.ok = TRUE)
    checkmate::assert_flag(remove_file)
    checkmate::assert_flag(devtools_load)

    if (isTRUE(devtools_load)) {
        devtools::load_all(rstudioapi::getActiveProject(), quiet = FALSE)

        return(encrypt_extdata(type, file, remove_file, package,
                               devtools_load = FALSE))
    }

    if (is.null(type) && is.null(file)) {
        for (i in list.files(root, recursive = TRUE)) {
            if (!grepl("\\.encryptr\\.bin$", i)) {
                encryptr::encrypt_file(file.path(root, i),
                                       public_key_path = get_public_key_path())

                if (isTRUE(remove_file)) file.remove(file.path(root, i))
            }
        }
    } else if (!is.null(type) && is.null(file)) {
        for (i in list.files(file.path(root, type))) {
            if (!grepl("\\.encryptr\\.bin$", i)) {
                encryptr::encrypt_file(file.path(root, type, i),
                                       public_key_path = get_public_key_path())

                if (isTRUE(remove_file)) file.remove(file.path(root, type, i))
            }
        }
    } else if (!is.null(type) && !is.null(file)) {
        for (i in file) {
            if (!(i %in% list.files(file.path(root, type)))) {
                cli::cli_abort(paste0(
                    "{cli::col_red(gutils:::single_quote_(i))} file cannot ",
                    "be found."
                ))
            }
        }

        for (i in file) {
            if (!grepl("\\.encryptr\\.bin$", i)) {
                encryptr::encrypt_file(file.path(root, type, i),
                                       public_key_path = get_public_key_path())

                if (isTRUE(remove_file)) file.remove(file.path(root, type, i))
            }
        }
    } else {
        cli::cli_abort(paste0(
            "When {cli::col_blue('file')} is assigned the ",
            "{cli::col_red('type')} argument cannot be ",
            "{cli::col_silver('NULL')}."
        ))
    }

    invisible(NULL)
}

#' @rdname encrypt_extdata
#' @export
decrypt_extdata <- function(type = NULL, file = NULL, remove_file = TRUE,
                            package = gutils:::get_package_name(),
                            devtools_load = TRUE) {
    checkmate::assert_string(package)
    root <- gutils:::find_path("extdata", package = package)

    assert_private_key()
    checkmate::assert_choice(type, list.files(root), null.ok = TRUE)
    checkmate::assert_character(file, min.len = 1, null.ok = TRUE)
    checkmate::assert_flag(remove_file)
    checkmate::assert_flag(devtools_load)

    if (isTRUE(devtools_load)) {
        devtools::load_all(rstudioapi::getActiveProject(), quiet = FALSE)

        return(decrypt_extdata(type, file, remove_file, package,
                               devtools_load = FALSE))
    }

    if (!is_interactive()) {
        cli::cli_abort("This function can only be used in interactive mode.")
    }

    if (is.null(type) && is.null(file)) {
        for (i in list.files(root, recursive = TRUE)) {
            if (grepl("\\.encryptr\\.bin$", i)) {
                encryptr::decrypt_file(file.path(root, i),
                                       private_key_path =
                                           get_private_key_path())

                if (isTRUE(remove_file)) file.remove(file.path(root, i))
            }
        }
    } else if (!is.null(type) && is.null(file)) {
        for (i in list.files(file.path(root, type))) {
            if (grepl("\\.encryptr\\.bin$", i)) {
                encryptr::decrypt_file(file.path(root, type, i),
                                       private_key_path =
                                           get_private_key_path())

                if (isTRUE(remove_file)) file.remove(file.path(root, type, i))
            }
        }
    } else if (!is.null(type) && !is.null(file)) {
        for (i in file) {
            if (!(i %in% list.files(file.path(root, type)))) {
                cli::cli_abort(paste0(
                    "{cli::col_red(gutils:::single_quote_(i))} file cannot be ",
                    "found."
                ))
            }
        }

        for (i in file) {
            if (grepl("\\.encryptr\\.bin$", i)) {
                encryptr::decrypt_file(file.path(root, type, i),
                                       private_key_path =
                                           get_private_key_path())

                if (isTRUE(remove_file)) file.remove(file.path(root, type, i))
            }
        }
    } else {
        cli::cli_abort(paste0(
            "When {cli::col_blue('file')} is assigned the ",
            "{cli::col_red('type')} argument cannot be ",
            "{cli::col_silver('NULL')}."
        ))
    }

    invisible(NULL)
}
