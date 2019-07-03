create_nbp_api_response <- function(x) {

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
  cat(sprintf("%s\n", x))
}
