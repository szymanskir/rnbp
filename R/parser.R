.parse_json <- function(response) {
    if (httr::http_type(response) != "application/json") {
        stop("The given response is not of type json", call. = FALSE)
    }
    
    content <- httr::content(response, "text")
    jsonlite::fromJSON(content)
}

parse_tables_endpoint_response <- function(response) {
    json_content <- .parse_json(response)
    
    create_nbp_api_response(parsed_content = json_content, url = response$url, response = response)
}
