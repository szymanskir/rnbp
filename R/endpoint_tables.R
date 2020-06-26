#' Returns the base url for the tables endpoint.
#'
.tables_base_url <- function() {
    add_path_part(nbp_api_base_url(), "exchangerates/tables")
}

#' Sends a request and parses the tables endpoint response.
#'
#' @param request_url url to which the request should be sent.
#'
#' @return nbp_api_response object with the request content.
#'
.send_tables_endpoint_request <- function(request_url) {
    response <- send_get_request(url = request_url)
    parse_tables_endpoint_response(response)
}

#' Retrieves the current exchange rate table.
#'
#' @param table specifies which table should be fetched.
#'
#' @return nbp_api_response object containing the current
#' exchange rate table.
#'
#' @examples
#'
#' \donttest{
#' ## Retrieve the current A exchange rate table
#' response <- get_current_exchangerate_table("A")
#'
#' ## Retrieve the content
#' response$content
#'
#' }
#'
#' @seealso \url{https://api.nbp.pl/#kursyWalut}
#' @family tables
#' @export
#'
get_current_exchangerate_table <- function(table) {
    assert_character(table)

    request_url <- create_request(base_url = .tables_base_url(), path_parts = c(table))

    .send_tables_endpoint_request(request_url)
}

#' Retrieves the last n exchange rate tables.
#'
#' @param table specifies which table should be fetched.
#'
#' @param n number of exchange rate tables to retrieve.
#'
#' @examples
#'
#' \donttest{
#' ## Fetch the last 3 A exchange rate tables
#' response <- get_last_n_exchangerate_tables("A", 3)
#'
#' ## Preview response content
#' response$content
#' }
#'
#' @return nbp_api_response object containing the last n
#' exchange rate tables.
#'
#' @seealso \url{https://api.nbp.pl/#kursyWalut}
#' @family tables
#' @export
#'
get_last_n_exchangerate_tables <- function(table, n) {
    assert_character(table)
    assert_count(n)

    request_url <- create_request(base_url = .tables_base_url(), path_parts = c(table, "last", n))

    .send_tables_endpoint_request(request_url)
}

#' Retrieves the exchange rate table that was published today.
#'
#' @details If today's data is not available the API will
#' return a 404 Not found error. In that case the function will
#' return an error with an appropriate message.
#'
#' @param table specifies which table should be fetched.
#'
#' @examples
#'
#' \donttest{
#' ## Fetch todays A exchange rate table
#' response <- get_todays_exchangerate_table("A")
#'
#' ## Preview response content
#' response$content
#' }
#'
#' @return nbp_api_response object containing today's exchange rate table.
#'
#' @seealso \url{https://api.nbp.pl/#kursyWalut}
#' @family tables
#' @export
#'
get_todays_exchangerate_table <- function(table) {
    assert_character(table)

    request_url <- create_request(base_url = .tables_base_url(), path_parts = c(table, "today"))

    .send_tables_endpoint_request(request_url)
}

#' Retrieves the exchange rate table from a specific date.
#'
#' @details As exchange rate tables are not published on the weekends
#' fetching values from a weekend date will result in a 404
#' error. In those cases the function returns an error with an
#' appropriate message.
#'
#' @param table specifies which table should be fetched.
#' @param date date from which the exchange rate table should
#' be fetched.
#'
#' @examples
#'
#' \donttest{
#' ## Fetch the A exchange rate table from a week ago
#' response <- get_exchangerate_table_from("A", Sys.Date() - 7)
#'
#' ## Preview response content
#' response$content
#' }
#'
#' @return nbp_api_response object containing the exchange rate
#' table from the specified date.
#'
#' @seealso \url{https://api.nbp.pl/#kursyWalut}
#' @family tables
#' @export
#'
get_exchangerate_table_from <- function(table, date) {
    assert_character(table)
    assert_date(date)

    request_url <- create_request(base_url = .tables_base_url(), path_parts = c(table, as.character(date)))

    .send_tables_endpoint_request(request_url)
}

#' Retrieves the exchange rate tables from a specific interval.
#'
#' @details As exchange rate tables are not published on the weekends
#' fetching values from an interval containing a weekend will
#' result in a response that omits those days.
#'
#' @param table specifies which table should be fetched.
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
#' tables from the specified interval.
#'
#' @seealso \url{https://api.nbp.pl/#kursyWalut}
#' @family tables
#' @export
#'
get_exchangerate_tables_from_interval <- function(table, from, to) {
    assert_character(table)
    assert_interval(from, to)

    request_url <- create_request(base_url = .tables_base_url(), path_parts = c(table, as.character(from),
        as.character(to)))

    .send_tables_endpoint_request(request_url)
}
