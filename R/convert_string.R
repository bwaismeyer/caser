#' Convert the separator/casing for a single string.
#'
#' Takes a single string and converts it so that it uses the desiginated
#' separator and casing style.
#'
#' This function implements the core behavior of the package for a single
#' string - it is not vectorized and is not intended for external use. It takes
#' an optional argument allowing the user to specify a source separator style.
#'
#' If a source separator style is not given, it will attempt to identify what -
#' if any - character is used as a separator.
#'
#' Based on the given or identified source separator, the string is then broken
#' up and converted to the target separator and casing style.
#'
#' @param source_str A character string to convert to a new separator and/or
#'   casing style. Non-character types will be forced to character with a
#'   warning.
#' @param source_sep An optional character string specifying the character(s) or
#'   pattern used as as separator in the source string. The splitting is handled
#'   by \code{strplit} and so can be a regular expression. If the source style
#'   is a camel style, it is suggested that you leave this blank as this will be
#'   detected automatically.
#' @param ignore Only used if the source separator is auto-detected (i.e.,
#'   \code{source_sep} is not specified). A vector of strings describing symbols
#'   to exclude as candidates.
#' @param target_sep A character string describing the character(s) to be used
#'   as a separator in the converted string. Defaults to an underscore ("_"). If
#'   \code{target_case} is set to either \code{lower_camel} or
#'   \code{upper_camel}, this value is ignored.
#' @param target_case The casing style to be applied to the converted string.
#'   Casing-only options include: \code{all_lower},
#'   \code{first_lower_then_upper}, \code{first_upper}, \code{all_upper},
#'   \code{title}, \code{sentence}. Casing + separator options include:
#'   \code{lower_camel}, \code{upper_camel}.
#' @param special_caps An optional string vector of words that should be
#'   capitalized as specified in the string vector. They will be converted to
#'   lowercase for matching and matching words will be updated to match the
#'   version provided in the string vector.

#'
#' @return If the input is a character string - or is successfully converted -
#'   and the source separator is given - or can be auto-detected - the output
#'   will be a character string using the separator and casing style specified
#'   in \code{target_sep} and \code{target_case}.
#'
#' @export
convert_string <- function(source_str,
                           source_sep = NULL,
                           ignore = NULL,
                           target_sep = "_",
                           target_case = "all_lower",
                           special_caps = NULL
) {# Check if source separator specified.
    if (!is.null(source_sep)) {
        # Check if case was specified for separator style.
        if(source_sep == "case") {
            source_sep_style <- "case"
        } else {
            source_sep_style = "manual"
        }
    } else {
        # Where a source separator is not specified, attempt to identify one.
        identify_results <- caser:::identify_separator(source_str, ignore)
        source_sep_style <- identify_results$source_sep_style
        source_sep <- identify_results$candidate_seps
    }

    # Break the string based on the separator style.
    if(source_sep_style %in% c("manual", "non_character_non_numeric")) {
        # Convert the source separator candidates into a regex string.
        source_sep_regex <- paste0(source_sep, collapse = "|")

        # Break the string up.
        broken_str <- unlist(strsplit(source_str, source_sep_regex))
    } else if(source_sep_style == "case") {
        # Break the string up.
        broken_str <- unlist(strsplit(source_str,
                                      "(?=[[:upper:]])(?<=[[:lower:]])|(?=[[:upper:]])(?<=[[:upper:]])",
                                      perl = TRUE))
    } else if(source_sep_style == "single_word") {
        broken_str <- source_str
    }

    # Standardize the observed string casing.
    broken_str <- tolower(broken_str)

    # Apply the target casing to the broken string.
    if(target_case %in% c("lower_camel", "first_lower_then_first_upper")) {
        # Target the words.
        first_word <- broken_str[1]
        if(length(broken_str) > 1) {
            other_words <- broken_str[2:length(broken_str)]
        } else {
            other_words <- NA
        }

        # Capitalize the first letter of each following word.
        if(!is.na(other_words[[1]])) {
            for(word_index in 1:length(other_words)) {
                split_word <- unlist(strsplit(other_words[word_index], ""))
                split_word[1] <- toupper(split_word[1])
                other_words[word_index] <- paste0(split_word, collapse = "")
            }
        }

        # Update broken_str.
        if(!is.na(other_words[[1]])) {
            broken_str <- c(first_word, other_words)
        } else {
            broken_str <- first_word
        }
    } else if(target_case %in% c("upper_camel", "first_upper")) {
        # Capitalize the first letter of each word.
        for(word_index in 1:length(broken_str)) {
            split_word <- unlist(strsplit(broken_str[word_index], ""))
            split_word[1] <- toupper(split_word[1])
            broken_str[word_index] <- paste0(split_word, collapse = "")
        }
    } else if(target_case == "all_upper") {
        broken_str <- toupper(broken_str)
    } else if(target_case == "all_lower") {
        broken_str <- broken_str
    } else if(target_case == "sentence") {
        # Target the words.
        first_word <- broken_str[1]
        if(length(broken_str) > 1) {
            other_words <- broken_str[2:length(broken_str)]
        } else {
            other_words <- NA
        }

        # Capitalize the first letter of the first word.
        split_word <- unlist(strsplit(first_word, ""))
        split_word[1] <- toupper(split_word[1])
        first_word <- paste0(split_word, collapse = "")

        # Update broken_str.
        if(!is.na(other_words[[1]])) {
            broken_str <- c(first_word, other_words)
        } else {
            broken_str <- first_word
        }
    } else if(target_case == "proper_title") {
        # Capitalize the first letter of each word with four or more letters,
        # plus the first and last word.
        for(word_index in 1:length(broken_str)) {
            split_word <- unlist(strsplit(broken_str[word_index], ""))

            if(length(split_word) >= 4 |
               word_index == 1 |
               word_index == length(broken_str)) {
                split_word[1] <- toupper(split_word[1])
            }

            broken_str[word_index] <- paste0(split_word, collapse = "")
        }
    }

    # If target case is camel, insure the target separator is set correctly.
    if(target_case %in% c("lower_camel", "upper_camel")) {
        target_sep = ""
    }

    # If special capitalization rules have been provided, implement these.
    if(!is.null(special_caps)) {
        special_caps <- special_caps[tolower(special_caps) %in% broken_str]

        if(length(special_caps > 0)) {
            for(word in special_caps) {
                broken_str <- gsub(tolower(word), word, broken_str,
                                   fixed = TRUE)
            }
        }
    }

    # Rejoin the broken string using the target separator.
    new_str <- paste(broken_str, collapse = target_sep)

    # Return the converted string.
    return(new_str)
}
