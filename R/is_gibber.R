#' Detect presence of gibberish text in a sentence
#'
#' A recurrent neural network is used to calculate the...
#'
#' @param sentence character vector. A sentence or words.
#' @param output either "prob" for probabilities, "class" for classifications or "bool" for TRUE/FALSE ("prob" by default).
#' @param trim_sentence integer. Specify how many characters a word in a sentence must have to be excluded from the prediction model (2 by default).
#' @return numeric vector
#' @export
#' @examples
#' sentence <- c("asdf", "This is great", "computer")
#' is_gibber(sentence)
is_gibber <- function(sentence, output = "prob", trim_sentence=2){

  stopifnot(is.character(sentence))
  stopifnot(output=="prob"|output=="class"|output=="bool")

  # create list to store the result
  # for each word in a sentence the prob of gibber is calculated
  probs_word <- vector("list", length(sentence))
  splitted_sentence <- strsplit(sentence, split=" ")
  # remove words from a sentence that have fewer than 3 characters
  words_per_sentence <- lapply(splitted_sentence, function(x) x[nchar(x)>trim_sentence])

  # loop over words in a sentence and
  # calculate the prob of gibber for each word in a sentence
  for(i in seq_along(words_per_sentence)){

    words <- words_per_sentence[[i]]
    if(length(words)>0){
      # convert words to matrix
      # see `R/pkg_startup.R` for details
      matrix <- tokenize_words(words)
      probs <- stats::predict(model, matrix)
      probs_word[[i]] <- probs[,1]
    } else {
      # words of length zero can't be predicted
      probs_word[[i]] <- NA
    }
  }
  # average probability of gibberish words in a sentence
  probs_sentence <- sapply(probs_word, mean)

  # reverse scores; gibber answers yields higher probs
  scores <- (1 - probs_sentence)

  # convert to desired output
  if(output == "class"){
    scores <- round(scores)
  } else if(output=="bool"){
    scores <- as.logical(round(scores))
  }
  return(scores)
}
