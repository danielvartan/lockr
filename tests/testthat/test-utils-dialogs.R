test_that("password_warning | general test", {
    # "if (!is_interactive())"
    mock <- function(.parent = parent.frame(), .env = topenv(.parent)) {
        mockr::with_mock(
            is_interactive = function(...) TRUE,
            menu = function(...) 1,
            {password_warning(abort = TRUE)}
        )
    }

    suppressMessages(suppressWarnings(expect_true(mock())))

    mock <- function(.parent = parent.frame(), .env = topenv(.parent)) {
        mockr::with_mock(
            is_interactive = function(...) TRUE,
            menu = function(...) 999,
            {password_warning(abort = FALSE)}
        )
    }

    suppressMessages(suppressWarnings(expect_error(mock())))
})

test_that("password_warning | assertion test", {
    # "checkmate::assert_flag(abort)"
    expect_error(password_warning(abort = 1), "Assertion on 'abort' failed")

    # "if (!is_interactive())"
    mock <- function(.parent = parent.frame(), .env = topenv(.parent)) {
        mockr::with_mock(
            is_interactive = function(...) FALSE,
            {password_warning(abort = FALSE)}
        )
    }

    expect_error(mock())
})
