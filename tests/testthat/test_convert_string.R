library(caser)
context("Single instance string conversion")

test_that("Strings conversion matches expectation", {
    # Lower and upper camel conversions.
    expect_equal(convert_string("right back", target_case = "lower_camel"),
                 "rightBack")
    expect_equal(convert_string("right_back_def", target_case = "upper_camel"),
                 "RightBackDef")
    expect_equal(convert_string("center@am-mid", target_case = "upper_camel"),
                 "CenterAmMid")
    ## I AM HERE WORKING ON THESE TESTS.
    # All letter upper or lower.
    # First letters.
    # Chicago Manual of Style title.
    # Sentence.
})

test_that("Manual source, conversion, and ignore rules match expectation", {
    # Source separator specified.
    # Custom target separator honored (except for camel conversions).
    # Ignore rules honored (only for auto-detect).
    # Single word honored.
})
