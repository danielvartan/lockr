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
  string specifying the password to read the private key (**only for
  protected keys**). Don´t type passwords on the console, use
  [askpass()](https://r-lib.r-universe.dev/askpass/reference/askpass.html)
  instead (default: `NULL`).

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
#> ℹ Keys successfully created at /tmp/RtmpEFRbN0/dir1ada3591d95f.

con <- file(temp_file, "w+")
cat("Test", file = temp_file, sep = "\n")
list.files(temp_dir)
#> [1] "file1ada49d462ad" "id_rsa"           "id_rsa.pub"      
suppressWarnings(readLines(con))
#> [1] "Test"
close(con)

## Locking Files -----

temp_file |>
  lock_file(
    public_key = file.path(temp_dir, "id_rsa.pub")
  )
#> ℹ Locked file written at /tmp/RtmpEFRbN0/dir1ada3591d95f/file1ada49d462ad.lockr.

temp_file_locked <- paste0(temp_file, ".lockr")

con <- file(temp_file_locked, "rb")
list.files(temp_dir)
#> [1] "file1ada49d462ad.lockr" "id_rsa"                 "id_rsa.pub"            
suppressWarnings(readLines(con))
#> [1] "\037\x8b\b"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
#> [2] "\002\x8f\xdb\f\xee\xd4\031.YRs\xa8\xc3}~]m\xb0\xf0*\xabwvW\xe6\xc9\xf8\xaa\006\xff"                                                                                                                                                                                                                                                                                                                                                                                                                                   
#> [3] "\xdbcv\xf0\a\xd3]ӄ5W7粸&\034\xaf?\xf0\xfby\x87\xa0T\xd0\xcd\xc4\xcc\xf8#Ώ\xfdw;o;\xbajN\xf4|\023>\xed\x98K\x95\xb7\xa7VE\xcan>8K\xe3D\xb4\xee\xfay\xc7'\034\xf9\177(\x8f7E?\xba\xb0\x97Gj~tH\xe7\xd4SKt\x9f\006>hn.w\xb5=[`\xa9\xbe\xf9\xe5\xff\xd8w9+\xaa\037\x9d\xcf\xf2e\xa9Ys\xf3q\xcb\xeem\x86\031\x97\xeb\xd8\xd5&=W\xf7\177t\xe1\030\x9b\xec\xbd\xc0\xfb!\xfb\x85\xbcV\xbe}*\xf58\xe0R\xfd\xd5\033\034ۙ`\xe1s\xfe\xffڳ\xd2G\177\xef\xadi8\xf4~\x9e\xa7\xd5\027\006\006\026\x90\034#\003\v\003'(P\xf3\022sS\x8bA"
#> [4] "!\xa1"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
#> [5] "\026d\xca,\x83\xb2؋S\x8b\x8b3\xf3\xf3\xa0\\\x96\x94ĒD \xfd\017"                                                                                                                                                                                                                                                                                                                                                                                                                                                       
close(con)

## Unlocking Files -----

temp_file_locked |>
  unlock_file(
    private_key = file.path(temp_dir, "id_rsa")
  )
#> ℹ Unlocked file written at /tmp/RtmpEFRbN0/dir1ada3591d95f/file1ada49d462ad.

list.files(temp_dir)
#> [1] "file1ada49d462ad" "id_rsa"           "id_rsa.pub"      
con <- file(temp_file, "r+")
readLines(con)
#> [1] "Test"
close(con)
```
