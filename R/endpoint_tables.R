.tables_base_url <- function() {
    add_path_part(nbp_api_base_url(), "exchangerates/tables")
}


.send_tables_endpoint_request <- function(request_url) {
    response <- send_get_request(url = request_url)
    parse_tables_endpoint_response(response)
}


get_current_exchangerate_table <- function(table) {
    assert_character(table)

    request_url <- create_request(base_url = .tables_base_url(), path_parts = c(table))

    .send_tables_endpoint_request(request_url)
}

get_last_n_exchangerate_tables <- function(table, n) {
    assert_character(table)
    assert_count(n)

    request_url <- create_request(base_url = .tables_base_url(), path_parts = c(table, "last", n))

    .send_tables_endpoint_request(request_url)
}

get_todays_exchangerate_table <- function(table) {
    assert_character(table)

    request_url <- create_request(base_url = .tables_base_url(), path_parts = c(table, "today"))

    .send_tables_endpoint_request(request_url)
}


get_exchangerate_table_from <- function(table, date) {
    assert_character(table)
    assert_date(date)

    request_url <- create_request(base_url = .tables_base_url(), path_parts = c(table, as.character(date)))

    .send_tables_endpoint_request(request_url)
}


get_exchangerate_tables_from_interval <- function(table, from, to) {
    assert_character(table)
    assert_interval(from, to)

    request_url <- create_request(base_url = .tables_base_url(), path_parts = c(table, as.character(from),
        as.character(to)))

    .send_tables_endpoint_request(request_url)
}
