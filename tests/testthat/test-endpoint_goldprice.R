context("Checking if goldprice endpoint related functions are working correctly")


test_that("Base url is defined properly", {
  base_url <- .goldprice_base_url()

  expect_equal(base_url, "https://api.nbp.pl/api/cenyzlota/")
})


with_mock_api({
  with_mock(`curl::has_internet` = function() TRUE, {
    test_that("Current gold price is fetched correctly", {
      nbp_api_response <- get_current_goldprice()

      expect_equal(nbp_api_response$content$data, as.Date("2019-07-19"))
      expect_equal(nbp_api_response$content$cena, 172.86)
    })

    test_that("Last n gold prices are fetched correctly", {
      nbp_api_response <- get_last_n_goldprices(2)

      expect_equal(nbp_api_response$content$data, as.Date(c("2019-07-18", "2019-07-19")))
      expect_equal(nbp_api_response$content$cena, c(172.46, 172.86))
    })

    test_that("Today's gold price is fetched correctly", {
      nbp_api_response <- get_todays_goldprice()

      expect_equal(nbp_api_response$content$data, as.Date("2019-07-22"))
      expect_equal(nbp_api_response$content$cena, 175.23)
    })


    test_that("Gold price from specific date is fetched correctly", {
      nbp_api_response <- get_goldprice_from(date = as.Date("2019-07-12"))

      expect_equal(nbp_api_response$content$data, as.Date("2019-07-12"))
      expect_equal(nbp_api_response$content$cena, 172.07)
    })

    test_that("Gold prices from specific interval are fetched correctly", {
      nbp_api_response <- get_goldprice_from_interval(from = as.Date("2019-07-15"),
                                                      to = as.Date("2019-07-16"))

      expect_equal(nbp_api_response$content$data, as.Date(c("2019-07-15", "2019-07-16")))
      expect_equal(nbp_api_response$content$cena, c(171.49, 171.9))
    })
  })
})
