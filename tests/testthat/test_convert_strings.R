library(caser)
context("String vector and dataframe column name conversion")

test_that("Strings conversion matches expectation", {
    # Source separator specified.
    expect_equal(convert_string("center@mid_left",
                                source_sep = "@",
                                target_case = "upper_camel"),
                 "CenterMid_left")
})

test_that("Manual source, conversion, and ignore rules match expectation", {
})
