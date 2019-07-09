#' Returns the base url of the nbp api.
nbp_api_base_url <- function() {
  "http://api.nbp.pl/api/"
}

check_request <- function(response) {
  if (httr::http_error(response)) {
    stop(
      sprintf(
        "NBP API request failed [%s]\n%s\n<%s>",
        response$status_code,
        httr::content(response, as = "text", encoding = "UTF-8"),
        response$url
      ),
      call. = FALSE
    )
  } else {
    response
  }
}

parse_response <- function(response) {
  if (httr::http_type(response) != "application/json") {
    stop("The given response is not of type json", call. = FALSE)
  }

  content <- httr::content(response, "text")
  jsonlite::fromJSON(content, simplifyVector = FALSE)
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
