staticrypt_command <- function() {
  if (Sys.which("npm") == "") {
    `attributes<-`(
      "",
      list(
        "npm_missing" = TRUE,
        "staticrypt_missing" = TRUE
      )
    )
  } else {
    test_local <-
      "npm" |>
      system2(
        args = c("list", "--depth=0"),
        stdout = TRUE,
        stderr = TRUE
      ) |>
      stringr::str_subset("staticrypt@") |>
      length()

    test_global <-
      "npm" |>
      system2(
        args = c("list", "--global", "--depth=0"),
        stdout = TRUE,
        stderr = TRUE
      ) |>
      stringr::str_subset("staticrypt@") |>
      length()

    if (test_local == 0 && test_global == 0) {
      `attributes<-`(
        "",
        list(
          "npm_missing" = FALSE,
          "staticrypt_missing" = TRUE
        )
      )
    } else {
      if (test_local > 0) {
        "npx staticrypt"
      } else {
        "staticrypt"
      }
    }
  }
}
