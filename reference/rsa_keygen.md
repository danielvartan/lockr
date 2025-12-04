# Generate and write a pair of RSA keys

`rsa_keygen()` generates a pair of [OpenSSL](https://www.openssl.org/)
[RSA](https://en.wikipedia.org/wiki/RSA_cryptosystem)
(Rivest-Shamir-Adleman) private and public keys.

## Usage

``` r
rsa_keygen(dir = here::here("_ssh"), password = NULL, bits = 2048)
```

## Arguments

- dir:

  (optional) A [`character`](https://rdrr.io/r/base/character.html)
  string specifying the directory to save the generated keys (default:
  `here::here("_ssh")`)

- password:

  (optional) A [`character`](https://rdrr.io/r/base/character.html)
  string specifying the password to protect the private key. If `NULL`,
  the private key will not be protected (default: `NULL`).

- bits:

  (optional) An integer number specifying the length of the RSA key in
  bits (default: `4096`).

## Value

An [invisible](https://rdrr.io/r/base/invisible.html) `NULL`. This
function is called for side effects only.

## Examples

``` r
temp_dir <- tempfile("dir")
dir.create(temp_dir)

temp_dir |>
  rsa_keygen(
    password = "test",
    bits = 2048
  )
#> ℹ Keys successfully created at /tmp/RtmpHVkJPh/dir199e75ca946a.

list.files(temp_dir)
#> [1] "id_rsa"     "id_rsa.pub"
```
