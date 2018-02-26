#' punycode encoder
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
