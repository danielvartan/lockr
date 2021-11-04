test_that("get_private_key | general test", {
    mock <- function(.parent = parent.frame(), .env = topenv(.parent)) {
        mockr::with_mock(
            assert_private_key = function(...) TRUE,
            get_private_key(package = "base")
        )
    }

    expect_error(mock())

    # "checkmate::assert_string(package)"
    expect_error(get_private_key(package = 1), "Assertion on 'package' failed")
})

test_that("get_public_key | general test", {
    mock <- function(.parent = parent.frame(), .env = topenv(.parent)) {
        mockr::with_mock(
            assert_public_key = function(...) TRUE,
            get_public_key(package = "base")
        )
    }

    expect_error(mock())

    # "checkmate::assert_string(package)"
    expect_error(get_public_key(package = 1), "Assertion on 'package' failed")
})

test_that("get_private_key_path | general test", {
    expect_equal(get_private_key_path("base"), "/id_rsa")
})


test_that("get_public_key_path | general test", {
    expect_equal(get_public_key_path("base"), "/id_rsa.pub")
})
