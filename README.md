# `caser`

An R package for converting strings and string vectors among common naming and
formatting conventions.

## To Do
### `convert_string`
* Implement force to string and warnings where fail (return source string on
failure).
* Implement warning where auto-detect uses multiple sep candidates.
```
# warning("Multiple separator candidates detected.\n",
#         paste0("* Detected:", candidate_seps, "\n"),
#         "* All will be used as separators.",
#         "* You can control this behavior with 'source_sep` and `ignore`.\n")
```
* Warn if conversion will produce strings that cannot be recovered or converted
again.
* Optional: Return message indicating separator style and (where appropriate) 
value used.

### `convert_strings`
* Build tests (see test_convert_string for ideas, though should focus more on
vector and dataframe behavior).
* Code string vector conversion.
* Code df conversion.
* Detect and give error for invalid argument inputs (e.g., unknown casing
styles).
* Move all error handling to this layer (may need to update supporting layers to
pass errors and other performance data up).

### `caser` (overall)
* Switch to stringr functions.
* Insure perl always set to TRUE where appropriate.
* Hide internal functions.
* Make sure use proper "::" and ":::" notation where use material from other
packages or unexported `caser` material.
* Review all docs to make sure still up to date.
* Make sure dependencies properly captured.
* Test with `dplyr`.

## Introduction

Ever find yourself dealing with a dataframe with unruly column names? Or with a 
formatting/casing style you find a bit awkward? Ever wish there was a convenient
function for flipping your code-friendly variable names to print-friendly (and
vice versa)?

The `caser` package has a very simple purpose: Help you convert strings -
including vectors of strings such as dataframe column names - to a target
naming/formatting convention.

`caser` is designed to take advantage of the fact that most naming and 
formatting conventions tinker with two string properties: the separator between 
words and the word capitalization rules. By specifying a separator style and a
capitilization style, you can quickly flip strings among the most common 
naming/formatting conventions (or come up with your own fancy pants ones).

The rest of this document describes what styles are supported and what the major
pieces of the package are.

## Supported Separator Styles

* **Styles without a Separator** (casing style is implicit)
    * lower camel case: `exampleString`
    * upper camel case: `ExampleString`
* **Styles with a Separator** (can apply any casing style)
    * underscores: `example_string`
    * spaces: `example string`
    * custom: `example.string`
    
## Supported Casing Styles

* **Styles for Programming**
    * all lower: `example_string`
    * first letter lower then first letter upper: `example_String`
    * first letter upper: `Example_String`
    * all upper: `EXAMPLE_STRING`
* **Styles for Printing**
    * proper title: `Implements_Simplified_Associated_Press_Capitalization_Rules`
    * sentence: `First_word_capitalized_the_rest_lower`
    
## Key Package Functions

IN PROGRESS.

## Useful Resources

* The [Wikipedia discussion of naming conventions](https://en.wikipedia.org/wiki/Naming_convention_(programming))
    (especially in programming).
* A (very) concise summary of [the Associated Press capitalization rules](http://www.titlecapitalization.com/#).
