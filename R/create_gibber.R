#' A function for random word generation.
#'
#' Compute a word of length n consisting of randomly chosen
#' characters from the alphabet.
#'
#' @seealso \code{\link[gibber]{is_gibber}}
#' @references \url{https://github.com/Glender/gibber}
#' @author Glenn Hiemstra
#'
#' @param n a numeric vector giving the number of characters in each word.
#' @param prob a vector of probability weights for obtaining the elements of the vector being sampled.
#'
#' @return a character vector.
#' @export
#'
#' @examples
#' # generate a random word of length 5
#' create_gibber(n=5)
#' # generate three randoms word:
#' create_gibber(c(5, 7, 9))
create_gibber <- function(n, prob=NULL){
  nonsense_words <- sapply(n, function(x){
    paste(sample(letters, size = x, replace = TRUE, prob = prob), collapse = "")
  })
  return(nonsense_words)
}

