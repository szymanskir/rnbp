.goldprice_base_url <- function() {
    add_path_part(nbp_api_base_url(), "cenyzlota")
}

.send_golprice_endpoint_request <- function(request_url) {
    response <- send_get_request(url = request_url)
    parse_rates_endpoint_response(response)
}

get_current_goldprice <- function() {
  request_url <- create_request(base_url = .goldprice_base_url())
  .send_golprice_endpoint_request(request_url)
}

get_last_n_goldprices <- function(n) {
  request_url <- create_request(base_url = .goldprice_base_url(),
                                path_parts = c("last", n))
  .send_golprice_endpoint_request(request_url)
}

get_todays_goldprice <- function() {
  request_url <- create_request(base_url = .goldprice_base_url(),
                                path_parts = "today")
  .send_golprice_endpoint_request(request_url)
}

get_goldprice_from <- function(date) {
  request_url <- create_request(base_url = .goldprice_base_url(),
                                path_parts = as.character(date))
  .send_golprice_endpoint_request(request_url)
}

get_goldprice_from_interval <- function(from, to) {
  request_url <- create_request(base_url = .goldprice_base_url(),
                                path_parts = c(as.character(from),
                                               as.character(to)))
  .send_golprice_endpoint_request(request_url)
}
