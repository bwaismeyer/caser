library(caser)
context("Automatic separator identification")

test_that("Separator style matches expectation", {
    expect_equal(identify_separator("right back")[["source_sep_style"]],
                 "non_character_non_numeric")
    expect_equal(identify_separator("right_back")[["source_sep_style"]],
                 "non_character_non_numeric")
    expect_equal(identify_separator("right_Back_Defense")[["source_sep_style"]],
                 "non_character_non_numeric")
    expect_equal(identify_separator("right_back@defense")[["source_sep_style"]],
                 "non_character_non_numeric")
    expect_equal(identify_separator("rightBack")[["source_sep_style"]],
                 "case")
    expect_equal(identify_separator("RightBack")[["source_sep_style"]],
                 "case")
    expect_equal(identify_separator("right1Back3Defense")[["source_sep_style"]],
                 "case")
    expect_equal(identify_separator("rightback")[["source_sep_style"]],
                 "single_word")
    expect_equal(identify_separator("RIGHTBACK")[["source_sep_style"]],
                 "single_word")
    expect_equal(identify_separator("RIGHT1BACK")[["source_sep_style"]],
                 "single_word")
})

test_that("Separator candidates match expectation", {
    expect_equal(identify_separator("right back")[["candidate_seps"]],
                 c(" "))
    expect_equal(identify_separator("right_back")[["candidate_seps"]],
                 c("_"))
    expect_equal(identify_separator("right_Back_Defense")[["candidate_seps"]],
                 c("_"))
    expect_equal(identify_separator("right_back@defense")[["candidate_seps"]],
                 c("_", "@"))
    expect_equal(identify_separator("rightBack")[["candidate_seps"]],
                 NULL)
    expect_equal(identify_separator("RightBack")[["candidate_seps"]],
                 NULL)
    expect_equal(identify_separator("right1Back3Defense")[["candidate_seps"]],
                 NULL)
    expect_equal(identify_separator("rightback")[["candidate_seps"]],
                 NULL)
    expect_equal(identify_separator("RIGHTBACK")[["candidate_seps"]],
                 NULL)
    expect_equal(identify_separator("RIGHT1BACK")[["candidate_seps"]],
                 NULL)
})
