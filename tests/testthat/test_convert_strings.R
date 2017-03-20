library(caser)
context("String vector and dataframe column name conversion")

test_set_1 <- c("all_the_kings_men",
                "rightCenterMid",
                "OMG_the@puppIes",
                "I see twenty reasons",
                "ISee20Reasons")

test_that("Strings conversion matches expectation", {
    # Source separator specified.
    expect_equal(convert_strings("center@mid_left",
                                source_sep = "@",
                                target_case = "upper_camel"),
                 "CenterMid_left")
})

test_that("Manual source, conversion, and ignore rules match expectation", {
})
