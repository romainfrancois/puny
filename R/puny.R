#' punycode encoder
#'
#' @param s a character vector
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
code <- function(s){
  data <- stri_enc_toutf32(stri_enc_toutf8(s))
  .Call( puny_encode, data )
}
