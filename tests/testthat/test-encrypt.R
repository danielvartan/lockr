test_that("encrypt_extdata | general test", {
    # "if (is.null(type) && is.null(file))"
    mock <- function(.parent = parent.frame(), .env = topenv(.parent)) {
        mockr::with_mock(
            assert_public_key = function(...) TRUE,
            list.files_ = function(...) "",
            encrypt_file = function(...) TRUE,
            file.remove_ = function(...) TRUE,
            {
                encrypt_extdata(
                    type = NULL, file = NULL, remove_file = TRUE,
                    package = "base", devtools_load = FALSE
                    )
            }
        )
    }

    expect_null(mock())

    # "else if (!is.null(type) && is.null(file))"
    mock <- function(.parent = parent.frame(), .env = topenv(.parent)) {
        mockr::with_mock(
            assert_public_key = function(...) TRUE,
            list.files_ = function(...) "",
            encrypt_file = function(...) TRUE,
            file.remove_ = function(...) TRUE,
            {
                encrypt_extdata(
                    type = "", file = NULL, remove_file = TRUE,
                    package = "base", devtools_load = FALSE
                    )
                }
        )
    }

    expect_null(mock())

    # "if (!(i %in% list.files_(file.path(root, type))))"
    mock <- function(.parent = parent.frame(), .env = topenv(.parent)) {
        mockr::with_mock(
            assert_public_key = function(...) TRUE,
            list.files_ = function(...) "",
            encrypt_file = function(...) TRUE,
            file.remove_ = function(...) TRUE,
            {
                encrypt_extdata(
                    type = "", file = "a", remove_file = TRUE,
                    package = "base", devtools_load = FALSE
                    )
            }
        )
    }

    expect_error(mock())

    # "if (!grepl("\\.encryptr\\.bin$", i))"
    mock <- function(.parent = parent.frame(), .env = topenv(.parent)) {
        mockr::with_mock(
            assert_public_key = function(...) TRUE,
            list.files_ = function(...) "",
            encrypt_file = function(...) TRUE,
            file.remove_ = function(...) TRUE,
            {
                encrypt_extdata(
                    type = "", file = "", remove_file = TRUE,
                    package = "base", devtools_load = FALSE
                    )
            }
        )
    }

    expect_null(mock())

    # "else"
    mock <- function(.parent = parent.frame(), .env = topenv(.parent)) {
        mockr::with_mock(
            assert_public_key = function(...) TRUE,
            list.files_ = function(...) "",
            encrypt_file = function(...) TRUE,
            file.remove_ = function(...) TRUE,
            {
                encrypt_extdata(
                    type = NULL, file = "", remove_file = TRUE,
                    package = "base", devtools_load = FALSE
                    )
            }
        )
    }

    expect_error(mock())
})

test_that("encrypt_extdata | assertion test", {
    # "checkmate::assert_string(package)"
    expect_error(encrypt_extdata(type = NULL, file = NULL, remove_file = TRUE,
                                 package = 1, devtools_load = FALSE),
                 "Assertion on 'package' failed")

    # "checkmate::assert_character(file, min.len = 1, null.ok = TRUE)"
    expect_error(encrypt_extdata(type = NULL, file = 1, remove_file = TRUE,
                                 package = "base", devtools_load = FALSE),
                 "Assertion on 'file' failed")

    # "checkmate::assert_flag(remove_file))"
    expect_error(encrypt_extdata(type = NULL, file = NULL, remove_file = 1,
                                 package = "base", devtools_load = FALSE),
                 "Assertion on 'remove_file' failed")

    # "checkmate::assert_flag(devtools_load)"
    expect_error(encrypt_extdata(type = NULL, file = NULL, remove_file = TRUE,
                                 package = "base", devtools_load = 1),
                 "Assertion on 'devtools_load' failed")

    # "assert_public_key()"
    expect_error(encrypt_extdata(type = NULL, file = NULL, remove_file = TRUE,
                                 package = "base", devtools_load = FALSE))

    # "checkmate::assert_choice(type, list.files_(root), null.ok = TRUE)"
    mock <- function(.parent = parent.frame(), .env = topenv(.parent)) {
        mockr::with_mock(
            assert_public_key = function(...) TRUE,
            list.files_ = function(...) "",
            encrypt_file = function(...) TRUE,
            file.remove_ = function(...) TRUE,
            {
                encrypt_extdata(
                    type = "a", file = NULL, remove_file = TRUE,
                    package = "base", devtools_load = FALSE
                    )
            }
        )
    }

    expect_error(mock())
})

test_that("decrypt_extdata | general test", {
    # "if (!is_interactive())" & "if (is.null(type) && is.null(file))"
    mock <- function(.parent = parent.frame(), .env = topenv(.parent)) {
        mockr::with_mock(
            assert_private_key = function(...) TRUE,
            list.files_ = function(...) "a.encryptr.bin",
            is_interactive = function(...) TRUE,
            password_warning = function(...) TRUE,
            decrypt_file = function(...) TRUE,
            file.remove_ = function(...) TRUE,
            {
                decrypt_extdata(
                    type = NULL, file = NULL, remove_file = TRUE,
                    package = "base", devtools_load = FALSE
                    )
            }
        )
    }

    expect_null(mock())

    # "else if (!is.null(type) && is.null(file))"
    mock <- function(.parent = parent.frame(), .env = topenv(.parent)) {
        mockr::with_mock(
            assert_private_key = function(...) TRUE,
            list.files_ = function(...) "a.encryptr.bin",
            is_interactive = function(...) TRUE,
            password_warning = function(...) TRUE,
            decrypt_file = function(...) TRUE,
            file.remove_ = function(...) TRUE,
            {
                decrypt_extdata(
                    type = "a.encryptr.bin", file = NULL, remove_file = TRUE,
                    package = "base", devtools_load = FALSE
                    )
            }
        )
    }

    expect_null(mock())

    # "if (!(i %in% list.files_(file.path(root, type))))"
    mock <- function(.parent = parent.frame(), .env = topenv(.parent)) {
        mockr::with_mock(
            assert_private_key = function(...) TRUE,
            list.files_ = function(...) "",
            is_interactive = function(...) TRUE,
            password_warning = function(...) TRUE,
            decrypt_file = function(...) TRUE,
            file.remove_ = function(...) TRUE,
            {
                decrypt_extdata(
                    type = "", file = "a", remove_file = TRUE, package = "base",
                    devtools_load = FALSE
                    )
            }
        )
    }

    expect_error(mock())

    # "if (!grepl("\\.encryptr\\.bin$", i))"
    mock <- function(.parent = parent.frame(), .env = topenv(.parent)) {
        mockr::with_mock(
            assert_private_key = function(...) TRUE,
            list.files_ = function(...) "a.encryptr.bin",
            is_interactive = function(...) TRUE,
            password_warning = function(...) TRUE,
            decrypt_file = function(...) TRUE,
            file.remove_ = function(...) TRUE,
            {
                decrypt_extdata(
                    type = "a.encryptr.bin", file = "a.encryptr.bin",
                    remove_file = TRUE, package = "base",
                    devtools_load = FALSE
                    )
            }
        )
    }

    expect_null(mock())

    # "else"
    mock <- function(.parent = parent.frame(), .env = topenv(.parent)) {
        mockr::with_mock(
            assert_private_key = function(...) TRUE,
            list.files_ = function(...) "",
            is_interactive = function(...) TRUE,
            password_warning = function(...) TRUE,
            decrypt_file = function(...) TRUE,
            file.remove_ = function(...) TRUE,
            {
                decrypt_extdata(
                    type = NULL, file = "", remove_file = TRUE,
                    package = "base", devtools_load = FALSE
                    )
            }
        )
    }

    expect_error(mock())
})

test_that("decrypt_extdata | assertion test", {
    # "checkmate::assert_string(package)"
    expect_error(decrypt_extdata(type = NULL, file = NULL, remove_file = TRUE,
                                 package = 1, devtools_load = FALSE),
                 "Assertion on 'package' failed")

    # "checkmate::assert_character(file, min.len = 1, null.ok = TRUE)"
    expect_error(decrypt_extdata(type = NULL, file = 1, remove_file = TRUE,
                                 package = "base", devtools_load = FALSE),
                 "Assertion on 'file' failed")

    # "checkmate::assert_flag(remove_file))"
    expect_error(decrypt_extdata(type = NULL, file = NULL, remove_file = 1,
                                 package = "base", devtools_load = FALSE),
                 "Assertion on 'remove_file' failed")

    # "checkmate::assert_flag(devtools_load)"
    expect_error(decrypt_extdata(type = NULL, file = NULL, remove_file = TRUE,
                                 package = "base", devtools_load = 1),
                 "Assertion on 'devtools_load' failed")

    # "assert_private_key()"
    expect_error(decrypt_extdata(type = NULL, file = NULL, remove_file = TRUE,
                                 package = "base", devtools_load = FALSE))

    # "checkmate::assert_choice(type, list.files_(root), null.ok = TRUE)"
    mock <- function(.parent = parent.frame(), .env = topenv(.parent)) {
        mockr::with_mock(
            assert_private_key = function(...) TRUE,
            list.files_ = function(...) "",
            is_interactive = function(...) TRUE,
            decrypt_file = function(...) TRUE,
            file.remove_ = function(...) TRUE,
            {
                decrypt_extdata(
                    type = "a", file = NULL, remove_file = TRUE,
                    package = "base", devtools_load = FALSE
                    )
            }
        )
    }

    expect_error(mock())

    # "if (!is_interactive())"
    mock <- function(.parent = parent.frame(), .env = topenv(.parent)) {
        mockr::with_mock(
            assert_private_key = function(...) TRUE,
            list.files_ = function(...) "",
            is_interactive = function(...) FALSE,
            decrypt_file = function(...) TRUE,
            file.remove_ = function(...) TRUE,
            {
                decrypt_extdata(
                    type = NULL, file = NULL, remove_file = TRUE,
                    package = "base", devtools_load = FALSE
                    )
            }
        )
    }

    expect_error(mock())
})
