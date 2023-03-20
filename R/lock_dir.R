#' Encrypt or decrypt all files in a directory
#'
#' @description
#'
#' `r lifecycle::badge("maturing")`
#'
#' __WARNING__: This function must be used with caution! Check the parameters
#' carefully.
#'
#' `lock_dir()` and `unlock_dir()` can encrypt or decrypt all files from a given
#' directory.
#'
#' @param dir A string indicating the directory to encrypt/decrypt. (default:
#'   `"./inst/extdata"`).
#'
#' @return An invisible `NULL`. These functions are called just for side
#'   effects.
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
#' ssh_dir <- tempfile("ssh")
#' dir.create(ssh_dir)
#' rsa_keygen(ssh_dir)
#'
#' temp_dir <- tempfile("dir")
#' dir.create(temp_dir)
#' for (i in seq(5)) {
#'     file.create(tempfile(tmpdir = temp_dir))
#' }
#' list.files(temp_dir)
#'
#' lock_dir(temp_dir, public_key = file.path(ssh_dir, "id_rsa.pub"))
#'
#' ## Unlocking files
#'
#' unlock_dir(temp_dir, private_key = file.path(ssh_dir, "id_rsa"))
lock_dir <- function(dir = "./inst/extdata",
                     public_key = "./inst/ssh/id_rsa.pub",
                     suffix = ".lockr", remove_file = TRUE) {
    checkmate::assert_string(dir)
    checkmate::assert_directory_exists(dir)
    checkmate::assert_string(suffix, pattern = "^\\.")
    checkmate::assert_flag(remove_file)
    assert_public_key(public_key)

    try_to_lock <- function(file, public_key = "./inst/ssh/id_rsa.pub",
                         suffix = ".lockr", remove_file = TRUE) {
        out <- try(
            lock_file(file, public_key, suffix, remove_file),
            silent = TRUE
            )

        if (grepl(paste0(gutils:::escape_regex(suffix), "$"), file)) {
            "Next"
        } else if (!inherits(out, "try-error")) {
            out
        } else {
            cli::cli_inform(paste0(
                "An error occurred while trying to lock ",
                "'{.strong {cli::col_red(file)}}'."
            ))

            "Error"
        }
    }

    vapply(
        list.files(dir, full.names = TRUE, recursive = TRUE), try_to_lock,
        character(1), public_key = public_key, suffix = suffix,
        remove_file = remove_file
    )

    invisible(NULL)
}

#' @rdname lock_dir
#' @export
unlock_dir <- function(dir = "./inst/extdata",
                       private_key = "./inst/ssh/id_rsa",
                       suffix = ".lockr", remove_file = TRUE, password = NULL) {
    checkmate::assert_string(dir)
    checkmate::assert_directory_exists(dir)
    checkmate::assert_string(suffix, pattern = "^\\.")
    checkmate::assert_flag(remove_file)
    checkmate::assert_string(password, null.ok = TRUE)
    assert_private_key(private_key, password)

    try_to_unlock <- function(file, private_key = "./inst/ssh/id_rsa",
                           suffix = ".lockr", remove_file = TRUE,
                           password = NULL) {
        out <- try(
            unlock_file(
                file, private_key, suffix, remove_file, password
                ),
            silent = TRUE
            )

        if (!grepl(paste0(gutils:::escape_regex(suffix), "$"), file)) {
            "Next"
        } else if (!inherits(out, "try-error")) {
            out
        } else {
            cli::cli_inform(paste0(
                "An error occurred while trying to unlock ",
                "'{.strong {cli::col_red(file)}}'."
            ))

            "Error"
        }
    }

    vapply(
        list.files(dir, full.names = TRUE, recursive = TRUE), try_to_unlock,
        character(1), private_key = private_key, suffix = suffix,
        remove_file = remove_file, password = password
        )

    invisible(NULL)
}
