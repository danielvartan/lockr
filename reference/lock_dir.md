# Encrypt or decrypt all files in a directory

**WARNING**: Use this function with caution! Check the parameters
carefully.

`lock_dir()` and `unlock_dir()` encrypt or decrypt all files from a
given directory using an [OpenSSL](https://www.openssl.org/) RSA key
pair.

## Usage

``` r
lock_dir(
  dir,
  public_key = here::here("_ssh", "id_rsa.pub"),
  suffix = ".lockr",
  remove_file = TRUE
)

unlock_dir(
  dir,
  private_key = here::here("_ssh", "id_rsa"),
  suffix = ".lockr",
  remove_file = TRUE,
  password = NULL
)
```

## Arguments

- dir:

  A [`character`](https://rdrr.io/r/base/character.html) string
  indicating the directory to encrypt or decrypt.

- public_key:

  (optional) An
  [`openssl`](https://jeroen.r-universe.dev/openssl/reference/keygen.html)
  RSA public key or a
  [`character`](https://rdrr.io/r/base/character.html) string specifying
  the public key path. See
  [`rsa_keygen()`](https://danielvartan.github.io/lockr/reference/rsa_keygen.md)
  to learn how to create an RSA key pair (default:
  `here::here("_ssh", "id_rsa.pub")`).

- suffix:

  (optional) A [`character`](https://rdrr.io/r/base/character.html)
  string specifying the suffix to add when encrypting or remove when
  decrypting. Must start with `.` (default: `".lockr"`).

- remove_file:

  (optional) A [`logical`](https://rdrr.io/r/base/logical.html) value
  indicating if the original file must be removed after the
  encryption/decryption process (default: `TRUE`).

- private_key:

  (optional) An
  [`openssl`](https://jeroen.r-universe.dev/openssl/reference/keygen.html)
  RSA private key or a
  [`character`](https://rdrr.io/r/base/character.html) string specifying
  the private key path. See
  [`rsa_keygen()`](https://danielvartan.github.io/lockr/reference/rsa_keygen.md)
  to learn how to create an RSA key pair (default:
  `here::here("_ssh", "id_rsa")`).

- password:

  (optional) A [`character`](https://rdrr.io/r/base/character.html)
  string specifying the password for decrypting a protected private key.
  For security, avoid hardcoding passwords in scripts. Use
  [`askpass()`](https://r-lib.r-universe.dev/askpass/reference/askpass.html)
  to prompt for secure input (default: `NULL`).

## Value

An [invisible](https://rdrr.io/r/base/invisible.html) `NULL`. These
functions are called for side effects only.

## See also

Other lock/unlock functions:
[`lock_file()`](https://danielvartan.github.io/lockr/reference/lock_file.md),
[`save_and_lock()`](https://danielvartan.github.io/lockr/reference/save_and_lock.md)

## Examples

``` r
## Locking files -----

ssh_dir <- tempfile("ssh")
dir.create(ssh_dir)

rsa_keygen(ssh_dir)
#> ℹ Keys successfully created at /tmp/RtmpHVkJPh/ssh199e96e8880.

temp_dir <- tempfile("dir")
dir.create(temp_dir)

for (i in seq_len(5)) file.create(tempfile(tmpdir = temp_dir))

list.files(temp_dir)
#> [1] "file199e4d3ecae1" "file199e4dd55f81" "file199e6bc21bfe" "file199e96e4bf4" 
#> [5] "file199ebd9ffa5" 

temp_dir |>
  lock_dir(
    public_key = file.path(ssh_dir, "id_rsa.pub")
  )
#> ℹ Locked file written at /tmp/RtmpHVkJPh/dir199e3bd20db6/file199e4d3ecae1.lockr.
#> ℹ Locked file written at /tmp/RtmpHVkJPh/dir199e3bd20db6/file199e4dd55f81.lockr.
#> ℹ Locked file written at /tmp/RtmpHVkJPh/dir199e3bd20db6/file199e6bc21bfe.lockr.
#> ℹ Locked file written at /tmp/RtmpHVkJPh/dir199e3bd20db6/file199e96e4bf4.lockr.
#> ℹ Locked file written at /tmp/RtmpHVkJPh/dir199e3bd20db6/file199ebd9ffa5.lockr.

## Unlocking files -----

temp_dir |>
  unlock_dir(
    private_key = file.path(ssh_dir, "id_rsa")
  )
#> ℹ Unlocked file written at /tmp/RtmpHVkJPh/dir199e3bd20db6/file199e4d3ecae1.
#> ℹ Unlocked file written at /tmp/RtmpHVkJPh/dir199e3bd20db6/file199e4dd55f81.
#> ℹ Unlocked file written at /tmp/RtmpHVkJPh/dir199e3bd20db6/file199e6bc21bfe.
#> ℹ Unlocked file written at /tmp/RtmpHVkJPh/dir199e3bd20db6/file199e96e4bf4.
#> ℹ Unlocked file written at /tmp/RtmpHVkJPh/dir199e3bd20db6/file199ebd9ffa5.
```
