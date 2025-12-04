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
#> ℹ Keys successfully created at /tmp/RtmpBG40kY/dir19ba1a5e0b3.

con <- file(temp_file, "w+")
cat("Test", file = temp_file, sep = "\n")
list.files(temp_dir)
#> [1] "file19ba4f650524" "id_rsa"           "id_rsa.pub"      
suppressWarnings(readLines(con))
#> [1] "Test"
close(con)

## Locking Files -----

temp_file |>
  lock_file(
    public_key = file.path(temp_dir, "id_rsa.pub")
  )
#> ℹ Locked file written at /tmp/RtmpBG40kY/dir19ba1a5e0b3/file19ba4f650524.lockr.

temp_file_locked <- paste0(temp_file, ".lockr")

con <- file(temp_file_locked, "rb")
list.files(temp_dir)
#> [1] "file19ba4f650524.lockr" "id_rsa"                 "id_rsa.pub"            
suppressWarnings(readLines(con))
#> [1] "\037\x8b\b"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
#> [2] "u\xabW.ؘ\xfb\xf1\xd1ͅo"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
#> [3] "u\xf3\xaej\033:mxg[!\xb2\x95'\xbc\xff\xad\x97\xd0-\xbf\xdc]a\006k\xdd\xf2\xd7\xf1Tj[}\\\x91\xefZ|$\xd5\xf6\xd3_\xddOɓ\xa7|\xbc\\\xd7,\xf2\xa0\xf2\xa5\xabiD\xea\x95\xe2\024\t\xfeW\xb3\xaa\xd9\xf7>s\\shբ\xf8\x9f\x97\x92e\002\xc4\xe6\xb8ι^-\x98\xf9\xe69/\xdbJk\xd9\025\xfd\xca7\x83\xfdW\xae\xbe\xfd\xe8%\xb7\xf0\xd4D\xd5/\x9e\037\x8dk\xb2\037լ\xb4Q}s\xa6\xe4\xc1\xa4\xb7\xc1\037\xb5~~^w\xb4Y̔\xb3\xb8\x8fq\xa1\u05f5\036\x86DX\xf8\030*m].\xcaњ\xac:\xe1\xe1%\xf7\xc3{t\030\030X\x98\030@\001\xc4\xc2\xc0\t"
#> [4] "Լ\xc4\xdc\xd4b\x90BHh\x83\005\x992ˠ,\xf6\xe2\xd4\xe2\xe2\xcc\xfc<(\x97%%\xb1\004d\xf2?"                                                                                                                                                                                                                                                                                                                                                                                                                            
close(con)

## Unlocking Files -----

temp_file_locked |>
  unlock_file(
    private_key = file.path(temp_dir, "id_rsa")
  )
#> ℹ Unlocked file written at /tmp/RtmpBG40kY/dir19ba1a5e0b3/file19ba4f650524.

list.files(temp_dir)
#> [1] "file19ba4f650524" "id_rsa"           "id_rsa.pub"      
con <- file(temp_file, "r+")
readLines(con)
#> [1] "Test"
close(con)
```
