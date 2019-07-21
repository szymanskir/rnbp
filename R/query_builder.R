#' Creates a request with the given path parts.
#' The json format argument is included by default.
#'
#' @param base_url base url of the API for which a request
#' should be created
#'
#' @param path_parts that should be added to the base url
#'
#' @return request url composed of the given base url and
#' specified path parts
#'
create_request <- function(base_url, path_parts = NULL) {
    for (path_part in path_parts) {
        base_url <- add_path_part(base_url, path_part)
    }

    add_json_format(base_url)
}

#' Adds a path part to the given url
#'
#' @param url url to which a path part should
#' be added
#'
#' @param path_name path part which should be added
#' to the url
#'
#' @return url with the path part added
#'
add_path_part <- function(url, path_name) {
    paste0(url, path_name, "/")
}

#' Adds the json formatting option to the
#' passed url request.
#'
#' @param url request url to which the json format option
#' should be added
#'
#' @return url with json format option added
#'
add_json_format <- function(url) {
    paste0(url, "?format=json")
}
