password_warning <- function(abort = FALSE) {
    checkmate::assert_flag(abort)

    if (!is_interactive()) {
        cli::cli_abort("This function can only be used in interactive mode.")
    }

    cli::cat_line()
    cli::cli_alert_warning(paste0(
        "A dialog window will ask for the ",
        "{.strong {cli::col_red('private key password')}}. ",
        "Please have the password at hand or copy it to the clipboard."
    ))
    cli::cat_line()

    cli::cli_alert_warning(paste0(
        "If you're decrypting several files at once, you will need to ",
        "inform the password several times (for each file)."
    ))
    cli::cat_line()

    password <- menu(c("Yes", "No"),
                     title = "Do you have the password at hand?")

    if (password == 1 || abort == TRUE) {
        TRUE
    } else {
        cli::cli_abort("No password was provided.")
    }
}
