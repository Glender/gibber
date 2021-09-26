# Any work that initializes a python object needs to happen at package load time, not package build time.
# Thus we do the following initialization step
model <- NULL
tokenizer <- NULL

.onLoad <- function(libname, pkgname) {
  path <- system.file("extdata", "gibber_model.h5", package = "gibber", mustWork = TRUE)
  model <<- keras::load_model_hdf5(path)

  # load tokenizer
  tokenizer_path <- system.file("extdata", "gibber_tokenizer", package = "gibber", mustWork = TRUE)
  tokenizer <<- keras::load_text_tokenizer(tokenizer_path)

}

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



