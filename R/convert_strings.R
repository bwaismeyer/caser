#' Convert string or column name separators and casings.
#'
#' Takes a string vector and converts the strings to use the specified separator
#' and casing style.
#'
#' Alternatively takes a dataframe and converts the column names to use the
#' specified separator and casing style.
#'
#' If a source separator style is not given (the default behavior), the function
#' will attempt to identify what - if any - character or character set is used
#' as a separator for each string.
#'
#' Based on the given or identified source separator, the string is then broken
#' up and converted to the target separator and casing style.
#'
#' The function also takes additional arguments that give more fine-grained
#' control over the conversion. You are able to manually specify characters the
#' separator auto-detect should ignore and can provide more specific
#' capitalization rules for target words in the strings.
#'
#' Note: Blocks of numeric characters will be treated as distinct words when
#' converting from camel case (e.g., in "omgPuppy120", "120" would be treated as
#' a distinct word). Blocks of capitals longer than two characters will be
#' treated likewise (e.g., in "omgIPuppyAAA", "AAA" would be treated as one word
#' but "I" and "Puppy" separated).
#'
#' @param source_strings A string vector with one or more strings to convert.
#'   Non-character types will be forced to character with a warning.
#' @param source_sep An optional character string specifying the character(s) or
#'   pattern(s) used as as separator in the source strings. The splitting is
#'   handled by \code{strplit} and so can be a regular expression. If the source
#'   style is a camel style or varies by string, it is suggested that you leave
#'   this blank as this will be detected automatically.
#' @param ignore Only used if the source separator is auto-detected (i.e.,
#'   \code{source_sep} is not specified). A vector of strings describing symbols
#'   to exclude as candidates.
#' @param target_sep A character string describing the character(s) to be used
#'   as a separator in the converted strings. Defaults to an underscore ("_").
#'   If \code{target_case} is set to either \code{lower_camel} or
#'   \code{upper_camel}, this value is ignored.
#' @param target_case The casing style to be applied to the converted strings.
#'   Casing-only options include: \code{all_lower},
#'   \code{first_lower_then_upper}, \code{first_upper}, \code{all_upper},
#'   \code{title}, \code{sentence}. Casing + separator options include:
#'   \code{lower_camel}, \code{upper_camel}.
#' @param special_caps An optional string vector of words that should be
#'   capitalized as specified in the string vector. They will be converted to
#'   lowercase for matching and matching words will be updated to match the
#'   version provided in the string vector.
#'
#' @return If the input is a string vector - or is successfully converted - and
#'   the source separator is given - or can be auto-detected - the output will
#'   be a string_vector using the separator and casing style specified in
#'   \code{target_sep} and \code{target_case}.
#'
#'   If the input is a dataframe, a dataframe will be returned with the
#'   separator/case styling applied to the dataframe column names.
#'
#' @export
convert_strings <- function(source_strings,
                            source_sep = NULL,
                            ignore = NULL,
                            target_sep = "_",
                            target_case = "all_lower",
                            special_caps = NULL
) {

}
