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
#> ℹ Keys successfully created at /tmp/RtmpGfFehy/dir197f4f67908d.

con <- file(temp_file, "w+")
cat("Test", file = temp_file, sep = "\n")
list.files(temp_dir)
#> [1] "file197f602e1bc3" "id_rsa"           "id_rsa.pub"      
suppressWarnings(readLines(con))
#> [1] "Test"
close(con)

## Locking Files -----

temp_file |>
  lock_file(
    public_key = file.path(temp_dir, "id_rsa.pub")
  )
#> ℹ Locked file written at /tmp/RtmpGfFehy/dir197f4f67908d/file197f602e1bc3.lockr.

temp_file_locked <- paste0(temp_file, ".lockr")

con <- file(temp_file_locked, "rb")
list.files(temp_dir)
#> [1] "file197f602e1bc3.lockr" "id_rsa"                 "id_rsa.pub"            
suppressWarnings(readLines(con))
#> [1] "\037\x8b\b"                                                                                                                                                                                                                                                                                                                                                                                                                                                        
#> [2] "\xa7\003V}\xcc\xdb\xd19\xa5B\xc5\xc7uz\xdaN\xff\xd8\017\034\032\016\xf5rw\x9e\xe5\xd9\036\xfc!o\xf5Wƹ\xa8|V\xa1s\x9a\xa8\xa6\xf9\xd3"                                                                                                                                                                                                                                                                                                                              
#> [3] "\xb2\x85A\xefW\x9dc˒x|@}\xc1\xb6\027\xf1\xf6ғn\006̽\xff\xf0h\xf1۩\xd9\xcbf\x9b\x9f\xee\xd2\026\xb5\xe9)"                                                                                                                                                                                                                                                                                                                                                            
#> [4] ">t'\xd6\xc1\x80q\xab\xd42\xfe;\xfeI;\xcd\xea\x9f\xd8_\xbbr\xb8G\xe81\017\xe3\xfe\t\xa53:\xb2\xdc6<\xcf-W\\\xf5\xa4\xc2U\xf4\xa4\xe6\xe98\x91\xb5}Ϛ\x95\xfen\xd8-Z\xf1.j~\xa7ҍ\xb7*\xde\xc9k\xe5>\033o(\xe0_\xffv\xc2\xfe\xdeS\023\xfeN\xfb\xe8\031V\xfc\xbe\xa2l\xa2\xfe\x8aț\034\xdc1?\x9c\031\xef\x9e\xf8\xed.ś\xab\xd4R\xfce\006k\xd1To.\xc9u\xb5\xe7\xee\025^~\xb5\xa4I\xbd\xf6\xa8Sݤ\xe5\xe2\032.N_\x9e\xb5d\xfc\xfc\xbeb\xfd\xe7\xfd\xfffnu\xee\xd1^\xaa\xe2"
#> [5] "\v\x9f\xb2ݼ{\0376[_\xb3\x8f\xabN\021"                                                                                                                                                                                                                                                                                                                                                                                                                              
#> [6] "\xf8v\x98\x81\x81\x85\x89\001\024@,\f\x9c\xa0@\xcdK\xccM-\006)\x84\x846X\x90)\xb3\f\xcab/N-.\xce\xccσrYR\022K\022\x81\xf4?"                                                                                                                                                                                                                                                                                                                                        
close(con)

## Unlocking Files -----

temp_file_locked |>
  unlock_file(
    private_key = file.path(temp_dir, "id_rsa")
  )
#> ℹ Unlocked file written at /tmp/RtmpGfFehy/dir197f4f67908d/file197f602e1bc3.

list.files(temp_dir)
#> [1] "file197f602e1bc3" "id_rsa"           "id_rsa.pub"      
con <- file(temp_file, "r+")
readLines(con)
#> [1] "Test"
close(con)
```
