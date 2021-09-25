#' Predict presence of gibberish words in a sentence
#'
#' A recurrent neural network is used to calculate the probability of
#'
#' @param words character vector
#'
#' @return
#' @export
#' @examples
#' words <- c("asdf", "elephant")
#' is_gibber(words)
is_gibber <- function(words){

  # load tokenizer and model
  path <- system.file("extdata", "gibber_model.h5", package = "gibber", mustWork = TRUE)
  model <- keras::load_model_hdf5(path)

  # convert words to matrix
  matrix <- tokenize_words(words)

  # use prediction model
  probs <- stats::predict(model, matrix)
  return(probs[,1])
}
