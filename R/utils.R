devtools_load <- function(load = TRUE) {
    checkmate::assert_flag(load)

    if (isTRUE(load)) {
        load_all()

        return(devtools_load(FALSE))
    } else {
        invisible(NULL)
    }
}
