context("Checking if query builder functions are working correctly")

test_that("Requests are created properly", {
    request <- create_request(base_url = "www.test.com/", path_parts = c("part1", "part2", "part3"))

    expect_equal(request, "www.test.com/part1/part2/part3/?format=json")
})

test_that("Path parts are added properly", {
    url <- add_path_part("www.test.com/", "part1")
    expect_equal(url, "www.test.com/part1/")
})


test_that("Format options is added properly", {
    url <- add_json_format("www.test.com/")
    expect_equal(url, "www.test.com/?format=json")
})
