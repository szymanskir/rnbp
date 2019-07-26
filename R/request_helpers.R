check_request <- function(response) {
    if (httr::http_error(response)) {
        stop(sprintf("NBP API request failed [%s]\n%s\n<%s>", response$status_code, httr::content(response,
            as = "text", encoding = "UTF-8"), response$url), call. = FALSE)
    } else {
        response
    }
}


send_get_request <- function(url = NULL, config = list(), ..., handle = NULL) {
    assert(curl::has_internet(), "Request failed: there is no internet connection.")
    response <- httr::GET(url = url, config = config, ..., handle = handle)
    check_request(response)
}
