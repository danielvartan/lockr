#' Encrypt or decrypt single files
#'
#' @description
#'
#' `r lifecycle::badge("maturing")`
#'
#' `lock_file()` and `unlock_file` can encrypt/decrypt any kind of file using an
#' RSA key pair. If your project doesn't have an RSA key pair, you can use
#' [rsa_keygen()] to create one.
#'
#' These functions use
#' [encrypt_envelope()][openssl::encrypt_envelope()] /
#' [decrypt_envelope()][openssl::decrypt_envelope()] to perform file
#' encryption/decryption. See those functions to learn more about the
#' encrypting/decrypting process.
#'
#' @param file A string with the file path to be encrypted/decrypted. For
#'   security reasons, encrypted files must end with the suffix parameter.
#'
#' @return An invisible string containing the locked/unlocked file path.
#'
#' @template param_private_key
#' @template param_public_key
#' @template param_remove_file
#' @template param_suffix
#' @template param_password
#'
#' @family lock/unlock functions
#' @export
#'
#' @examples
#' ## Locking files
#'
#' temp_dir <- tempfile("dir")
#' dir.create(temp_dir)
#' temp_file <- tempfile(tmpdir = temp_dir)
#' rsa_keygen(temp_dir)
#'
#' con <- file(temp_file, "w+")
#' cat("Test", file = temp_file, sep = "\n")
#' list.files(temp_dir)
#' suppressWarnings(readLines(con))
#' close(con)
#'
#' lock_file(temp_file, public_key = file.path(temp_dir, "id_rsa.pub"))
#'
#' temp_file_locked <- paste0(temp_file, ".lockr")
#' con <- file(temp_file_locked, "rb")
#' list.files(temp_dir)
#' suppressWarnings(readLines(con))
#' close(con)
#'
#' ## Unlocking files
#'
#' unlock_file(temp_file_locked, private_key = file.path(temp_dir, "id_rsa"))
#'
#' list.files(temp_dir)
#' con <- file(temp_file, "r+")
#' readLines(con)
#' close(con)
lock_file <- function(file, public_key = "./inst/ssh/id_rsa.pub",
                      suffix = ".lockr", remove_file = TRUE) {
    checkmate::assert_string(file)
    checkmate::assert_file_exists(file)
    checkmate::assert_string(suffix, pattern = "^\\.")
    checkmate::assert_flag(remove_file)
    assert_public_key(public_key)

    locked_file_name <- paste0(file, suffix)

    if (grepl(paste0(gutils:::escape_regex(suffix), "$"), file)) {
        cli::cli_abort(paste0(
            "The file ",
            "'{.strong {cli::col_red(basename(file))}}' ",
            "already has the lock suffix ({.strong '{suffix}'})."
        ))
    }

    if (file.exists(locked_file_name)) {
        cli::cli_abort(paste0(
            "A locked file named ",
            "'{.strong {cli::col_red(basename(locked_file_name))}}' ",
            "already exists. Delete it or rename it."
        ))
    }

    openssl::encrypt_envelope(
        data = file, pubkey = public_key
        ) %>%
        saveRDS(file = locked_file_name)

    if (isTRUE(remove_file)) file.remove(file)

    if (file.exists(locked_file_name)) {
        cli::cli_inform(paste0(
            "Locked file written at ",
            "'{.strong {cli::col_red(locked_file_name)}}'."
        ))
    }

    invisible(locked_file_name)
}

#' @rdname lock_file
#' @export
unlock_file <- function(file, private_key = "./inst/ssh/id_rsa",
                        suffix = ".lockr", remove_file = TRUE,
                        password = NULL) {
    checkmate::assert_string(suffix, pattern = "^\\.")
    pattern <- paste0(gutils:::escape_regex(suffix), "$")

    checkmate::assert_string(file)
    checkmate::assert_string(file, pattern = pattern)
    checkmate::assert_file_exists(file)
    checkmate::assert_flag(remove_file)
    checkmate::assert_string(password, null.ok = TRUE)
    assert_private_key(private_key, password)

    unlock_file_name <- gsub(pattern, "", file)

    if (file.exists(unlock_file_name)) {
        cli::cli_abort(paste0(
            "A file named ",
            "'{.strong {cli::col_red(basename(unlock_file_name))}}' ",
            "already exists. Delete it or rename it."
        ))
    }

    data <- readRDS(file)
    con <- file(unlock_file_name, "wb")
    openssl::decrypt_envelope(
        data$data, data$iv, data$session, key = private_key,
        password = password
        ) %>%
        writeBin(con)
    close(con)

    if (isTRUE(remove_file)) file.remove(file)

    if (file.exists(unlock_file_name)) {
        cli::cli_inform(paste0(
            "Unlocked file written at ",
            "'{.strong {cli::col_red(unlock_file_name)}}'."
        ))
    }

    invisible(unlock_file_name)
}
