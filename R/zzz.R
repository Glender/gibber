.onLoad <- function(libname, pkgname) {
  invisible(suppressPackageStartupMessages(
    sapply(c("keras"),
           requireNamespace, quietly = TRUE)
  ))
}
