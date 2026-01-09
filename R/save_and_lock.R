#' Save and lock a file
#'
#' @description
#'
#' `save_and_lock()` saves a data frame or R object to a file and then locks
#'   it using [RSA](https://en.wikipedia.org/wiki/RSA_cryptosystem) encryption.
#'
#' @param x An R object to be saved and locked. If `type = "csv"`, `x` must be
#'   a [`data.frame`][base::data.frame()].
#' @param file A [`character`][base::character] string indicating the file path
#'   to save the object to.
#' @param type A [`character`][base::character] string indicating the file type
#'   to save the object as. Must be one of `"csv"` or `"rds"`
#'   (default: `"rds"`).
#' @template params-public_key
#' @param ... (optional) Additional arguments passed to
#'   [`write_csv`][readr::write_csv()] or [`write_rds`][readr::write_rds()].
#'
#' @return An [invisible][base::invisible()] string containing the locked file
#'   path.
#'
#' @family lock/unlock functions
#' @export
#'
#' @examples
#' ## Creating Keys and Test Object -----
#'
#' temp_dir <- tempfile("dir")
#' dir.create(temp_dir)
#'
#' rsa_keygen(temp_dir)
#'
#' x <- letters
#'
#' ## Locking and Saving Objects -----
#'
#' x |>
#'   save_and_lock(
#'     file = tempfile(),
#'     type = "rds",
#'     public_key = file.path(temp_dir, "id_rsa.pub")
#'   )
save_and_lock <- function(
  x,
  file,
  type = "rds",
  public_key = here::here(".ssh", "id_rsa.pub"),
  ...
) {
  checkmate::assert_path_for_output(file, overwrite = TRUE)
  checkmate::assert_choice(type, c("csv", "rds"))

  if (type == "csv") {
    checkmate::assert_data_frame(x)

    readr::write_csv(x, file, ...)

    if (checkmate::test_file_exists(paste0(file, ".lockr"))) {
      fs::file_delete(paste0(file, ".lockr"))
    }

    lock_file(file, public_key, remove_file = TRUE)
  } else {
    readr::write_rds(x, file, ...)

    if (checkmate::test_file_exists(paste0(file, ".lockr"))) {
      fs::file_delete(paste0(file, ".lockr"))
    }

    lock_file(file, public_key, remove_file = TRUE)
  }

  paste0(file, ".lockr")
}
