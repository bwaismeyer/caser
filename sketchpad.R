test_strings_df <- data.frame(
    "raw_mixed" = c(
        "right back",
        "Left back",
        "left Center Back",
        "right_center_back",
        "sea",
        "SFO",
        "Msp",
        "there_are_many_reasons",
        "you_might_like_1",
        "I'll give it to you",
        "ifYouAsk",
        "don't @ me okay?",
        "don't@me@okay?",
        "don't \" me please"
    ),
    stringsAsFactors = FALSE
)

tsdf <- test_strings_df

change_case <- function(source_str,
                        source_sep = NULL,
                        target_sep = "_",
                        # Update with all options.
                        target_case = "all_lower"
                        # Future features...
                        # values to ignore when auto detecting
) {
    # Check if source separator given.
    if (!is.null(source_sep)) {
        source_sep_style = "manual"
    } else {
        source_sep_style = "unset"
    }

    # Future: Check if source symbols to ignore are given.

    # Where a source separator is not given, we attempt to identify one.
    if (source_sep_style == "unset") {
        # Capture any non-character, non-numeric symbols as candidate
        # separators.
        candidate_seps <- gsub("[[:alnum:]]", "", source_str)
        candidate_seps <- unlist(strsplit(candidate_seps, split = ""))
        candidate_seps <- unique(candidate_seps)

        # Are there non-character, non-numeric separator candidates?
        if (length(candidate_seps > 1)) {
        # I AM HERE
        }
        #   - YES: More than one type in the string? (Future: Ignore specified.)
        #       - YES: Stop. "Multiple separator candidates detected. Please
        #           manually specify source separator (or symbols to ignore)."
        #       - NO: Set separator style to non_character_non_numeric.
    }
    #   - NO: Does case vary in the string?
    #       - YES: Set separator style to camel.
    #       - NO: Set separator style to single_word.

    # Break the string based on the separator style.
    # - manual: Break on given separator value.
    # - non_character_non_numeric: Break on non-character/non-numeric values.
    #   (Future: Excluding any specified values to ignore).
    # - camel: Break on upper casing (don't drop value).
    # - single_word: No break.
    # - Optional: Return message indicating separator style and (where
    #   appropriate) value used.

    # Apply the target casing to the broken string.
    # - all_lower
    # - first_lower_then_first_upper
    # - first_upper
    # - all_upper
    # - proper_title
    # - sentence

    # Rejoin the broken string using the target separator.

    # Return the converted string.
    # FOR SCALING UP: Maybe also return sep style and value for report across
    #   vector conversion.
    #return(source_sep_style)
    return(candidate_seps)
}
