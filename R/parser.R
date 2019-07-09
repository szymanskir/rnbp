.parse_json <- function(response) {
  if (httr::http_type(response) != "application/json") {
    stop("The given response is not of type json", call. = FALSE)
  }

  content <- httr::content(response, "text")
  jsonlite::fromJSON(content, simplifyVector = FALSE)
}

parse_tables_endpoint_response <- function(response) {
  json_content <- .parse_json(response)
  parse_tables_endpoint_response_item <- function(json_content_item) {
    list(
      table = json_content_item$table,
      no = json_content_item$no,
      effectiveDate = json_content_item$effectiveDate,
      rates = currency_table_to_df(json_content_item$rates)
    )
  }

  parsed_content <- lapply(json_content, parse_tables_endpoint_response_item)

  create_nbp_api_response(
    parsed_content = parsed_content,
    url = response$url,
    response = response
  )
}

#' Converts a list of currency infos into a data frame
#'
#' @param currency_table list of currencies returned by the
#' api request
#'
#' @return the currency table converted into a data.frame
#'
currency_table_to_df <- function(currency_table) {
  do.call(rbind, lapply(currency_table, data.frame, stringAsFactors = FALSE))
}
