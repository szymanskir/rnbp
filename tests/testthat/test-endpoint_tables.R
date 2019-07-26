context("Checking if tables endpoint related functions are working correctly")

test_that("Base url is defined properly", {
  base_url <- .tables_base_url()

  expect_equal(base_url, "http://api.nbp.pl/api/exchangerates/tables/")
})


with_mock_api({
  with_mock(`curl::has_internet` = function() TRUE, {
    test_that("Current exchange rate tables are fetched correctly", {
      nbp_api_response <- get_current_exchangerate_table("a")

      expected_rates <- list(data.frame(
        currency = c("bat (Tajlandia)", "dolar australijski"),
        code = c("THB", "AUD"),
        mid = c(0.1235, 2.6398),
        stringsAsFactors = FALSE
      ))

      expect_equal(class(nbp_api_response), "nbp_api_response")
      expect_equal(nbp_api_response$content$table, "A")
      expect_equal(nbp_api_response$content$no, "131/A/NBP/2019")
      expect_equal(nbp_api_response$content$effectiveDate, as.Date("2019-07-09"))
      expect_equal(nbp_api_response$content$rates, expected_rates)
    })

    test_that("Bad exchange rate tables requests are handled correctly", {
      expect_error(
        get_current_exchangerate_table("z"),
        regexp = "NBP API request failed \\[400\\]"
      )
    })

    test_that("Last n exchange rate tables are fetched correctly", {
      nbp_api_response <- get_last_n_exchangerate_tables("a", 2)

      expected_rates <- list(
        data.frame(
          currency = c("bat (Tajlandia)", "SDR (MFW)"),
          code = c("THB", "XDR"),
          mid = c(0.1231, 5.2257),
          stringsAsFactors = FALSE
        ),
        data.frame(
          currency = c("bat (Tajlandia)", "SDR (MFW)"),
          code = c("THB", "XDR"),
          mid = c(0.1235, 5.2509),
          stringsAsFactors = FALSE
        )
      )

      expect_equal(class(nbp_api_response), "nbp_api_response")
      expect_equal(nbp_api_response$content$table, c("A", "A"))
      expect_equal(nbp_api_response$content$no, c("130/A/NBP/2019", "131/A/NBP/2019"))
      expect_equal(nbp_api_response$content$effectiveDate, as.Date(c("2019-07-08", "2019-07-09")))
      expect_equal(nbp_api_response$content$rates, expected_rates)
    })

    test_that("Maximum data series size exceeded error is handled correctly", {
      expect_error(
        get_last_n_exchangerate_tables("a", 68),
        regexp = "NBP API request failed \\[400\\]"
      )
    })

    test_that("Today's exchange rate table is fetched correctly", {
      nbp_api_response <- get_todays_exchangerate_table("a")
      expected_rates <- list(
        data.frame(
          currency = c("bat (Tajlandia)", "SDR (MFW)"),
          code = c("THB", "XDR"),
          mid = c(0.1235, 5.2509),
          stringsAsFactors = FALSE
        )
      )

      expect_equal(class(nbp_api_response), "nbp_api_response")
      expect_equal(nbp_api_response$content$table, "A")
      expect_equal(nbp_api_response$content$no, "131/A/NBP/2019")
      expect_equal(nbp_api_response$content$effectiveDate, as.Date("2019-07-09"))
      expect_equal(nbp_api_response$content$rates, expected_rates)
    })

    test_that("Today's exchange rate table no data found error is handled properly", {
      # The only reason why table b is fetched is because we need a separate
      # file for httptest to contain an http response with the desired error
      expect_error(
        get_todays_exchangerate_table("b"),
        regexp = "NBP API request failed \\[404\\]"
      )
    })

    test_that("Exchange rate table from selected date is fetched correctly", {
      nbp_api_response <- get_exchangerate_table_from("a", as.Date("2019-07-03"))

      expected_rates <- list(
        data.frame(
          currency = c("bat (Tajlandia)", "SDR (MFW)"),
          code = c("THB", "XDR"),
          mid = c(0.1231, 5.2044),
          stringsAsFactors = FALSE
        )
      )

      expect_equal(class(nbp_api_response), "nbp_api_response")
      expect_equal(nbp_api_response$content$table, "A")
      expect_equal(nbp_api_response$content$no, "127/A/NBP/2019")
      expect_equal(nbp_api_response$content$effectiveDate, as.Date("2019-07-03"))
      expect_equal(nbp_api_response$content$rates, expected_rates)
    })

    test_that("Exchange rate tables from specified interval are fetched correctly", {
      nbp_api_response <- get_exchangerate_tables_from_interval("a", as.Date("2019-07-08"), as.Date("2019-07-09"))

      expected_rates <- list(
        data.frame(
          currency = c("bat (Tajlandia)", "SDR (MFW)"),
          code = c("THB", "XDR"),
          mid = c(0.1231, 5.2257),
          stringsAsFactors = FALSE
        ),
        data.frame(
          currency = c("bat (Tajlandia)", "SDR (MFW)"),
          code = c("THB", "XDR"),
          mid = c(0.1235, 5.2509),
          stringsAsFactors = FALSE
        )
      )

      expect_equal(class(nbp_api_response), "nbp_api_response")
      expect_equal(nbp_api_response$content$table, c("A", "A"))
      expect_equal(nbp_api_response$content$no, c("130/A/NBP/2019", "131/A/NBP/2019"))
      expect_equal(nbp_api_response$content$effectiveDate, as.Date(c("2019-07-08", "2019-07-09")))
      expect_equal(nbp_api_response$content$rates, expected_rates)
    })
  })
})
