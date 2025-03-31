test_that("lock_file() | general test", {
  temp_dir <- tempfile("dir")
  dir.create(temp_dir)
  temp_file <- tempfile(tmpdir = temp_dir)
  file.create(temp_file)
  rsa_keygen(temp_dir) %>% shush()
  public_key <- file.path(temp_dir, "id_rsa.pub")
  list.files(temp_dir)

  lock_file(
    file = temp_file, public_key = public_key,
    suffix = ".lockr", remove_file = TRUE
  ) %>%
    shush() %>%
    checkmate::expect_string()

  file.create(temp_file)
  lock_file(
    file = temp_file, public_key = public_key,
    suffix = ".lockr", remove_file = TRUE
  ) %>%
    expect_error()

  locked_temp_file <- paste0(temp_file, ".lockr")
  file.create(locked_temp_file)
  lock_file(
    file = locked_temp_file, public_key = public_key,
    suffix = ".lockr", remove_file = TRUE
  ) %>%
    expect_error()
})

test_that("lock_file() | assertion test", {
  # checkmate::assert_string(file)
  lock_file(
    file = 1, public_key = "", suffix = ".a", remove_file = TRUE
  ) %>%
    expect_error("Assertion on 'file' failed")

  # checkmate::assert_file_exists(file)
  lock_file(
    file = "", public_key = "", suffix = ".a", remove_file = TRUE
  ) %>%
    expect_error("Assertion on 'file' failed")

  # checkmate::assert_string(suffix, pattern = "^\\.")
  temp_file <- tempfile()
  file.create(temp_file)

  lock_file(
    file = temp_file, public_key = "", suffix = "a", remove_file = TRUE
  ) %>%
    expect_error("Assertion on 'suffix' failed")

  # checkmate::assert_flag(remove_file)
  lock_file(
    file = temp_file, public_key = "", suffix = ".a", remove_file = 1
  ) %>%
    expect_error("Assertion on 'remove_file' failed")

  # assert_public_key(public_key)
  lock_file(
    file = temp_file, public_key = "", suffix = ".a", remove_file = TRUE
  ) %>%
    expect_error("Assertion on 'public_key' failed")
})

test_that("unlock_file() | general test", {
  temp_dir <- tempfile("dir")
  dir.create(temp_dir)
  temp_file <- tempfile(tmpdir = temp_dir)
  file.create(temp_file)
  rsa_keygen(temp_dir) %>% shush()
  public_key <- file.path(temp_dir, "id_rsa.pub")
  private_key <- file.path(temp_dir, "id_rsa")

  lock_file(
    file = temp_file, public_key = public_key,
    suffix = ".lockr", remove_file = TRUE
  ) %>%
    shush() %>%
    checkmate::expect_string()

  list.files(temp_dir)

  locked_temp_file <- paste0(temp_file, ".lockr")
  unlock_file(
    file = locked_temp_file, private_key = private_key,
    suffix = ".lockr", remove_file = TRUE, password = NULL
  ) %>%
    shush() %>%
    checkmate::expect_string()

  file.create(locked_temp_file)
  unlock_file(
    file = locked_temp_file, private_key = private_key,
    suffix = ".lockr", remove_file = TRUE, password = NULL
  ) %>%
    expect_error()
})

test_that("unlock_file() | assertion test", {
  # checkmate::assert_string(suffix, pattern = "^\\.")
  temp_file <- tempfile()
  temp_file <- paste0(temp_file, ".a")
  file.create(temp_file)

  unlock_file(
    file = temp_file, private_key = "", suffix = "a", remove_file = TRUE,
    password = NULL
  ) %>%
    expect_error("Assertion on 'suffix' failed")

  # checkmate::assert_string(file)
  unlock_file(
    file = 1, private_key = "", suffix = ".a", remove_file = TRUE,
    password = NULL
  ) %>%
    expect_error("Assertion on 'file' failed")

  # checkmate::assert_file_exists(file)
  unlock_file(
    file = "", private_key = "", suffix = ".a", remove_file = TRUE,
    password = NULL
  ) %>%
    expect_error("Assertion on 'file' failed")

  # checkmate::assert_flag(remove_file)
  unlock_file(
    file = temp_file, private_key = "", suffix = ".a", remove_file = 1,
    password = NULL
  ) %>%
    expect_error("Assertion on 'remove_file' failed")

  # checkmate::assert_string(password, null.ok = TRUE)
  unlock_file(
    file = temp_file, private_key = "", suffix = ".a", remove_file = TRUE,
    password = 1
  ) %>%
    expect_error("Assertion on 'password' failed")

  # assert_private_key(private_key, password)
  unlock_file(
    file = temp_file, private_key = "", suffix = ".a", remove_file = TRUE,
    password = NULL
  ) %>%
    expect_error("Assertion on 'private_key' failed")
})
