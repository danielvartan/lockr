#' Encrypt/decrypt files of a package
#'
#' @description
#'
#' `r lifecycle::badge("maturing")`
#'
#' __WARNING__: This function must be used with caution! Check the parameters
#' very carefully.
#'
#' `lock_dir()` and `unlock_dir()` encrypt/decrypt all files from a given
#' directory.
#'
#' @details
#'
#' When decrypting, a dialog window will open asking for the key password for
#' each file that must be decrypted. You can only run `unlock_dir()` in
#' [interactive][interactive()] mode.
#'
#' The keys must be in a folder named `ssh` that must be present in the system
#' folder (`inst`). The private and public keys must be named `id_rsa` and
#' `id_rsa.pub`, respectively.
#'
#' @param dir a string indicating the folder to encrypt/decrypt. (default:
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



    vapply(
        list.files(dir, full.names = TRUE, recursive = TRUE), lock_file,
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

    vapply(
        list.files(dir, full.names = TRUE, recursive = TRUE), unlock_file,
        character(1), private_key = private_key, suffix = suffix,
        remove_file = remove_file, password = password
        )

    invisible(NULL)
}
