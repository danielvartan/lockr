test_that("encrypt_file() | general test", {
    expect_error(encrypt_file())
})

test_that("decrypt_file() | general test", {
    expect_error(decrypt_file())
})

test_that("file.remove_() | general test", {
    expect_error(file.remove_())
})

test_that("file.exists_() | general test", {
    expect_error(file.exists_())
})

test_that("is_interactive() | general test", {
    expect_equal(is_interactive(), interactive())
})

test_that("list.files_() | general test", {
    checkmate::expect_character(list.files_())
})

test_that("load_all() | general test", {
    expect_error(load_all(1))
})
