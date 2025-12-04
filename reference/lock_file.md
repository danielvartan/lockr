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
#> ℹ Keys successfully created at /tmp/RtmpjlNzSx/dir19d817a33900.

con <- file(temp_file, "w+")
cat("Test", file = temp_file, sep = "\n")
list.files(temp_dir)
#> [1] "file19d81ec98173" "id_rsa"           "id_rsa.pub"      
suppressWarnings(readLines(con))
#> [1] "Test"
close(con)

## Locking Files -----

temp_file |>
  lock_file(
    public_key = file.path(temp_dir, "id_rsa.pub")
  )
#> ℹ Locked file written at /tmp/RtmpjlNzSx/dir19d817a33900/file19d81ec98173.lockr.

temp_file_locked <- paste0(temp_file, ".lockr")

con <- file(temp_file_locked, "rb")
list.files(temp_dir)
#> [1] "file19d81ec98173.lockr" "id_rsa"                 "id_rsa.pub"            
suppressWarnings(readLines(con))
#> [1] "\037\x8b\b"                                                                                                                                                                                                                                                                                                 
#> [2] "\xf5\xb57\a]\x90n\027d{\xfb<\xa4\x93\xebȊ\xa7M.\xabrE\xeb~Y\xe6\x88>\xf6I\xbd`i\xc7\032\xbcY$\xdel\xcb\xc1\xad\xe6\f\xfb\x9fm\xf8\xc8\xc1\xc3x\x8c]\xe6S\xf0\xab2\xcešj\xf1rf>\xa5S\xba\xccB-\xe7\u07be\xd1ȷ\xa8\xad\xe0\xb07\xdbO+\xa6\xc3\002\xa6u\x92\xd6'\xaf|m"                                        
#> [3] "\022Ov\xb2/] \xc9|\xff\x9d\xcda\xf3\xb9\023\x9e\x9d;6_\xe7/S\xce\xe1\033\x9a\xa9B\xc1\x8d{v%E\xb4\037\xf3N\xbb\xf4t\x93\xf0|\xf3\xd4\xc97\177\xcb\xdc\xe9џ\xff+L\x80y\xc6S\xb5ç?=\xe7\xd0f\xbc\xd8w \xf0>\x9fD\x8a\x92\xac\x9f\xb2ّ\\A\xc9e\x9eO\xb9a\xe1S\xb7\xfb\xb8W\026\xdf\027\xfdǛk\x8d\xefpn\x90a``ab"
#> [4] "!\xa1"                                                                                                                                                                                                                                                                                                      
#> [5] "\026d\xca,\x83\xb2؋S\x8b\x8b3\xf3\xf3\xa0\\\x96\x94ĒD \xfd\017"                                                                                                                                                                                                                                             
close(con)

## Unlocking Files -----

temp_file_locked |>
  unlock_file(
    private_key = file.path(temp_dir, "id_rsa")
  )
#> ℹ Unlocked file written at /tmp/RtmpjlNzSx/dir19d817a33900/file19d81ec98173.

list.files(temp_dir)
#> [1] "file19d81ec98173" "id_rsa"           "id_rsa.pub"      
con <- file(temp_file, "r+")
readLines(con)
#> [1] "Test"
close(con)
```
