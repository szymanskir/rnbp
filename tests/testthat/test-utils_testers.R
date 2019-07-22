context("Checking if testing functions are working correctly.")

test_that("Integer validation is working correctly", {
  expect_true(is_integer(4))
  expect_true(is_integer(0))
  expect_true(is_integer(-3))
  expect_false(is_integer(0.4))
  expect_false(is_integer(-3.4))
})


test_that("Positive integer validation is working correctly", {
  expect_true(is_count(4))
  expect_false(is_count(0))
  expect_false(is_count(-3))
  expect_false(is_count(0.3))
})


test_that("Date validation is working correctly", {
  expect_true(is_date(as.Date("2019-07-03")))
  expect_false(is_date("2019-07-03"))
})
