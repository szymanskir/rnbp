.rates_base_url <- function() {
    add_path_part(nbp_api_base_url(), "exchangerates/rates")
}

.send_rates_endpoint_request <- function(request_url) {
    response <- send_get_request(url = request_url)
    parse_rates_endpoint_response(response)
}

get_exchangerate <- function(table, currency_code) {
    assert_character(table)
    assert_character(currency_code)

    request_url <- create_request(base_url = .rates_base_url(),
                                  path_parts = c(table, currency_code))

    .send_rates_endpoint_request(request_url)
}

get_last_n_exchangerates <- function(table, currency_code, n) {
    assert_character(table)
    assert_character(currency_code)
    assert_count(n)

    request_url <- create_request(base_url = .rates_base_url(),
                                  path_parts = c(table, currency_code, "last", n))

    .send_rates_endpoint_request(request_url)
}

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

get_exchangerate_from <- function(table, currency_code, date) {
    assert_character(table)
    assert_character(currency_code)
    assert_date(date)

    request_url <- create_request(base_url = .rates_base_url(),
                                  path_parts = c(table, currency_code, as.character(date)))

    .send_rates_endpoint_request(request_url)
}

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
