#' Generate and write a pair of RSA keys
#'
#' `rsa_keygen()` generates a pair of RSA (Rivest-Shamir-Adleman) private and
#' public keys for your project.
#'
#' @param dir (optional) a string specifying the directory to save the generated
#'   keys (default: `"./inst/ssh"`)
#' @param password (optional) a string specifying the password to protect the
#'   private key. If `NULL`, the private key will not be protected (default:
#'   `NULL`).
#' @param bits (optional) an integer number specifying the length of the RSA key
#'   in bits (default: `2048`).
#'
#' @return An invisible `NULL`. This function is called  for side effects only.
#'
#' @family utility functions
#' @export
#'
#' @examples
#' temp_dir <- tempfile("dir")
#' dir.create(temp_dir)
#'
#' rsa_keygen(dir = temp_dir, password = "test", bits = 2048)
#'
#' list.files(temp_dir)
rsa_keygen <- function(dir = "./inst/ssh", password = NULL, bits = 2048) {
  checkmate::assert_string(dir, null.ok = FALSE)
  checkmate::assert_directory_exists(dir)
  checkmate::assert_string(password, null.ok = TRUE)
  checkmate::assert_integerish(bits)

  key <- openssl::rsa_keygen(bits)
  openssl::write_pem(key, file.path(dir, "id_rsa"), password = password)
  openssl::write_pem(as.list(key)$pubkey, file.path(dir, "id_rsa.pub"))

  cli::cli_inform("Keys successfully created at '{.strong {dir}}'.")

  invisible(NULL)
}
