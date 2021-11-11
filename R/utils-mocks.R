## Used with the `mockr` package.

encrypt_file <- function(...) encryptr::encrypt_file(...)
decrypt_file <- function(...) encryptr::decrypt_file(...)
file.remove_ <- function(...) file.remove(...)
file.exists_ <- function(...) file.exists(...)
is_interactive <- function(...) interactive()
list.files_ <- function(...) list.files(...)
load_all <- function(...) devtools::load_all(...)
menu <- function(...) utils::menu(...)
