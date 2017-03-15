#' Identify source string separator.
#'
#' Attempts to identify the separator used in a source character string.
#'
#' This function defines and implements the logic used to auto-identify a
#' separator in a source string when a person declines to manually specify the
#' source string separator. It is a core helper function for
#' \code{convert_string}. It is not vectorized and is not intended for external
#' use.
#'
#' By default the function captures any non-character, non-numeric symbol as a
#' candidate separator. Users can specify specific symbols to ignore, but if a
#' character/numeric symbol or symbols are the separtor the user will need to
#' manually specify the separator at the level of \code{convert_string}.
#'
#' @param source_str A character string to evaluate for separator candidates.
#' @param ignore A vector of strings describing symbols to exclude as
#'   candidates.
#'
#' @return If the input is a character string - evaluated/forced by
#'   \code{convert_string} - the output will be a list including a detected
#'   separator style and separator(s). If multiple separator candidates are
#'   detected and the candidates to ignore have not been specified, a warning
#'   will be returned as well.
#'
#' @export
identify_separator <- function(source_str, ignore = NULL) {
    # Capture any non-character, non-numeric symbols as candidate
    # separators.
    candidate_seps <- gsub("[[:alnum:]]", "", source_str)
    candidate_seps <- unlist(strsplit(candidate_seps, split = ""))
    candidate_seps <- unique(candidate_seps)

    # Drop separators that should be ignored.
    if(!is.null(ignore)) {
        candidate_seps <- candidate_seps[!(candidate_seps %in% ignore)]
    }

    # Are there non-character, non-numeric separator candidates?
    if (length(candidate_seps) > 0) {
        source_sep_style <- "non_character_non_numeric"
    } else {
        # If no identified candidates, assess if character casing varies (and so
        # might be a separator candidate).
        if (grepl("[[:upper:]]", source_str) &
            grepl("[[:lower:]]", source_str)) {
            source_sep_style <- "case"
            candidate_seps <- NULL
        } else {
            # If no casing detected, assume the source string was a single word
            # with no separators.
            source_sep_style <- "single_word"
            candidate_seps <- NULL
        }
    }

    # Return the separator style and any separator candidates.
    results <- list(
        source_sep_style = source_sep_style,
        candidate_seps   = candidate_seps
    )

    return(results)
}
