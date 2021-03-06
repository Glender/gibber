#' Detect presence of gibberish text in a sentence
#'
#' \code{is_gibber} returns the probability that text contains gibberish words.
#'
#' Assess the probability that a sentence contains gibberish words. For each word in a sentence, the model
#' inspects the sequence of vowels and consonents to estimate whether a sentence consists of natural words. Therefore,
#' words like 'asdfg' and 'dfrgfh' are considered unnatural and are classified as not being part of the English spoken language.
#'
#' A recurrent neural network was trained to recognize gibber in text. For this purpose, dataset was used that contains 700.000 English words (50% gibberish words/50% natural words).
#'Special care was taken to avoid overfitting and an accuracy of 97% was achieved on a validation dataset, thereby guaranteeing generalizable results.
#'
#' @seealso \code{\link[gibber]{create_gibber}}
#' @references \url{https://github.com/Glender/gibber}
#' @author Glenn Hiemstra
#'
#' @param text character vector. Sentences or words.
#' @param output either "prob" for probabilities, "class" for binary classifications or "bool" for TRUE/FALSE ("prob" by default).
#' @param trim_sentence integer. Specify how many characters a word in a sentence must have to be excluded from the prediction model (2 by default).
#' @return numeric vector, integer of logical
#' @export
#' @examples
#' # test text
#' text <- c("asdf", "This is great")
#' is_gibber(text)
is_gibber <- function(text, output="prob", trim_sentence=2){

  stopifnot(is.character(text))
  stopifnot(output=="prob"|output=="class"|output=="bool")
  stopifnot(trim_sentence%%1==0)

  # create list to store the result
  # for each word in a sentence the prob of gibber is calculated
  probs_word <- vector("list", length(text))
  splitted_sentence <- strsplit(text, split=" ")
  # remove words from a sentence that have fewer than x characters
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
  } else if(output == "bool"){
    scores <- as.logical(round(scores))
  }
  return(scores)
}
