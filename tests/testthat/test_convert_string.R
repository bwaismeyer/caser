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
    expect_equal(convert_string("ISee20Reasons", target_case = "upper_camel"),
                 "ISee20Reasons")
    # All letter upper or lower.
    expect_equal(convert_string("CenterAmMid", target_case = "all_lower"),
                 "center_am_mid")
    expect_equal(convert_string("CenterAmMid", target_case = "all_upper"),
                 "CENTER_AM_MID")
    expect_equal(convert_string("ISee20Reasons", target_case = "all_upper"),
                 "I_SEE_20_REASONS")
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
    expect_equal(convert_string("CenterAmMidASF", target_case = "sentence"),
                 "Center_am_mid_asf")
    # Associated Press style title.
    expect_equal(convert_string("Center@Am_Mid", target_case = "proper_title"),
                 "Center_am_Mid")
    expect_equal(convert_string("i believe in dogs", target_case = "proper_title"),
                 "I_Believe_in_Dogs")
})

test_that("Manual source, conversion, and ignore rules match expectation", {
    # Source separator specified.
    expect_equal(convert_string("center@mid_left",
                                source_sep = "@",
                                target_case = "upper_camel"),
                 "CenterMid_left")
    expect_equal(convert_string("center@mid_left",
                                source_sep = "@|_",
                                target_case = "upper_camel"),
                 "CenterMidLeft")
    # Custom target separator honored (except for camel conversions).
    expect_equal(convert_string("center@mid_left",
                                target_sep = "__",
                                target_case = "sentence"),
                 "Center__mid__left")
    expect_equal(convert_string("center@mid_left",
                                target_sep = "__",
                                target_case = "upper_camel"),
                 "CenterMidLeft")
    # Ignore rules honored (only for auto-detect).
    expect_equal(convert_string("center@mid_left",
                                ignore = "_",
                                target_case = "upper_camel"),
                 "CenterMid_left")
    expect_equal(convert_string("center@mid_left",
                                source_sep = "@|_",
                                ignore = "_",
                                target_case = "upper_camel"),
                 "CenterMidLeft")
    # Single word honored.
    expect_equal(convert_string("centermid", target_case = "upper_camel"),
                 "Centermid")
    # Special cap rules honored.
    expect_equal(convert_string("the_best_Cam", target_case = "sentence",
                                special_caps = c("Best", "CAM")),
                 "The_Best_CAM")
    expect_equal(convert_string("nOboDY@likes_a_brian_bam",
                                target_case = "sentence",
                                special_caps = c("Brian", "BAM")),
                 "Nobody_likes_a_Brian_BAM")
})
