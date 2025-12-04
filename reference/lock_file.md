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
#> ℹ Keys successfully created at /tmp/RtmpHVkJPh/dir199e22bb1feb.

con <- file(temp_file, "w+")
cat("Test", file = temp_file, sep = "\n")
list.files(temp_dir)
#> [1] "file199e2f71d34f" "id_rsa"           "id_rsa.pub"      
suppressWarnings(readLines(con))
#> [1] "Test"
close(con)

## Locking Files -----

temp_file |>
  lock_file(
    public_key = file.path(temp_dir, "id_rsa.pub")
  )
#> ℹ Locked file written at /tmp/RtmpHVkJPh/dir199e22bb1feb/file199e2f71d34f.lockr.

temp_file_locked <- paste0(temp_file, ".lockr")

con <- file(temp_file_locked, "rb")
list.files(temp_dir)
#> [1] "file199e2f71d34f.lockr" "id_rsa"                 "id_rsa.pub"            
suppressWarnings(readLines(con))
#> [1] "\037\x8b\b"                                                                                                                                                                                                                                                                                  
#> [2] "\xdf\xe8)<2V}ǰ\xe2\x9b\xe7\xa4\xfb[/\030\t\xde\021728\xb0\xbf3\xf6\xfa\002\xeb\xe9\xa9u\xe1敜\xbd\xa2\xf1\xdb\xfa\xee\xacr*\xaf>\031\021\xf4&\xb54cSݼ\x83[y\xeb\xacv,"                                                                                                                       
#> [3] "\x9be \xf3\xfe\x96\xf6w\x8f\020&\xbf\xd4\035\177N\177\x9e\xf7\xe1\x8c\xc8C\xa7\x8d;\xc2\031\xddZ,Nw\xc4\xce| \037j\xd7t\x9b}\xab.?îJ\x8d;\xb3\xa2\027p/\xf5"                                                                                                                                 
#> [4] "\xbd.\xf3?q\xcf\003\033\xfd\x8f\x97\xf3\xef\vod\xe38\xb5(\xeb\020\xe3\x84\t.6\xef4\xde\xf8\xc6,UQ\xb0۳\x8b)\xe4\xd9\xff\xa4\x87=\xd9U\x82\xae|\006\177\027L\xee8\xf94\xe6\xc8\"\xf3u\xbb\xa2*?\xbb\x89g\xae\xfe4\xf9\xf8\x99u_y\xdf$m\xd9xnb\xa9\xb0\xf3\xd9K\xa2k\x8aN\x9f\xfa\xb1\xf3\xd4Ԩ"
close(con)

## Unlocking Files -----

temp_file_locked |>
  unlock_file(
    private_key = file.path(temp_dir, "id_rsa")
  )
#> ℹ Unlocked file written at /tmp/RtmpHVkJPh/dir199e22bb1feb/file199e2f71d34f.

list.files(temp_dir)
#> [1] "file199e2f71d34f" "id_rsa"           "id_rsa.pub"      
con <- file(temp_file, "r+")
readLines(con)
#> [1] "Test"
close(con)
```
