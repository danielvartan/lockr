# Changelog

## lockr (development version)

- The package code was refactored to improve readability and
  maintainability.
- [`save_and_lock()`](https://danielvartan.github.io/lockr/reference/save_and_lock.md)
  was added. This function combines saving and locking data into a
  single step.
- [`staticrypt()`](https://danielvartan.github.io/lockr/reference/staticrypt.md)
  was added. This function creates an interface with the
  [Staticrypt](https://github.com/robinmoisson/staticrypt) tool for
  encrypting HTML files.

## lockr 0.3.0 (2023-03-20)

- `encryptrpak` was renamed to `lockr`.
- `encryptr` and `devtools`are no longer in the import dependence list.
- `encrypt_extdata()` and `decrypt_extdata()` were superseded and
  removed from the package.
- `get_private_key()`, `get_public_key()`, `get_private_key_path()`, and
  `get_public_key_path()` were removed from the package. Please use
  `openssl` for reading keys.
- [`rsa_keygen()`](https://danielvartan.github.io/lockr/reference/rsa_keygen.md)
  was added. This function facilitates the creation of RSA key pairs.
- [`lock_file()`](https://danielvartan.github.io/lockr/reference/lock_file.md)
  and
  [`unlock_file()`](https://danielvartan.github.io/lockr/reference/lock_file.md)
  were added. These functions allow the user to encrypt or decrypt
  individual files.
- [`lock_dir()`](https://danielvartan.github.io/lockr/reference/lock_dir.md)
  and
  [`unlock_dir()`](https://danielvartan.github.io/lockr/reference/lock_dir.md)
  were added. These functions allow the user to encrypt or decrypt all
  files inside a directory.
