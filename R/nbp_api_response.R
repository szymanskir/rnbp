create_nbp_api_response <- function(parsed_content, url, response) {
    structure(list(content = parsed_content, path = response$url, response = response), class = "nbp_api_response")
}

#' Checks whether the given object is of the class
#' nbp_api_response.
#'
#' @param x object to test if it is of the class nbp_api_response
#'
#' @return TRUE if the object is of the class nbp_api_response
#'
is_nbp_api_response <- function(x) {
    inherits(x, "nbp_api_response")
}

#' @export
print.nbp_api_response <- function(x, ...) {
    cat("--- NBP API RESPONSE ---\n")
    cat(sprintf("request url: %s\n", x$path))
    cat(sprintf("status code: %s\n", x$response$status_code))
    cat("--- CONTENT ---\n")
    utils::str(x$content)
}
