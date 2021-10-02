
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gibber <img src="man/figures/logo.jpeg" align="right"  height="139" />

[![](https://img.shields.io/badge/devel%20version-1.0.1-purple.svg)](https://github.com/Glender/gibber)
[![R build
status](https://github.com/rossellhayes/ipa/workflows/R-CMD-check/badge.svg)](https://github.com/rossellhayes/ipa/actions)
[![](https://codecov.io/gh/rcannood/princurve/branch/master/graph/badge.svg)](https://codecov.io/gh/rcannood/princurve)
[![](https://img.shields.io/github/languages/code-size/Glender/gibber.svg)](https://github.com/Glender/gibber)

## Overview

When collecting qualitative survey data, not every respondent is
motivated to provide valid answers to survey questions. Respondents may
get bored answering repetitive questions or are driven to finish
questionnaires as soon as possible because of survey rewards. The gibber
packages tries to identify those respondents by examining their textual
answers on open questions. A deep leaerning algorithm is used for this
purpose and yields the probability that text is real. For example,
answers like ‘asdf’ and ‘dghfr’ are considered gibberish, while answers
like ‘computer’ and ‘trunk’ are classified as legit text.

## :writing\_hand: Author

Name: Glenn Hiemstra

Email: <Glenn.Hiemstra@gmail.com>

## :arrow\_double\_down: Installation

``` r
# Install the cutting edge development version from GitHub:
# install.packages("devtools")
devtools::install_github("Glender/gibber")
```

## :book: Usage

``` r
library(gibber)
#> ✓ Version: 1.0.1

# create vector with character data
text <- c(
 "Personally I'm always ready to learn, although I do not always like being taught.",
 "asdfg",
 "Computer",
 "dfhdfghd",
 "I love to walk.",
 "dhdshergeregfrvgergsgr"
)

# assess is text is legit, on default output gives a probability
is_gibber(text)
#> [1] 0.1476262401 0.9998687067 0.0005267262 0.9998653365 0.0767789781 0.9998563863

# change output to logical
is_gibber(text, output = "bool")
#> [1] FALSE  TRUE FALSE  TRUE FALSE  TRUE
```

## :floppy\_disk: Data

`is_gibber` assesses the probability that a sentence contains gibberish
words. For each word in a sentence, the model inspects the sequence of
vowels and consonents to estimate whether a sentence consists of natural
words. Therefore, words like ‘asdfg’ and ‘dfrgfh’ are considered
unnatural and are classified as gibber.

For this goal, a recurrent neural network was trained on a dataset that
contains 700.000 English words (50% gibberish words/50% natural words).
Special care was taken to avoid overfitting and an accuracy of 97% was
achieved on a validation dataset, thereby guaranteeing generalizable
results.

## :speech\_balloon: Help

The documentation of all functions can be accessed by `?<function-name>`
or navigate via the package documentation help page `?gibber` or
`help("gibber")`.

    # For example:
    ?is_gibber
    help("is_gibber")
