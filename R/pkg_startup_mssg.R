.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
    paste0(
      "Version: ", utils::packageVersion("gibber")
    )
  )
}
