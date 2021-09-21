package_version <- function(){
  pkgs_ver <- as.character(utils::packageVersion("gibber"))
  cat(
    crayon::green(cli::symbol$tick),
    "Version:",
    pkgs_ver
  )
}

.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
    package_version()
  )
}

