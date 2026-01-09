#' @param private_key (optional) An [`openssl`][openssl::rsa_keygen()] RSA
#'   private key or a [`character`][base::character()] string specifying the
#'   private key path. See [rsa_keygen()] to learn how to create an RSA key pair
#'   (default: `here::here(".ssh", "id_rsa")`).
