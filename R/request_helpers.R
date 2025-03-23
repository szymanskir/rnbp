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

is_internet_available <- function() {
  curl::has_internet()
}


send_get_request <- function(url = NULL, config = list(), ..., handle = NULL) {
  assert(is_internet_available(), "Request failed: there is no internet connection.")
  response <- httr::GET(url = url, config = config, ..., handle = handle)
  check_request(response)
}
