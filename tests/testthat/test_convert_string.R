library(caser)
context("Single instance string conversion")

test_that("Strings conversion matches expectation", {
    # Lower and upper camel conversions.
    expect_equal(convert_string("right back", target_case = "lower_camel"),
                 "rightBack")
    expect_equal(convert_string("Right BaCk", target_case = "lower_camel"),
                 "rightBack")
    expect_equal(convert_string("right_back_def", target_case = "upper_camel"),
                 "RightBackDef")
    expect_equal(convert_string("center@am-mid", target_case = "upper_camel"),
                 "CenterAmMid")
    expect_equal(convert_string("centerAmMid", target_case = "upper_camel"),
                 "CenterAmMid")
    expect_equal(convert_string("CenterAmMid", target_case = "upper_camel"),
                 "CenterAmMid")
    # All letter upper or lower.
    expect_equal(convert_string("CenterAmMid", target_case = "all_lower"),
                 "center_am_mid")
    expect_equal(convert_string("CenterAmMid", target_case = "all_upper"),
                 "CENTER_AM_MID")
    # First letters.
    expect_equal(convert_string("CenterAmMid",
                                target_case = "first_lower_then_first_upper"),
                 "center_Am_Mid")
    expect_equal(convert_string("CenterAmMid",
                                target_case = "first_upper"),
                 "Center_Am_Mid")
    # Sentence.
    expect_equal(convert_string("CenterAmMid", target_case = "sentence"),
                 "Center_am_mid")
    # Associated Press style title.
    expect_equal(convert_string("Center@Am_Mid", target_case = "proper_title"),
                 "Center_am_Mid")
    expect_equal(convert_string("i believe in dogs", target_case = "proper_title"),
                 "I_Believe_in_Dogs")
    # Test that functions as expected with varied input casing.
})

test_that("Manual source, conversion, and ignore rules match expectation", {
    # Source separator specified.
    # Custom target separator honored (except for camel conversions).
    # Ignore rules honored (only for auto-detect).
    # Single word honored.
    expect_equal(convert_string("centermid", target_case = "upper_camel"),
                 "Centermid")
})
