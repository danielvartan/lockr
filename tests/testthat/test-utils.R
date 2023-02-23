test_that("devtools_load | general test", {
    mock <- function(.parent = parent.frame(), .env = topenv(.parent)) {
        mockr::with_mock(
            load_all = function(...) TRUE,
            {
                devtools_load(load = TRUE)
            }
        )
    }

    expect_null(mock())

    expect_null(devtools_load(load = FALSE))
})

test_that("devtools_load | assertion test", {
    # "checkmate::assert_flag(load)"
    expect_error(devtools_load(load = 1), "Assertion on 'load' failed")
})
