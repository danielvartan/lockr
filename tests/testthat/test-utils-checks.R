test_that("test_public_key() | general test", {
    openssl::rsa_keygen()$pubkey %>%
        test_public_key() %>%
        expect_true()

    openssl::rsa_keygen() %>%
        test_public_key() %>%
        expect_false()

    temp_dir <- tempdir()
    rutils:::shush(rsa_keygen(temp_dir))
    file.path(temp_dir, "id_rsa.pub") %>%
        test_public_key() %>%
        expect_true()

    temp_file <- tempfile()
    file.create(temp_file)
    temp_file %>%
        test_public_key() %>%
        expect_false()
})

test_that("test_public_key() | assertion test", {
    # checkmate::assert_file_exists(public_key)
    test_public_key(public_key = 1) %>%
        expect_error("Assertion on 'public_key' failed")
})

test_that("assert_public_key() | general test", {
    openssl::rsa_keygen() %>%
        assert_public_key() %>%
        expect_error()
})

test_that("test_private_key() | general test", {
    openssl::rsa_keygen() %>%
        test_private_key() %>%
        expect_true()

    openssl::rsa_keygen()$pubkey %>%
        test_private_key() %>%
        expect_false()

    temp_dir <- tempdir()
    rutils:::shush(rsa_keygen(temp_dir, password = "test"))
    file.path(temp_dir, "id_rsa") %>%
        test_private_key(password = "test") %>%
        expect_true()

    file.path(temp_dir, "id_rsa.pub") %>%
        test_private_key() %>%
        expect_false()
})

test_that("test_private_key() | assertion test", {
    # checkmate::assert_string(password)
    test_private_key(private_key = "a", password = 1) %>%
        expect_error("Assertion on 'password' failed")

    # checkmate::assert_file_exists(private_key)
    test_private_key(private_key = 1) %>%
        expect_error("Assertion on 'private_key' failed")
})

test_that("assert_private_key() | general test", {
    openssl::rsa_keygen()$pubkey %>%
        assert_private_key() %>%
        expect_error()
})
