.parse_json <- function(response) {
    assert(httr::http_type(response) == "application/json",
           "The given response is not of type json")

    content <- httr::content(response, "text")
    jsonlite::fromJSON(content)
}

parse_tables_endpoint_response <- function(response) {
    json_content <- .parse_json(response)
    json_content$effectiveDate <- as.Date(json_content$effectiveDate)
    create_nbp_api_response(parsed_content = json_content, url = response$url, response = response)
}


parse_rates_endpoint_response <- function(response) {
    json_content <- .parse_json(response)
    json_content$rates$effectiveDate <- as.Date(json_content$rates$effectiveDate)
    create_nbp_api_response(parsed_content = json_content, url = response$url, response = response)
}


parse_goldprice_endpoint_response <- function(response) {
    json_content <- .parse_json(response)
    json_content$data <- as.Date(json_content$data)
    create_nbp_api_response(parsed_content = json_content, url = response$url, response = response)
}
