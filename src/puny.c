#define R_NOREMAP
#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

#include "punycode.h"

static const char canary[] = { 0xDE, 0xAD, 0xBA, 0xBE };

#define min(a, b) ((a) < (b) ? (a) : (b))

static void write_canary(void *dst, size_t len) {
  size_t i;

  for (i = 0; i < len; i += sizeof canary) {
    memcpy((char *) dst + i, canary, min(len - i, sizeof canary));
  }
}

// encoder
SEXP puny_encode( SEXP s ){
  char buffer[1024];

  int n = Rf_length(s) ;
  SEXP out = PROTECT(Rf_allocVector(STRSXP, n)) ;

  for( int i=0; i<n; i++){
    SEXP s_i = VECTOR_ELT(s,i) ;
    size_t l_i ;
    punycode_encode(
      (const uint32_t*)(INTEGER(s_i)),
      Rf_length(s_i),
      buffer,
      &l_i
    ) ;

    SET_STRING_ELT( out, i, Rf_mkCharLen( (const char*)&buffer, l_i ) ) ;

  }

  UNPROTECT(1) ;
  return out ;
}

// decoder
SEXP puny_decode( SEXP strings ){
  uint32_t buffer[1024];
  // char s_buffer[1024] ;
  write_canary(buffer, sizeof buffer);

  int n = Rf_length(strings) ;
  SEXP data = PROTECT(Rf_allocVector(VECSXP, n)) ;

  for( int i=0; i<n; i++){
    SEXP s = STRING_ELT(strings, i) ;
    size_t n_i = sizeof buffer ;
    punycode_decode( CHAR(s), LENGTH(s), buffer, &n_i ) ;

    SEXP ints = PROTECT(Rf_allocVector(INTSXP, n_i)) ;
    memmove( INTEGER(ints), &buffer, n_i * sizeof(uint32_t) ) ;
    SET_VECTOR_ELT(data, i, ints) ;
    UNPROTECT(1) ;

  }

  UNPROTECT(1) ;
  return data ;

}

// registration

static const R_CallMethodDef CallEntries[] = {
  {"puny_encode", (DL_FUNC) &puny_encode, 1},
  {"puny_decode", (DL_FUNC) &puny_decode, 1},
  {NULL, NULL, 0}
};

void R_init_puny(DllInfo *dll)
{
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
