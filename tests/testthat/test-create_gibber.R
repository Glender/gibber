test_that("Test output of is_gibber", {
  # test all output arguments
  expect_equal(
    is_gibber(c("computer", "asdfg"), output = "prob"), c(0.000526726245880127, 0.999868706683628)
  )
  expect_identical(
    is_gibber(c("laptop", "asdfg"), output = "class"), c(0,1)
  )
  expect_identical(
     is_gibber(c("telephone", "asdfg"), output = "bool"), c(FALSE,TRUE)
  )
})
