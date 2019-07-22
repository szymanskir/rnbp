context("Checking if assert functions are working correctly.")

test_that("Character assertion is working correctly", {
  s <- "1234"
  expect_silent(assert_character(s))

  s <- 3
  expect_error(assert_character(s), regexp = "The s parameter should be a character.")
})


test_that("Date assertion is working correctly", {
  s <- "2019-07-11"
  expect_error(assert_date(s), regexp = "The s parameter should be a Date.")

  s <- as.Date(s)
  expect_silent(assert_date(s))
})


test_that("Count assertion is working correctly", {
  s <- "1234"
  expect_error(assert_count(s), regexp = "The s parameter should be a positive integer.")

  s <- 1234
  expect_silent(assert_count(s))
})


test_that("Interval assertion is working correctly", {
  from <- as.Date("2019-07-11")
  to <- as.Date("2019-07-13")
  expect_error(assert_interval(to, from),
               regexp = "The to, from parameters should define a correct interval.")

  expect_silent(assert_interval(from, to))
})
