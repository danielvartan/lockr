#' Generate and write a pair of RSA keys
#'
#' @description
#'
#' `rsa_keygen()` generates a pair of [OpenSSL](https://www.openssl.org/)
#' [RSA](https://en.wikipedia.org/wiki/RSA_cryptosystem) (Rivest-Shamir-Adleman)
#' private and public keys.
#'
#' @param dir (optional) A [`character`][base::character] string specifying the
#'   directory to save the generated keys (default: `here::here("_ssh")`)
#' @param password (optional) A [`character`][base::character] string specifying
#'   the password to protect the private key. If `NULL`, the private key will
#'   not be protected (default: `NULL`).
#' @param bits (optional) An integer number specifying the length of the RSA key
#'   in bits (default: `4096`).
#'
#' @return An [invisible][base::invisible()] `NULL`. This function is called
#'   for side effects only.
#'
#' @family utility functions
#' @export
#'
#' @examples
#' temp_dir <- tempfile("dir")
#' dir.create(temp_dir)
#'
#' temp_dir |>
#'   rsa_keygen(
#'     password = "test",
#'     bits = 2048
#'   )
#'
#' list.files(temp_dir)
rsa_keygen <- function(
  dir = here::here("_ssh"),
  password = NULL,
  bits = 2048
) {
  checkmate::assert_string(dir, null.ok = FALSE)
  checkmate::assert_directory_exists(dir)
  checkmate::assert_string(password, null.ok = TRUE)
  checkmate::assert_integerish(bits)

  key <- openssl::rsa_keygen(bits)
  openssl::write_pem(key, file.path(dir, "id_rsa"), password = password)
  openssl::write_pem(as.list(key)$pubkey, file.path(dir, "id_rsa.pub"))

  cli::cli_alert_info(
    paste0(
      "Keys successfully created at ",
      "{.strong {cli::col_red(dir)}}."
    )
  )

  invisible()
}
