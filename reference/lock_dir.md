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
#> ℹ Keys successfully created at /tmp/RtmpfEtUMP/ssh19857ab5dd16.

temp_dir <- tempfile("dir")
dir.create(temp_dir)

for (i in seq_len(5)) file.create(tempfile(tmpdir = temp_dir))

list.files(temp_dir)
#> [1] "file198533f534cc" "file1985519cb043" "file198570c4c9b"  "file198580b219d" 
#> [5] "file1985d226a58" 

temp_dir |>
  lock_dir(
    public_key = file.path(ssh_dir, "id_rsa.pub")
  )
#> ℹ Locked file written at /tmp/RtmpfEtUMP/dir19857a91e503/file198533f534cc.lockr.
#> ℹ Locked file written at /tmp/RtmpfEtUMP/dir19857a91e503/file1985519cb043.lockr.
#> ℹ Locked file written at /tmp/RtmpfEtUMP/dir19857a91e503/file198570c4c9b.lockr.
#> ℹ Locked file written at /tmp/RtmpfEtUMP/dir19857a91e503/file198580b219d.lockr.
#> ℹ Locked file written at /tmp/RtmpfEtUMP/dir19857a91e503/file1985d226a58.lockr.

## Unlocking files -----

temp_dir |>
  unlock_dir(
    private_key = file.path(ssh_dir, "id_rsa")
  )
#> ℹ Unlocked file written at /tmp/RtmpfEtUMP/dir19857a91e503/file198533f534cc.
#> ℹ Unlocked file written at /tmp/RtmpfEtUMP/dir19857a91e503/file1985519cb043.
#> ℹ Unlocked file written at /tmp/RtmpfEtUMP/dir19857a91e503/file198570c4c9b.
#> ℹ Unlocked file written at /tmp/RtmpfEtUMP/dir19857a91e503/file198580b219d.
#> ℹ Unlocked file written at /tmp/RtmpfEtUMP/dir19857a91e503/file1985d226a58.
```
