library(caser)
context("Automatic separator identification")

test_that("Separator style matches expectation", {
    # Correctly detects non_character_non_numeric separator style.
    expect_equal(identify_separator("right back")[["source_sep_style"]],
                 "non_character_non_numeric")
    expect_equal(identify_separator("right_back")[["source_sep_style"]],
                 "non_character_non_numeric")
    expect_equal(identify_separator("right_Back_Defense")[["source_sep_style"]],
                 "non_character_non_numeric")
    expect_equal(identify_separator("right_back@defense")[["source_sep_style"]],
                 "non_character_non_numeric")
    # Correctly detects case style.
    expect_equal(identify_separator("rightBack")[["source_sep_style"]],
                 "case")
    expect_equal(identify_separator("RightBack")[["source_sep_style"]],
                 "case")
    expect_equal(identify_separator("right1Back3Defense")[["source_sep_style"]],
                 "case")
    # Correctly detect single words.
    expect_equal(identify_separator("rightback")[["source_sep_style"]],
                 "single_word")
    expect_equal(identify_separator("RIGHTBACK")[["source_sep_style"]],
                 "single_word")
    expect_equal(identify_separator("RIGHT1BACK")[["source_sep_style"]],
                 "single_word")
    # Ignore works properly.
    expect_equal(identify_separator("right back", " ")[["source_sep_style"]],
                 "single_word")
    expect_equal(identify_separator("right_back", "_")[["source_sep_style"]],
                 "single_word")
    expect_equal(identify_separator("right_Back_Defense", "_")[["source_sep_style"]],
                 "case")
    expect_equal(identify_separator("right_back@defense", "_")[["source_sep_style"]],
                 "non_character_non_numeric")
    expect_equal(identify_separator("right_back", "0")[["source_sep_style"]],
                 "non_character_non_numeric")
})

test_that("Separator candidates match expectation", {
    # Returns correct non_numeric_non_character separators.
    expect_equal(identify_separator("right back")[["candidate_seps"]],
                 c(" "))
    expect_equal(identify_separator("right_back")[["candidate_seps"]],
                 c("_"))
    expect_equal(identify_separator("right_Back_Defense")[["candidate_seps"]],
                 c("_"))
    expect_equal(identify_separator("right_back@defense")[["candidate_seps"]],
                 c("_", "@"))
    # Returns NULL where no non_numeric_non_character separator is present.
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
    # Ignore works properly.
    expect_equal(identify_separator("right back", " ")[["candidate_seps"]],
                 NULL)
    expect_equal(identify_separator("right_back", "_")[["candidate_seps"]],
                 NULL)
    expect_equal(identify_separator("right_Back_Defense", "_")[["candidate_seps"]],
                 NULL)
    expect_equal(identify_separator("right_back@defense", "_")[["candidate_seps"]],
                 c("@"))
    expect_equal(identify_separator("right_back", "0")[["candidate_seps"]],
                 c("_"))
})
