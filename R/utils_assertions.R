assert <- function(expr, error) {
    if (!expr) {
        stop(error, call. = FALSE)
    }
}

assert_character <- function(x) {
  arg <- deparse(substitute(x))
  error_msg <- sprintf("The %s parameter should be a character.", arg)
  assert(is.character(x), error_msg)
}

assert_date <- function(x) {
  arg <- deparse(substitute(x))
  error_msg <- sprintf("The %s parameter should be a Date.", arg)
  assert(is_date(x), error_msg)
}

assert_count <- function(x) {
  arg <- deparse(substitute(x))
  error_msg <- sprintf("The %s parameter should be a positive integer.", arg)
  assert(is_count(x), error_msg)
}

assert_interval <- function(from, to) {
  assert_date(from)
  assert_date(to)

  arg_from <- deparse(substitute(from))
  arg_to <- deparse(substitute(to))

  error_msg <- sprintf("The %s, %s parameters should define a correct interval.", arg_from, arg_to)
  assert(from < to, error_msg)
}
