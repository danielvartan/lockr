#' Encrypt or decrypt single files
#'
#' @description
#'
#' `lock_file()` and `unlock_file` encrypt or decrypt any kind of file using an
#' [OpenSSL](https://www.openssl.org/) RSA key pair.
#'
#' @param file A [`character`][base::character] string with the file path to be
#'   encrypted/decrypted. For security reasons, encrypted files must end with
#'   the suffix parameter.
#' @template params-public_key
#' @template params-private_key
#' @template params-suffix
#' @template params-remove_file
#' @template params-password
#'
#' @return An [invisible][base::invisible()] string containing the
#'   locked/unlocked file path.
#'
#' @family lock/unlock functions
#' @export
#'
#' @examples
#' ## Creating Test Files and Keys -----
#'
#' temp_dir <- tempfile("dir")
#' dir.create(temp_dir)
#'
#' temp_file <- tempfile(tmpdir = temp_dir)
#'
#' rsa_keygen(temp_dir)
#'
#' con <- file(temp_file, "w+")
#' cat("Test", file = temp_file, sep = "\n")
#' list.files(temp_dir)
#' suppressWarnings(readLines(con))
#' close(con)
#'
#' ## Locking Files -----
#'
#' temp_file |>
#'   lock_file(
#'     public_key = file.path(temp_dir, "id_rsa.pub")
#'   )
#'
#' temp_file_locked <- paste0(temp_file, ".lockr")
#'
#' con <- file(temp_file_locked, "rb")
#' list.files(temp_dir)
#' suppressWarnings(readLines(con))
#' close(con)
#'
#' ## Unlocking Files -----
#'
#' temp_file_locked |>
#'   unlock_file(
#'     private_key = file.path(temp_dir, "id_rsa")
#'   )
#'
#' list.files(temp_dir)
#' con <- file(temp_file, "r+")
#' readLines(con)
#' close(con)
lock_file <- function(
  file,
  public_key = here::here(".ssh", "id_rsa.pub"), #nolint
  suffix = ".lockr",
  remove_file = TRUE
) {
  checkmate::assert_string(file)
  checkmate::assert_file_exists(file)
  checkmate::assert_string(suffix, pattern = "^\\.")
  checkmate::assert_flag(remove_file)
  assert_public_key(public_key)

  locked_file_name <- paste0(file, suffix)

  if (grepl(paste0(stringr::str_escape(suffix), "$"), file)) {
    cli::cli_abort(
      paste0(
        "The file ",
        "{.strong {cli::col_red(basename(file))}} ",
        "already has the lock suffix ({.strong '{suffix}'})."
      )
    )
  }

  if (file.exists(locked_file_name)) {
    cli::cli_abort(
      paste0(
        "A locked file named ",
        "{.strong {cli::col_red(basename(locked_file_name))}} ",
        "already exists. Delete it or rename it."
      )
    )
  }

  file |>
    openssl::encrypt_envelope(public_key) |>
    saveRDS(locked_file_name)

  if (isTRUE(remove_file)) {
    file.remove(file)
  }

  if (file.exists(locked_file_name)) {
    cli::cli_alert_info(
      paste0(
        "Locked file written at ",
        "{.strong {cli::col_red(locked_file_name)}}."
      )
    )
  }

  invisible(locked_file_name)
}

#' @rdname lock_file
#' @export
unlock_file <- function(
  file,
  private_key = here::here(".ssh", "id_rsa"), #nolint
  suffix = ".lockr",
  remove_file = TRUE,
  password = NULL
) {
  pattern <- paste0(stringr::str_escape(suffix), "$")

  checkmate::assert_string(suffix, pattern = "^\\.")
  checkmate::assert_string(file)
  checkmate::assert_string(file, pattern = pattern)
  checkmate::assert_file_exists(file)
  checkmate::assert_flag(remove_file)
  checkmate::assert_string(password, null.ok = TRUE)
  assert_private_key(private_key, password)

  unlock_file_name <- gsub(pattern, "", file)

  if (file.exists(unlock_file_name)) {
    cli::cli_abort(
      paste0(
        "A file named ",
        "{.strong {cli::col_red(basename(unlock_file_name))}} ",
        "already exists. Delete it or rename it."
      )
    )
  }

  data <- readRDS(file)
  con <- file(unlock_file_name, "wb")

  data$data |>
    openssl::decrypt_envelope(
      data$iv,
      data$session,
      key = private_key,
      password = password
    ) |>
    writeBin(con)

  close(con)

  if (isTRUE(remove_file)) {
    file.remove(file)
  }

  if (file.exists(unlock_file_name)) {
    cli::cli_alert_info(
      paste0(
        "Unlocked file written at ",
        "{.strong {cli::col_red(unlock_file_name)}}."
      )
    )
  }

  invisible(unlock_file_name)
}
