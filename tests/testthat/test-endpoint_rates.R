context("Checking if rates endpoint related functions are working correctly")

test_that("Base url is defined properly", {
  base_url <- .rates_base_url()

  expect_equal(base_url, "https://api.nbp.pl/api/exchangerates/rates/")
})


with_mock_api({
  with_mock(`curl::has_internet` = function() TRUE, {
    test_that("Current exchange rate is fetched correctly", {
      nbp_api_response <- get_current_exchangerate("a", "EUR")

      expected_rates <- data.frame(
        no = "139/A/NBP/2019",
        effectiveDate = as.Date("2019-07-19"),
        mid = 4.2592,
        stringsAsFactors = FALSE
      )

      expect_equal(class(nbp_api_response), "nbp_api_response")
      expect_equal(nbp_api_response$content$table, "A")
      expect_equal(nbp_api_response$content$currency, "euro")
      expect_equal(nbp_api_response$content$code, "EUR")
      expect_equal(nbp_api_response$content$rates, expected_rates)
    })


    test_that("Lastn n exchange rates are fetched correctly", {
      nbp_api_response <- get_last_n_exchangerates("a", "EUR", 2)

      expected_rates <- data.frame(
        no = c("138/A/NBP/2019", "139/A/NBP/2019"),
        effectiveDate = as.Date(c("2019-07-18", "2019-07-19")),
        mid = c(4.2635, 4.2592),
        stringsAsFactors = FALSE
      )

      expect_equal(class(nbp_api_response), "nbp_api_response")
      expect_equal(nbp_api_response$content$table, "A")
      expect_equal(nbp_api_response$content$currency, "euro")
      expect_equal(nbp_api_response$content$code, "EUR")
      expect_equal(nbp_api_response$content$rates, expected_rates)
    })

    test_that("Today's exchange rate is fetched correctly", {
      nbp_api_response <- get_todays_exchangerate("a", "EUR")

      expected_rates <- data.frame(
        no = "139/A/NBP/2019",
        effectiveDate = as.Date("2019-07-19"),
        mid = 4.2592,
        stringsAsFactors = FALSE
      )

      expect_equal(class(nbp_api_response), "nbp_api_response")
      expect_equal(nbp_api_response$content$table, "A")
      expect_equal(nbp_api_response$content$currency, "euro")
      expect_equal(nbp_api_response$content$code, "EUR")
      expect_equal(nbp_api_response$content$rates, expected_rates)
    })


    test_that("Today's exchange rate is fetched correctly", {
      nbp_api_response <- get_todays_exchangerate("a", "EUR")

      expected_rates <- data.frame(
        no = "139/A/NBP/2019",
        effectiveDate = as.Date("2019-07-19"),
        mid = 4.2592,
        stringsAsFactors = FALSE
      )

      expect_equal(class(nbp_api_response), "nbp_api_response")
      expect_equal(nbp_api_response$content$table, "A")
      expect_equal(nbp_api_response$content$currency, "euro")
      expect_equal(nbp_api_response$content$code, "EUR")
      expect_equal(nbp_api_response$content$rates, expected_rates)
    })

    test_that("Exchange rate from selected date is fetched correctly", {
      nbp_api_response <- get_exchangerate_from("a", "EUR", as.Date("2019-07-03"))

      expected_rates <- data.frame(
        no = "127/A/NBP/2019",
        effectiveDate = as.Date("2019-07-03"),
        mid = 4.2442,
        stringsAsFactors = FALSE
      )

      expect_equal(class(nbp_api_response), "nbp_api_response")
      expect_equal(nbp_api_response$content$table, "A")
      expect_equal(nbp_api_response$content$currency, "euro")
      expect_equal(nbp_api_response$content$code, "EUR")
      expect_equal(nbp_api_response$content$rates, expected_rates)
    })

    test_that("Exchange rates from specified interval are fetched correctly", {
      nbp_api_response <- get_exchangerate_from_interval("a", "EUR", as.Date("2019-07-11"), as.Date("2019-07-13"))

      expected_rates <- data.frame(
        no = c("133/A/NBP/2019", "134/A/NBP/2019"),
        effectiveDate = as.Date(c("2019-07-11", "2019-07-12")),
        mid = c(4.2682, 4.2669),
        stringsAsFactors = FALSE
      )

      expect_equal(class(nbp_api_response), "nbp_api_response")
      expect_equal(nbp_api_response$content$table, "A")
      expect_equal(nbp_api_response$content$currency, "euro")
      expect_equal(nbp_api_response$content$code, "EUR")
      expect_equal(nbp_api_response$content$rates, expected_rates)
    })
  })
})
