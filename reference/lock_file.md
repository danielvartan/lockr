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
#> ℹ Keys successfully created at /tmp/Rtmpu67Iup/dir19f650bc8d4d.

con <- file(temp_file, "w+")
cat("Test", file = temp_file, sep = "\n")
list.files(temp_dir)
#> [1] "file19f67182e13a" "id_rsa"           "id_rsa.pub"      
suppressWarnings(readLines(con))
#> [1] "Test"
close(con)

## Locking Files -----

temp_file |>
  lock_file(
    public_key = file.path(temp_dir, "id_rsa.pub")
  )
#> ℹ Locked file written at /tmp/Rtmpu67Iup/dir19f650bc8d4d/file19f67182e13a.lockr.

temp_file_locked <- paste0(temp_file, ".lockr")

con <- file(temp_file_locked, "rb")
list.files(temp_dir)
#> [1] "file19f67182e13a.lockr" "id_rsa"                 "id_rsa.pub"            
suppressWarnings(readLines(con))
#> [1] "\037\x8b\b"                                                                                                                                                                                                                                          
#> [2] "\xcbַ\xf7\xb9\xb7\xab\xae\xd8c\xb3\xbdH\xb6%\xbbJ\xf6\xff\035\x87\x9f\xf5\xf5\x97>\xbb\xc5sH\x96\xbd\xfb\036\xbb\x9c\xed\023\xb7Ef\xf8Z;\x96\x86=\x9f8\xb9\x98\xa4N9-\017\xf8'j?\x8by9ӻ\031\xf2\xa2w\035&\xe7.\xe5\x9f_\xe0'\xfc*u\xae\x9c\xf8\xb2r\x8f\xf4"
#> [3] "n\xcf6\x9d[\xa7\x96\xc4m\xbf\xe8\xee\xef\xff\006\x97Rċ\x8e\177\xfe2\xb9\xe3N\xa2\xff\xeb\xf4\xd3\027\x96d]\x9eƘ\xf1\xdc^$R~\v\xfb\xf2\xc5\xcfU\x9d\xc4n\xb4(\xe7\xdd\xe4\xe3"                                                                        
#> [4] "\xde\xec)\025\xe2\0366\xff\xf6\017\x9d\x9b.E\037w\xd4(\xae2\x8e~\xa0\024\xbf\xa5d\xadb\x88ы\xca9\xcf~;\034\bl\xbf$\030}m\x87[\x85O\x86\x9e\xa7\xb6\x87\xf4ꆧ\034\xbe"                                                                                
#> [5] "\xfeO\xbag\x96\004\t_\016\xb8\xcc\xdb\xf8$\xe5`z\xfb\xebČٕ\xbe\x97\xaf2|\x9a \xfb\xb6\xbb,u\x9bpI\xee\xb1\xe9\x9a\xcb\f\x8f\xc1\u0087\xe7lw\xfe\024w\xe3\xff\xeb/\xf3\xed`k\xe3\xeee``ab"                                                             
#> [6] "!\xa1"                                                                                                                                                                                                                                               
#> [7] "\026d\xca,\x83\xb2؋S\x8b\x8b3\xf3\xf3\xa0\\\x96\x94ĒD \xfd\017"                                                                                                                                                                                      
close(con)

## Unlocking Files -----

temp_file_locked |>
  unlock_file(
    private_key = file.path(temp_dir, "id_rsa")
  )
#> ℹ Unlocked file written at /tmp/Rtmpu67Iup/dir19f650bc8d4d/file19f67182e13a.

list.files(temp_dir)
#> [1] "file19f67182e13a" "id_rsa"           "id_rsa.pub"      
con <- file(temp_file, "r+")
readLines(con)
#> [1] "Test"
close(con)
```
