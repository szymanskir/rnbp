#' Returns the base url for the gold price endpoint.
#'
.goldprice_base_url <- function() {
    add_path_part(nbp_api_base_url(), "cenyzlota")
}

#' Sends a request and parses the gold price endpoint response.
#'
#' @param request_url url to which the request should be sent.
#'
#' @return nbp_api_response object with the request content.
#'
.send_gold_endpoint_request <- function(request_url) {
    response <- send_get_request(url = request_url)
    parse_goldprice_endpoint_response(response)
}

#' Retrieves the current gold price.
#'
#' @return nbp_api_response object containing the current
#' gold price.
#'
#' @examples
#'
#' \donttest{
#' ## Fetch the current gold price
#' response <- get_current_goldprice()
#'
#' ## Retrieve the current gold price value
#' response$content$cena
#'
#' }
#'
#' @seealso \url{http://api.nbp.pl/#cenyZlota}
#' @family goldprice
#' @export
#'
get_current_goldprice <- function() {
  request_url <- create_request(base_url = .goldprice_base_url())
  .send_gold_endpoint_request(request_url)
}

#' Retrieves the last n gold prices.
#'
#' @param n number of gold prices to retrieve.
#'
#' @examples
#'
#' \donttest{
#' ## Fetch the last 3 gold price values
#' response <- get_last_n_goldprices(3)
#'
#' ## Preview response content
#' response$content
#' }
#'
#' @return nbp_api_response object containing the last n
#' gold prices.
#'
#' @seealso \url{http://api.nbp.pl/#cenyZlota}
#' @family goldprice
#' @export
#'
get_last_n_goldprices <- function(n) {
  assert_count(n)

  request_url <- create_request(base_url = .goldprice_base_url(),
                                path_parts = c("last", n))
  .send_gold_endpoint_request(request_url)
}

#' Retrieves the gold price that was published today.
#'
#' @details If today's data is not available the API will
#' return a 404 Not found error. In that case the function will
#' return an error with an appropriate message.
#'
#' @examples
#'
#' \donttest{
#' ## Fetch todays gold price
#' response <- get_todays_goldprice()
#'
#' ## Preview response content
#' response$content
#' }
#'
#' @return nbp_api_response object containing today's gold price.
#'
#' @seealso \url{http://api.nbp.pl/#cenyZlota}
#' @family goldprice
#' @export
#'
get_todays_goldprice <- function() {
  request_url <- create_request(base_url = .goldprice_base_url(),
                                path_parts = "today")
  .send_gold_endpoint_request(request_url)
}

#' Retrieves the gold price from a specific date.
#'
#' @details As gold prices are not published on the weekends
#' fetching values from a weekend date will result in a 404
#' error. In those cases the function returns an error with an
#' appropriate message.
#'
#' @param date date from which the gold price should
#' be fetched.
#'
#' @examples
#'
#' \donttest{
#' ## Fetch the gold price from a week ago
#' response <- get_goldprice_from(Sys.Date() - 7)
#'
#' ## Preview response content
#' response$content
#' }
#'
#' @return nbp_api_response object containing the gold price
#' from the specified date.
#'
#' @seealso \url{http://api.nbp.pl/#cenyZlota}
#' @family goldprice
#' @export
#'
get_goldprice_from <- function(date) {
  assert_date(date)

  request_url <- create_request(base_url = .goldprice_base_url(),
                                path_parts = as.character(date))
  .send_gold_endpoint_request(request_url)
}

#' Retrieves the gold prices from a specific interval.
#'
#' @details As gold prices are not published on the weekends
#' fetching values from an interval containing a weekend will
#' result in a response that omits those days.
#'
#' @param from start day of the interval.
#' @param to end day of the interval.
#'
#' @examples
#'
#' \donttest{
#' ## Fetch the gold prices from the past week
#' response <- get_goldprice_from_interval(Sys.Date() - 7, Sys.Date())
#'
#' ## Preview response content
#' response$content
#' }
#'
#' @return nbp_api_response object containing the gold prices
#' from the specified interval.
#'
#' @seealso \url{http://api.nbp.pl/#cenyZlota}
#' @family goldprice
#' @export
#'
get_goldprice_from_interval <- function(from, to) {
  assert_interval(from, to)

  request_url <- create_request(base_url = .goldprice_base_url(),
                                path_parts = c(as.character(from),
                                               as.character(to)))
  .send_gold_endpoint_request(request_url)
}
