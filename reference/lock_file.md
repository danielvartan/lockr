# Encrypt or decrypt single files

`lock_file()` and `unlock_file` encrypt or decrypt any kind of file
using an [OpenSSL](https://www.openssl.org/) RSA key pair.

## Usage

``` r
lock_file(
  file,
  public_key = here::here("_ssh", "id_rsa.pub"),
  suffix = ".lockr",
  remove_file = TRUE
)

unlock_file(
  file,
  private_key = here::here("_ssh", "id_rsa"),
  suffix = ".lockr",
  remove_file = TRUE,
  password = NULL
)
```

## Arguments

- file:

  A [`character`](https://rdrr.io/r/base/character.html) string with the
  file path to be encrypted/decrypted. For security reasons, encrypted
  files must end with the suffix parameter.

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

An [invisible](https://rdrr.io/r/base/invisible.html) string containing
the locked/unlocked file path.

## See also

Other lock/unlock functions:
[`lock_dir()`](https://danielvartan.github.io/lockr/reference/lock_dir.md),
[`save_and_lock()`](https://danielvartan.github.io/lockr/reference/save_and_lock.md)

## Examples

``` r
## Creating Test Files and Keys -----

temp_dir <- tempfile("dir")
dir.create(temp_dir)

temp_file <- tempfile(tmpdir = temp_dir)

rsa_keygen(temp_dir)
#> ℹ Keys successfully created at /tmp/RtmpfEtUMP/dir19851efab48b.

con <- file(temp_file, "w+")
cat("Test", file = temp_file, sep = "\n")
list.files(temp_dir)
#> [1] "file1985726510bf" "id_rsa"           "id_rsa.pub"      
suppressWarnings(readLines(con))
#> [1] "Test"
close(con)

## Locking Files -----

temp_file |>
  lock_file(
    public_key = file.path(temp_dir, "id_rsa.pub")
  )
#> ℹ Locked file written at /tmp/RtmpfEtUMP/dir19851efab48b/file1985726510bf.lockr.

temp_file_locked <- paste0(temp_file, ".lockr")

con <- file(temp_file_locked, "rb")
list.files(temp_dir)
#> [1] "file1985726510bf.lockr" "id_rsa"                 "id_rsa.pub"            
suppressWarnings(readLines(con))
#> [1] "\037\x8b\b"                                                                                                                                                                                                                                                                                                                                                               
#> [2] "\x98x\xea\xb6\xd6c\xae}\x99\017g\x9fZq\xf5p\xfa\xea\x8bΥv\027L\xb3'\xf5\xb2.t\xda\xca\xd3Uw\xfb|f_\xe8O\037c\xb9\xf2u\xfa\xaaVa\xbe1\xb3\xae\xee>\xd5\\9g\x87\xd3)\xa3\xa4\xb7\xc6\xe1b\xbfu\xe2\x94R4\xb7zl\f\x94"                                                                                                                                                       
#> [3] "\xbf\xfa\xf8\xfc\xee\xd9\xecѱ\006\022B\x9e\xab\xc25\f6\037\xf2ʘh\030\xb0\xb8yV\xdaM\xee\022\xee)\xb3n\x9e\xaf\xca_(}5\xec]yP\xbd\xe8κM\x91\xa7\024\016\xc9|4\xf1\xfcb,^\xf9\xb3\xaa\xf2\x83\xb7h\xcc\xd7\xc8=[\x8f\xed\xf9\xf5\xb6p\xd7\xe5m6ۄ-Y\034-S\xde\xcf\xf4\021?\x9d5\xf9\x8b\035,|\xaeeM\xe1;\xe8w\xae\x8be\xcb\037㛡\xda\017\030\030X\x98\030@\001\xc4\xc2\xc0\t"
#> [4] "Լ\xc4\xdc\xd4b\x90BHh\x83\005\x992ˠ,\xf6\xe2\xd4\xe2\xe2\xcc\xfc<(\x97%%\xb1$\021H\xff\003"                                                                                                                                                                                                                                                                               
close(con)

## Unlocking Files -----

temp_file_locked |>
  unlock_file(
    private_key = file.path(temp_dir, "id_rsa")
  )
#> ℹ Unlocked file written at /tmp/RtmpfEtUMP/dir19851efab48b/file1985726510bf.

list.files(temp_dir)
#> [1] "file1985726510bf" "id_rsa"           "id_rsa.pub"      
con <- file(temp_file, "r+")
readLines(con)
#> [1] "Test"
close(con)
```
