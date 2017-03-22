library(caser)
context("String vector and dataframe column name conversion")

test_set_1 <- c("all_the_kings_men",
                "rightCenterMid",
                "OMG_the@puppIes",
                "I see twenty reasons",
                "ISee20Reasons",
                "ugh")

test_set_1_default <- c("all_the_kings_men",
                        "right_center_mid",
                        "omg_the_puppies",
                        "i_see_twenty_reasons",
                        "i_see_20_reasons",
                        "ugh")

test_set_1_camel <- c("AllTheKingsMen",
                      "RightCenterMid",
                      "OmgThePuppies",
                      "ISeeTwentyReasons",
                      "ISee20Reasons",
                      "Ugh")

test_df_1 <- data.frame("1", "2", "3", "4", "5", "6")
names(test_df_1) <- test_set_1

test_df_1_default <- test_df_1
names(test_df_1_default) <- test_set_1_default

test_df_1_camel <- test_df_1
names(test_df_1_camel) <- test_set_1_camel

test_that("Strings conversion matches expectation", {
    # Defaults.
    expect_equal(convert_strings(test_set_1),
                 test_set_1_default)
    # Camel.
    expect_equal(convert_strings(test_set_1, target_case = "upper_camel"),
                 test_set_1_camel)
})

test_that("Dataframe conversion matches expectation", {
    # Defaults.
    expect_equal(convert_strings(test_df_1),
                 test_df_1_default)
    # Camel.
    expect_equal(convert_strings(test_df_1, target_case = "upper_camel"),
                 test_df_1_camel)
})
