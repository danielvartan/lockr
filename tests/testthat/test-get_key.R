test_that("get_private_key | general test", {
    mock <- function(.parent = parent.frame(), .env = topenv(.parent)) {
        mockr::with_mock(
            assert_private_key = function(...) TRUE,
            password_warning = function(...) TRUE,
            {get_private_key(package = "base", devtools_load = FALSE)}
        )
    }

    expect_error(mock())
})

test_that("get_private_key | assertion test", {
    # "checkmate::assert_string(package)"
    expect_error(get_private_key(package = 1, devtools_load = FALSE),
                 "Assertion on 'package' failed")

    # "checkmate::assert_flag(devtools_load)"
    expect_error(get_private_key(package = "base", devtools_load = 1),
                 "Assertion on 'devtools_load' failed")
})

test_that("get_public_key | general test", {
    mock <- function(.parent = parent.frame(), .env = topenv(.parent)) {
        mockr::with_mock(
            assert_public_key = function(...) TRUE,
            {get_public_key(package = "base", devtools_load = FALSE)}
        )
    }

    expect_error(mock())
})

test_that("get_public_key | assertion test", {
    # "checkmate::assert_string(package)"
    expect_error(get_public_key(package = 1, devtools_load = FALSE),
                 "Assertion on 'package' failed")

    # "checkmate::assert_flag(devtools_load)"
    expect_error(get_public_key(package = "base", devtools_load = 1),
                 "Assertion on 'devtools_load' failed")
})

test_that("get_private_key_path | general test", {
    mock <- function(.parent = parent.frame(), .env = topenv(.parent)) {
        mockr::with_mock(
            assert_private_key = function(...) TRUE,
            {get_private_key_path(package = "base", devtools_load = FALSE)}
        )
    }

    expect_equal(mock(), "/id_rsa")
})

test_that("get_private_key_path | assertion test", {
    # "checkmate::assert_string(package)"
    expect_error(get_private_key_path(package = 1, devtools_load = FALSE),
                 "Assertion on 'package' failed")

    # "checkmate::assert_flag(devtools_load)"
    expect_error(get_private_key_path(package = "base", devtools_load = 1),
                 "Assertion on 'devtools_load' failed")
})


test_that("get_public_key_path | general test", {
    mock <- function(.parent = parent.frame(), .env = topenv(.parent)) {
        mockr::with_mock(
            assert_public_key = function(...) TRUE,
            {get_public_key_path(package = "base", devtools_load = FALSE)}
        )
    }

    expect_equal(mock(), "/id_rsa.pub")
})

test_that("get_public_key_path | assertion test", {
    # "checkmate::assert_string(package)"
    expect_error(get_public_key_path(package = 1, devtools_load = FALSE),
                 "Assertion on 'package' failed")

    # "checkmate::assert_flag(devtools_load)"
    expect_error(get_public_key_path(package = "base", devtools_load = 1),
                 "Assertion on 'devtools_load' failed")
})
