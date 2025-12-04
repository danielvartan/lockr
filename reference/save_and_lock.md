# Save and lock a file

`save_and_lock()` saves a data frame or R object to a file and then
locks it using [RSA](https://en.wikipedia.org/wiki/RSA_cryptosystem)
encryption.

## Usage

``` r
save_and_lock(
  x,
  file,
  type = "rds",
  public_key = here::here("_ssh", "id_rsa.pub"),
  ...
)
```

## Arguments

- x:

  An R object to be saved and locked. If `type = "csv"`, `x` must be a
  [`data.frame`](https://rdrr.io/r/base/data.frame.html).

- file:

  A [`character`](https://rdrr.io/r/base/character.html) string
  indicating the file path to save the object to.

- type:

  A [`character`](https://rdrr.io/r/base/character.html) string
  indicating the file type to save the object as. Must be one of `"csv"`
  or `"rds"` (default: `"rds"`).

- public_key:

  (optional) An
  [`openssl`](https://jeroen.r-universe.dev/openssl/reference/keygen.html)
  RSA public key or a
  [`character`](https://rdrr.io/r/base/character.html) string specifying
  the public key path. See
  [`rsa_keygen()`](https://danielvartan.github.io/lockr/reference/rsa_keygen.md)
  to learn how to create an RSA key pair (default:
  `here::here("_ssh", "id_rsa.pub")`).

- ...:

  (optional) Additional arguments passed to
  [`write_csv`](https://readr.tidyverse.org/reference/write_delim.html)
  or [`write_rds`](https://readr.tidyverse.org/reference/read_rds.html).

## Value

An [invisible](https://rdrr.io/r/base/invisible.html) string containing
the locked file path.

## See also

Other lock/unlock functions:
[`lock_dir()`](https://danielvartan.github.io/lockr/reference/lock_dir.md),
[`lock_file()`](https://danielvartan.github.io/lockr/reference/lock_file.md)

## Examples

``` r
## Creating Keys and Test Object -----

temp_dir <- tempfile("dir")
dir.create(temp_dir)

rsa_keygen(temp_dir)
#> ℹ Keys successfully created at /tmp/RtmpEFRbN0/dir1ada26669e6a.

x <- letters

## Locking and Saving Objects -----

x |>
  save_and_lock(
    file = tempfile(),
    type = "rds",
    public_key = file.path(temp_dir, "id_rsa.pub")
  )
#> ℹ Locked file written at /tmp/RtmpEFRbN0/file1ada15a8e6fd.lockr.
#> [1] "/tmp/RtmpEFRbN0/file1ada15a8e6fd.lockr"
```
