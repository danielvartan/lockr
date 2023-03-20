test_that("lock_dir() | general test", {
    ssh_dir <- tempfile("ssh")
    dir.create(ssh_dir)
    rsa_keygen(ssh_dir) %>% gutils:::shush()

    temp_dir <- tempfile("dir")
    dir.create(temp_dir)
    for (i in seq(3)) {
        file.create(tempfile(tmpdir = temp_dir))
    }
    list.files(temp_dir)

    lock_dir(temp_dir, public_key = file.path(ssh_dir, "id_rsa.pub")) %>%
        gutils:::shush() %>%
        expect_null()
})

test_that("lock_dir() | assertion test", {
    # checkmate::assert_string(dir)
    lock_dir(
        dir = 1, public_key = "", suffix = ".a", remove_file = TRUE
        ) %>%
        expect_error("Assertion on 'dir' failed")

    # checkmate::assert_directory_exists(dir)
    lock_dir(
        dir = "", public_key = "", suffix = ".a", remove_file = TRUE
        ) %>%
        expect_error("Assertion on 'dir' failed")

    # checkmate::assert_string(suffix, pattern = "^\\.")
    lock_dir(
        dir = tempdir(), public_key = "", suffix = "a", remove_file = TRUE
        ) %>%
        expect_error("Assertion on 'suffix' failed")

    # checkmate::assert_flag(remove_file)
    lock_dir(
        dir = tempdir(), public_key = "", suffix = ".a", remove_file = 1
    ) %>%
        expect_error("Assertion on 'remove_file' failed")

    # assert_public_key(public_key)
    lock_dir(
        dir = tempdir(), public_key = "", suffix = ".a", remove_file = TRUE
    ) %>%
        expect_error("Assertion on 'public_key' failed")
})

test_that("unlock_dir() | general test", {
    ssh_dir <- tempfile("ssh")
    dir.create(ssh_dir)
    rsa_keygen(ssh_dir) %>% gutils:::shush()

    temp_dir <- tempfile("dir")
    dir.create(temp_dir)
    for (i in seq(3)) {
        file.create(tempfile(tmpdir = temp_dir))
    }
    list.files(temp_dir)

    lock_dir(temp_dir, public_key = file.path(ssh_dir, "id_rsa.pub")) %>%
        gutils:::shush()

    unlock_dir(temp_dir, private_key = file.path(ssh_dir, "id_rsa")) %>%
        gutils:::shush() %>%
        expect_null()
})

test_that("unlock_dir() | assertion test", {
    # checkmate::assert_string(dir)
    unlock_dir(
        dir = 1, private_key = "", suffix = ".a", remove_file = TRUE,
        password = NULL
    ) %>%
        expect_error("Assertion on 'dir' failed")

    # checkmate::assert_directory_exists(dir)
    unlock_dir(
        dir = "", private_key = "", suffix = ".a", remove_file = TRUE,
        password = NULL
    ) %>%
        expect_error("Assertion on 'dir' failed")

    # checkmate::assert_string(suffix, pattern = "^\\.")
    unlock_dir(
        dir = tempdir(), private_key = "", suffix = "a", remove_file = TRUE,
        password = NULL
    ) %>%
        expect_error("Assertion on 'suffix' failed")

    # checkmate::assert_flag(remove_file)
    unlock_dir(
        dir = tempdir(), private_key = "", suffix = ".a", remove_file = 1,
        password = NULL
    ) %>%
        expect_error("Assertion on 'remove_file' failed")

    # checkmate::assert_string(password)
    unlock_dir(
        dir = tempdir(), private_key = "", suffix = ".a", remove_file = TRUE,
        password = 1
    ) %>%
        expect_error("Assertion on 'password' failed")

    # assert_private_key(private_key, password)
    unlock_dir(
        dir = tempdir(), private_key = "", suffix = ".a", remove_file = TRUE,
        password = NULL
    ) %>%
        expect_error("Assertion on 'private_key' failed")
})
