#' Returns the base url for the rates endpoint.
#'
.rates_base_url <- function() {
    add_path_part(nbp_api_base_url(), "exchangerates/rates")
}

#' Sends a request and parses the rates endpoint response.
#'
#' @param request_url url to which the request should be sent.
#'
#' @return nbp_api_response object with the request content.
#'
.send_rates_endpoint_request <- function(request_url) {
    response <- send_get_request(url = request_url)
    parse_rates_endpoint_response(response)
}

#' Retrieves the current exchange rate for the given currency.
#'
#' @param table specifies which from which table the exchange
#' rate should be fetched.
#'
#' @param currency_code code of the currency for which the
#' exchange rate should be fetched.
#'
#' @return nbp_api_response object containing the current
#' exchange rate.
#'
#' @examples
#'
#' \donttest{
#' ## Retrieve the current exchange rate for euros
#' response <- get_current_exchangerate("A", "EUR")
#'
#' ## Retrieve the content
#' response$content
#'
#' }
#'
#' @seealso \url{https://api.nbp.pl/#kursyWalut}
#' @family rates
#' @export
#'
get_current_exchangerate <- function(table, currency_code) {
    assert_character(table)
    assert_character(currency_code)

    request_url <- create_request(base_url = .rates_base_url(),
                                  path_parts = c(table, currency_code))

    .send_rates_endpoint_request(request_url)
}

#' Retrieves the last n exchange rates.
#'
#' @param table specifies which from which table the exchange
#' rate should be fetched.
#'
#' @param currency_code code of the currency for which the
#' exchange rate should be fetched.
#'
#' @param n number of exchange rates to retrieve.
#'
#' @examples
#'
#' \donttest{
#' ## Fetch the last 3 exhange rates for euros
#' response <- get_last_n_exchangerates("A", "EUR", 3)
#'
#' ## Preview response content
#' response$content
#' }
#'
#' @return nbp_api_response object containing the last n
#' exchange rates.
#'
#' @seealso \url{https://api.nbp.pl/#kursyWalut}
#' @family rates
#' @export
#'
get_last_n_exchangerates <- function(table, currency_code, n) {
    assert_character(table)
    assert_character(currency_code)
    assert_count(n)

    request_url <- create_request(base_url = .rates_base_url(),
                                  path_parts = c(table, currency_code, "last", n))

    .send_rates_endpoint_request(request_url)
}

#' Retrieves the exchange rate that was published today.
#'
#' @details If today's data is not available the API will
#' return a 404 Not found error. In that case the function will
#' return an error with an appropriate message.
#'
#' @param table specifies which from which table the exchange
#' rate should be fetched.
#'
#' @param currency_code code of the currency for which the
#' exchange rate should be fetched.
#'
#' @examples
#'
#' \donttest{
#' ## Fetch todays A exchange rate table
#' response <- get_todays_exchangerate("A", "EUR")
#'
#' ## Preview response content
#' response$content
#' }
#'
#' @return nbp_api_response object containing today's exchange rate.
#'
#' @seealso \url{https://api.nbp.pl/#kursyWalut}
#' @family rates
#' @export
#'
get_todays_exchangerate <- function(table, currency_code) {
    assert_character(table)
    assert_character(currency_code)

    assert(is.character(table),
           "The table parameter should be a character.")
    assert(is.character(currency_code),
           "The currency_code parameter should be a character.")

    request_url <- create_request(base_url = .rates_base_url(),
                                  path_parts = c(table, currency_code, "today"))

    .send_rates_endpoint_request(request_url)
}

#' Retrieves the exchange rate from a specific date.
#'
#' @details As exchange rates are not published on the weekends
#' fetching values from a weekend date will result in a 404
#' error. In those cases the function returns an error with an
#' appropriate message.
#'
#' @param table specifies which from which table the exchange
#' rate should be fetched.
#'
#' @param currency_code code of the currency for which the
#' exchange rate should be fetched.
#'
#' @param date date from which the exchange rate should
#' be fetched.
#'
#' @examples
#'
#' \donttest{
#' ## Fetch the euro exchange rate from a week ago
#' response <- get_exchangerate_from("A", "EUR", Sys.Date() - 7)
#'
#' ## Preview response content
#' response$content
#' }
#'
#' @return nbp_api_response object containing the exchange rate
#' from the specified date.
#'
#' @seealso \url{https://api.nbp.pl/#kursyWalut}
#' @family rates
#' @export
#'
get_exchangerate_from <- function(table, currency_code, date) {
    assert_character(table)
    assert_character(currency_code)
    assert_date(date)

    request_url <- create_request(base_url = .rates_base_url(),
                                  path_parts = c(table, currency_code, as.character(date)))

    .send_rates_endpoint_request(request_url)
}

#' Retrieves the exchange rates from a specific interval.
#'
#' @details As exchange rates are not published on the weekends
#' fetching values from an interval containing a weekend will
#' result in a response that omits those days.
#'
#' @param table specifies which from which table the exchange
#' rate should be fetched.
#'
#' @param currency_code code of the currency for which the
#' exchange rate should be fetched.
#'
#' @param from start day of the interval.
#' @param to end day of the interval.
#'
#' @examples
#'
#' \donttest{
#' ## Fetch the exchange rate table from the past week
#' response <- get_exchangerate_tables_from_interval("A", Sys.Date() - 7, Sys.Date())
#'
#' ## Preview response content
#' response$content
#' }
#'
#' @return nbp_api_response object containing the exchange rates
#' from the specified interval.
#'
#' @seealso \url{https://api.nbp.pl/#kursyWalut}
#' @family rates
#' @export
#'
get_exchangerate_from_interval <- function(table, currency_code, from, to) {
    assert_character(table)
    assert_character(currency_code)
    assert_interval(from, to)

    request_url <- create_request(base_url = .rates_base_url(),
                                  path_parts = c(table,
                                                 currency_code,
                                                 as.character(from),
                                                 as.character(to)))

    .send_rates_endpoint_request(request_url)
}
