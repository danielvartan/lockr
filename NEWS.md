# lockr (development version)

- The package code was refactored to improve readability and maintainability.
- `save_and_lock()` was added. This function combines saving and locking data into a single step.

# lockr 0.3.0 (2023-03-20)

- `encryptrpak` was renamed to `lockr`.
- `encryptr` and `devtools`are no longer in the import dependence list.
- `encrypt_extdata()` and `decrypt_extdata()` were superseded and removed from the package.
- `get_private_key()`, `get_public_key()`, `get_private_key_path()`, and `get_public_key_path()` were removed from the package. Please use `openssl` for reading keys.
- `rsa_keygen()` was added. This function facilitates the creation of RSA key pairs.
- `lock_file()` and `unlock_file()` were added. These functions allow the user to encrypt or decrypt individual files.
- `lock_dir()` and `unlock_dir()` were added. These functions allow the user to encrypt or decrypt all files inside a directory.

# encryptrpak 0.2.0 (2021-11-11)

- `get_private_key_path()` and `get_public_key_path()` are now exported functions.
- An argument called `devtools_load` was added to `get_private_key()`, `get_public_key()`, `get_private_key_path()`, `get_public_key_path()`, `encrypt_extdata()`, and `decrypt_extdata()`. This allows developers to load packages to memory before running the functions. The `devtools_load` argument is always set to `FALSE`.

# encryptrpak 0.1.0 (2021-11-04)

- First `lockr` release. 🎉

# encryptrpak 0.0.0.9000

- Added a `NEWS.md` file to track changes to the package.
