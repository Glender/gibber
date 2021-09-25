# Any work that initializes a python object needs to happen at package load time, not package build time.
# Thus we do the following initialization step
model <- NULL
.onLoad <- function(libname, pkgname) {
  path <- system.file("extdata", "gibber_model.h5", package = "gibber", mustWork = TRUE)
  model <<- keras::load_model_hdf5(path)
}

#' Predict presence of gibberish words
#'
#' Blabla..
#'
#' @param words character vector
#'
#' @return
#' @export
#' @examples
#' words <- c("asdf", "elephant")
#' is_gibber(words)
is_gibber <- function(words){

  # convert words to matrix
  matrix <- tokenize_words(words)

  # use prediction model
  probs <- stats::predict(model, matrix)
  return(probs[,1])
}
