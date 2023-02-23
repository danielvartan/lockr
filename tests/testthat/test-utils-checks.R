test_that("test_private_key | general test", {
    expect_false(test_private_key(package = "base"))

    mock <- function(.parent = parent.frame(), .env = topenv(.parent)) {
        mockr::with_mock(
            file.exists_ = function(...) TRUE,
            {
                test_private_key(package = "base")
            }
        )
    }

    expect_true(mock())
})

test_that("test_private_key | assertion test", {
    # "checkmate::assert_string(package)"
    expect_error(test_private_key(package = 1),
                 "Assertion on 'package' failed")
})

test_that("assert_private_key | general test", {
    expect_error(assert_private_key(package = "base"))

    mock <- function(.parent = parent.frame(), .env = topenv(.parent)) {
        mockr::with_mock(
            test_private_key = function(...) TRUE,
            {
                assert_private_key(package = "base")
            }
        )
    }

    expect_null(mock())
})

test_that("assert_private_key | assertion test", {
    # "checkmate::assert_string(package)"
    expect_error(assert_private_key(package = 1),
                 "Assertion on 'package' failed")
})

test_that("test_public_key | general test", {
    expect_false(test_public_key(package = "base"))

    mock <- function(.parent = parent.frame(), .env = topenv(.parent)) {
        mockr::with_mock(
            file.exists_ = function(...) TRUE,
            {
                test_public_key(package = "base")
            }
        )
    }

    expect_true(mock())
})

test_that("test_public_key | assertion test", {
    # "checkmate::assert_string(package)"
    expect_error(test_public_key(package = 1),
                 "Assertion on 'package' failed")
})

test_that("assert_public_key | general test", {
    expect_error(assert_public_key(package = "base"))

    mock <- function(.parent = parent.frame(), .env = topenv(.parent)) {
        mockr::with_mock(
            test_public_key = function(...) TRUE,
            {
                assert_public_key(package = "base")
            }
        )
    }

    expect_null(mock())
})

test_that("assert_public_key | assertion test", {
    # "checkmate::assert_string(package)"
    expect_error(assert_public_key(package = 1),
                 "Assertion on 'package' failed")
})
