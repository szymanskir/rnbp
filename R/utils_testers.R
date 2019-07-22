#' Checks if an object is an integer.
#'
#' @param x object to be tested.
#'
#' @return TRUE or FALSE depending on whether its
#' argument is an integer or not.
#'
is_integer <- function(x) {
  is.numeric(x) && x %% 1 == 0
}

#' Checks if an object is a positive integer.
#'
#' @param x object to be tested.
#'
#' @return TRUE or FALSE depending on whether its
#' argument is a positive integer or not.
#'
is_count <- function(x) {
  is_integer(x) && x > 0
}


#' Checks if an object is a date object.
#'
#' @param x object to be tested.
#'
#' @return TRUE or FALSE depending on whether its
#' arguments is a date object or not.
is_date <- function(x) {
  class(x) == "Date"
}
