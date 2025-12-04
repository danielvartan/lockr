# Encrypt or Decrypt HTML Files with StatiCrypt

`staticrypt()` offers an interface to the
[StatiCrypt](https://github.com/robinmoisson/staticrypt) tool for
encrypting or decrypting HTML files using a password.

## Usage

``` r
staticrypt(
  file,
  password,
  config = NULL,
  directory = file.path(dirname(file), "encrypted"),
  decrypt = FALSE,
  recursive = FALSE,
  remember = 0,
  salt = NULL,
  share = NULL,
  share_remember = FALSE,
  template = NULL,
  template_button = "DECRYPT",
  template_color_primary = "#4CAF50",
  template_color_secondary = "#76B852",
  template_instructions = "",
  template_error = "Bad password!",
  template_placeholder = "Password",
  template_remember = "Remember me",
  template_title = "Protected Page",
  template_toggle_hide = "Hide password",
  template_toggle_show = "Show password"
)
```

## Arguments

- file:

  A [`character`](https://rdrr.io/r/base/character.html) string
  indicating the path to the HTML file to be encrypted or decrypted.

- password:

  A [`character`](https://rdrr.io/r/base/character.html) string
  specifying the password to use for encryption or decryption. For
  security, avoid hardcoding passwords in scripts. Use
  [`askpass()`](https://r-lib.r-universe.dev/askpass/reference/askpass.html)
  to prompt for secure input.

- config:

  A [`character`](https://rdrr.io/r/base/character.html) string
  specifying the path to the configuration file. If `NULL`, defaults to
  a `.staticrypt.json` in the same directory as `file` (default:
  `NULL`).

- directory:

  A [`character`](https://rdrr.io/r/base/character.html) string
  indicating the output directory for the encrypted or decrypted file
  (default: a subdirectory named `encrypted` in the same directory as
  `file`). Use `dirname(file)` to overwrite the file in place.

- decrypt:

  A [`logical`](https://rdrr.io/r/base/logical.html) flag indicating
  whether to decrypt or encrypt the file (default: `FALSE`).

- recursive:

  A [`logical`](https://rdrr.io/r/base/logical.html) flag indicating
  whether to process files in subdirectories recursively (default:
  `FALSE`).

- remember:

  A integer number specifying the number of days to remember the
  password (default: `0`, meaning do not remember). Use `FALSE` to hide
  the "Remember me" option in the generated HTML.

- salt:

  A [`character`](https://rdrr.io/r/base/character.html) string
  specifying a 32-character hexadecimal salt value for encryption. If
  `NULL`, a random salt will be generated (default: `NULL`).

- share:

  A [`character`](https://rdrr.io/r/base/character.html) string
  specifying a path to share the password securely (default: `NULL`,
  meaning do not share).

- share_remember:

  A [`logical`](https://rdrr.io/r/base/logical.html) flag indicating
  whether to remember the shared password (default: `FALSE`).

- template:

  A [`character`](https://rdrr.io/r/base/character.html) string
  specifying the path to a custom HTML template file (default: `NULL`,
  meaning use the default template).

- template_button:

  A [`character`](https://rdrr.io/r/base/character.html) string
  specifying the text for the submit button in the template (default:
  `"DECRYPT"`).

- template_color_primary:

  A [`character`](https://rdrr.io/r/base/character.html) string
  specifying the template primary color in hexadecimal format (default:
  `"#4CAF50"`).

- template_color_secondary:

  A [`character`](https://rdrr.io/r/base/character.html) string
  specifying the template secondary color in hexadecimal format
  (default: `"#76B852"`).

- template_instructions:

  A [`character`](https://rdrr.io/r/base/character.html) string
  specifying instructions to display in the template (default: `""`).

- template_error:

  A [`character`](https://rdrr.io/r/base/character.html) string
  specifying the error message to display for incorrect passwords
  (default: `"Bad password!"`).

- template_placeholder:

  A [`character`](https://rdrr.io/r/base/character.html) string
  specifying the placeholder text for the password input field (default:
  `"Password"`).

- template_remember:

  A [`character`](https://rdrr.io/r/base/character.html) string
  specifying the label for the "Remember me" checkbox in the template
  (default: `"Remember me"`).

- template_title:

  A [`character`](https://rdrr.io/r/base/character.html) string
  specifying the title of the protected page in the template (default:
  `"Protected Page"`).

- template_toggle_hide:

  A [`character`](https://rdrr.io/r/base/character.html) string
  specifying the text for the "Hide password" toggle in the template
  (default: `"Hide password"`).

- template_toggle_show:

  A [`character`](https://rdrr.io/r/base/character.html) string
  specifying the text for the "Show password" toggle in the template
  (default: `"Show password"`).

## Value

An [invisible](https://rdrr.io/r/base/invisible.html) `NULL`. These
functions are called for side effects only.

## Examples

``` r
if (FALSE) { # \dontrun{
  library(askpass)

  staticrypt(
    file = "path/to/file.html",
    password = askpass()
  )
} # }
```
