#' punycode encoder
#'
#' Encodes a character vector in the [punicode](https://en.wikipedia.org/wiki/Punycode)
#' format
#'
#' @param s a character vector
#' @param domain if `TRUE` the prefix `xn--` is added to the output
#'
#' @return s encoded in [punycode](https://en.wikipedia.org/wiki/Punycode)
#'
#' @examples
#'
#' # cedilla
#' puny::code( "François" )
#'
#' # emojis
#' s <- emo::ji_glue("hello:poop:")
#' puny::code(s)
#'
#' # more french
#' puny::code( "crème brûlée" )
#'
#' @importFrom stringi stri_enc_toutf32 stri_enc_toutf8
#' @export
code <- function(s, domain = FALSE){
  data <- stri_enc_toutf32(stri_enc_toutf8(s))
  res <- .Call( puny_encode, data )
  if( isTRUE(domain) ){
    res <- paste0("xn--", res)
  }
  res
}

#' punycode decoder
#'
#' Decodes a string encoded in [punycode](https://en.wikipedia.org/wiki/Punycode)
#'
#' @param s a character vector
#' @return a utf-8 string decoded from `s`
#'
#' @importFrom stringi stri_enc_fromutf32
#' @export
decode <- function(s){
  stri_enc_fromutf32(
    .Call( puny_decode, s)
  )
}
