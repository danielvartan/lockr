#' Encrypt or Decrypt HTML Files with StatiCrypt
#'
#' @description
#'
#' `staticrypt()` offers an interface to the
#' [StatiCrypt](https://github.com/robinmoisson/staticrypt) tool for encrypting
#' or decrypting HTML files using a password.
#'
#' @param file A [`character`][base::character] string indicating the path to
#'   the HTML file to be encrypted or decrypted.
#' @param password A [`character`][base::character] string specifying the
#'   password to use for encryption or decryption. For security, avoid
#'   hardcoding passwords in scripts. Use [`askpass()`][askpass::askpass()] to
#'   prompt for secure input.
#' @param config A [`character`][base::character] string specifying the path to
#'   the configuration file. If `NULL`, defaults to a `.staticrypt.json`
#'   file in the working directory (default: `NULL`).
#' @param directory A [`character`][base::character] string indicating the
#'   output directory for the encrypted or decrypted file (default: a subdirectory
#'   named `encrypted` in the same directory as `file`). Use `dirname(file)`
#'   to overwrite the file in place.
#' @param decrypt A [`logical`][base::logical] flag indicating whether to
#'   decrypt or encrypt the file (default: `FALSE`).
#' @param recursive A [`logical`][base::logical] flag indicating whether to
#'   process files in subdirectories recursively (default: `FALSE`).
#' @param remember A integer number specifying the number of days to remember
#'   the password (default: `0`, meaning do not remember). Use `FALSE` to hide
#'   the "Remember me" option in the generated HTML.
#' @param salt A [`character`][base::character] string specifying a
#'   32-character hexadecimal salt value for encryption. If `NULL`, a random
#'   salt will be generated (default: `NULL`).
#' @param share A [`character`][base::character] string specifying a path to
#'   share the password securely (default: `NULL`, meaning do not share).
#' @param share_remember A [`logical`][base::logical] flag indicating whether
#'   to remember the shared password (default: `FALSE`).
#' @param template A [`character`][base::character] string specifying the path
#'   to a custom HTML template file (default: `NULL`, meaning use the default
#'   template).
#' @param template_button A [`character`][base::character] string specifying the
#'   text for the submit button in the template (default: `"DECRYPT"`).
#' @param template_color_primary A [`character`][base::character] string
#'   specifying the template primary color in hexadecimal format
#'   (default: `"#4CAF50"`).
#' @param template_color_secondary A [`character`][base::character] string
#'   specifying the template secondary color in hexadecimal format
#'   (default: `"#76B852"`).
#' @param template_instructions A [`character`][base::character] string
#'   specifying instructions to display in the template (default: `""`).
#' @param template_error A [`character`][base::character] string specifying the
#'   error message to display for incorrect passwords
#'   (default: `"Bad password!"`).
#' @param template_placeholder A [`character`][base::character] string
#'   specifying the placeholder text for the password input field
#'   (default: `"Password"`).
#' @param template_remember A [`character`][base::character] string specifying
#'   the label for the "Remember me" checkbox in the template
#'   (default: `"Remember me"`).
#' @param template_title A [`character`][base::character] string specifying the
#'   title of the protected page in the template (default: `"Protected Page"`).
#' @param template_toggle_hide A [`character`][base::character] string
#'   specifying the text for the "Hide password" toggle in the template
#'   (default: `"Hide password"`).
#' @param template_toggle_show A [`character`][base::character] string
#'   specifying the text for the "Show password" toggle in the template
#'   (default: `"Show password"`).
#'
#' @return An [invisible][base::invisible()] `NULL`. These functions are called
#'   for side effects only.
#'
#' @family StatiCrypt functions
#' @export
#'
#' @examples
#' \dontrun{
#'   library(askpass)
#'
#'   staticrypt(
#'     file = "path/to/file.html",
#'     password = askpass()
#'   )
#' }
staticrypt <- function(
  file,
  password, #
  config = NULL,
  directory = file.path(dirname(file), "encrypted"), # file.path(dirname(file)
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
) {
  pattern_hex <- "^#[A-Fa-f0-9]{6}$"

  checkmate::assert_string(file)
  checkmate::assert_file_exists(file)
  checkmate::assert_multi_class(password, c("numeric", "character"))
  checkmate::assert_vector(password, len = 1)
  checkmate::assert_string(config, null.ok = TRUE)
  checkmate::assert_string(directory)
  checkmate::assert_flag(decrypt)
  checkmate::assert_flag(recursive)
  checkmate::assert_multi_class(remember, c("numeric", "logical"))
  checkmate::assert_string(share, null.ok = TRUE)
  checkmate::assert_flag(share_remember)
  checkmate::assert_string(template, null.ok = TRUE)
  checkmate::assert_string(template_button)
  checkmate::assert_string(template_color_primary, pattern = pattern_hex)
  checkmate::assert_string(template_color_secondary, pattern = pattern_hex)
  checkmate::assert_string(template_instructions)
  checkmate::assert_string(template_error)
  checkmate::assert_string(template_placeholder)
  checkmate::assert_string(template_remember)
  checkmate::assert_string(template_title)
  checkmate::assert_string(template_toggle_hide)
  checkmate::assert_string(template_toggle_show)

  checkmate::assert_string(
    salt,
    n.chars = 32,
    pattern = "^[A-Fa-f0-9]+$",
    null.ok = TRUE
  )

  if (is.numeric(remember)) {
    remember <- ceiling(remember)
  }

  if (!is.null(template)) {
    checkmate::assert_file_exists(template)
  }

  command <- staticrypt_command()

  assert_staticrypt()

  args <- c()

  options <-
    ls() |>
    stringr::str_subset(
      "command|file|pattern_hex",
      negate = TRUE
    )

  for (i in options) {
    value <- get(i)

    i <- stringr::str_replace_all(i, "_", "-")

    if (is.logical(value)) {
      args <- c(args, paste0("--", i, " ", tolower(value)))
    } else if (is.numeric(value)) {
      args <- c(args, paste0("--", i, " ", value))
    } else if (!is.null(value)) {
      args <- c(args, paste0("--", i, ' "', value, '"'))
    }
  }

  if (stringr::str_detect(command, "^npx")) {
    args <- c(
      "staticrypt",
      paste0('"', file, '"'),
      "--short",
      paste0(args, collapse = " ")
    )

    command <- "npx"
  } else {
    args <- c(
      paste0('"', file, '"'),
      "--short",
      paste0(args, collapse = " ")
    )
  }

  # return(paste(command, paste(args, collapse = " ")))

  system2_output <-
    command |>
    system2(
      args = args,
      stdout = TRUE,
      stderr = TRUE
    ) |>
    suppressMessages() |>
    suppressWarnings()

  status <-
    system2_output |>
    attributes() |>
    magrittr::extract2("status")

  if (!is.null(status)) {
    if (status == 124) {
      cli::cli_alert_warning(
        paste0(
          "Staticrypt timed out after ",
          "{.strong {cli::col_red(timeout)}} seconds."
        )
      )
    } else {
      cli::cli_abort(
        c(
          "Staticrypt produced the following error:",
          "",
          paste(system2_output)
        )
      )
    }
  }

  invisible()
}
