#' Predict presence of gibberish words in a sentence
#'
#' @param words character vector
#'
#' @return
#' @export
is_gibber <- function(words){

  # convert words to matrix
  matrix <- tokenize_words(words)

  # load tokenizer and model
  gibber_model <- system.file("extdata", "gibber_model.h5", package = "gibber", mustWork = TRUE)
  model <- keras::load_model_hdf5(gibber_model)

  # use prediction model
  out <- stats::predict(model, matrix)
  return(out[,1])
}
