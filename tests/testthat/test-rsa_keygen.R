test_that("rsa_keygen() | general test", {
  temp_dir <- tempfile("dir")
  dir.create(temp_dir)

  rsa_keygen(
    dir = temp_dir,
    password = "test",
    bits = 2048
  ) |>
    suppressMessages() |>
    suppressWarnings()

  file.path(temp_dir, "id_rsa") %>%
    checkmate::expect_file_exists()
})

test_that("rsa_keygen() | assertion test", {
  # checkmate::assert_string(dir, null.ok = FALSE)
  rsa_keygen(dir = 1, password = NULL, bits = 2048) %>%
    expect_error("Assertion on 'dir' failed")

  # checkmate::assert_directory_exists(dir)
  rsa_keygen(dir = "", password = NULL, bits = 2048) %>%
    expect_error("Assertion on 'dir' failed")

  # checkmate::assert_string(password, null.ok = TRUE)
  rsa_keygen(dir = tempdir(), password = 1, bits = 2048) %>%
    expect_error("Assertion on 'password' failed")

  # checkmate::assert_integerish(bits)
  rsa_keygen(dir = tempdir(), password = NULL, bits = 1.1) %>%
    expect_error("Assertion on 'bits' failed")
})
