tables_base_url <- function() {
  add_path_part(nbp_api_base_url(), "exchangerates/tables")
}

parse_table_endpoints_response <- function(response) {
  parsed_content <- parse_response(response)
  lapply(parsed_content, parse_table_endpoints_response_item)
}

parse_table_endpoints_response_item <- function(parsed_content_item) {
  list(
    table = parsed_content_item$table,
    no = parsed_content_item$no,
    effectiveDate = parsed_content_item$effectiveDate,
    rates = currency_table_to_df(parsed_content_item$rates)
  )
}

get_current_exchangerate_table <- function(table) {
  stopifnot(is.character(table))

  request_url <- create_request(
    base_url= tables_base_url(),
    path_parts = c(table)
  )

  response <- httr::GET(url = request_url)
  response <- check_request(response)

  create_nbp_api_response(
    parsed_content = parse_table_endpoints_response(response)[[1]],
    url = request_url,
    response = response
  )
}

get_last_n_exchangerate_tables <- function(table, n) {
  stopifnot(is.character(table))
  stopifnot(n %% 1 == 0)

  request_url <- create_request(
    base_url= tables_base_url(),
    path_parts = c(table, "last", n)
  )

  response <- httr::GET(url = request_url)

  create_nbp_api_response(
    parsed_content = parse_table_endpoints_response(response),
    url = request_url,
    response = response
  )
}

get_todays_exchangerate_table <- function(table) {
  stopifnot(is.character(table))

  request_url <- create_request(
    base_url= tables_base_url(),
    path_parts = c(table, "today")
  )

  response <- httr::GET(url = request_url)

  create_nbp_api_response(
    parsed_content = parse_table_endpoints_response(response)[[1]],
    url = request_url,
    response = response
  )
}


get_exchangerate_table_from <- function(table, date) {
  stopifnot(is.character(table))

}

get_exchangerate_tables_from_interval <- function(table, from, to) {
  stopifnot(is.character(table))
  stopifnot(class(from) == "Date")
  stopifnot(class(to) == "Date")

  request_url <- create_request(
    base_url= tables_base_url(),
    path_parts = c(table, as.character(from), as.character(to))
  )

  response <- httr::GET(url = request_url)

  create_nbp_api_response(
    parsed_content = parse_table_endpoints_response(response),
    url = request_url,
    response = response
  )
}
