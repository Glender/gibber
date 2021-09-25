#' Tensorize words on the character level.
#'
#' All inputted words are transformed and put into a matrix with two dimensions.
#' Each row represents a word. Each column refers to a positional letter from the encyphered word,
#' where the last column maps to the first letter of the word and the second last column to the second letter of the words, etc.
#' Each cell refers to a letter from the alphabet. For example, a cell with the number one refers to the letter 'e'.
#'
#' A word can't surpass the length of 31 characters and only letters from the alphabet are contained, others characters like numbers and aren't encyphered.
#'
#' @param words a character vector.
#'
#' @return a matrix.
#' @export
#' @examples
#' words <- c("telephone", "laptop")
#' tokenize_words(words)
tokenize_words <- function(words){
  # load tokenizer
  gibber_tokenizer <- system.file("extdata", "gibber_tokenizer", package = "gibber", mustWork = TRUE)
  tokenizer <- keras::load_text_tokenizer(gibber_tokenizer)
  # function maps words to matrices
  sequences <- keras::texts_to_sequences(tokenizer, words)
  # words cannot surpass length of 31 characters
  matrix <- keras::pad_sequences(sequences, maxlen = 31)
  return(matrix)
}
