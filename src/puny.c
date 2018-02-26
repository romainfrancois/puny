#define R_NOREMAP
#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

#include "punycode.h"

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

    if( l_i && buffer[l_i-1] == '-' ) l_i-- ;
    SET_STRING_ELT( out, i, Rf_mkCharLen( (const char*)&buffer, l_i ) ) ;

  }

  UNPROTECT(1) ;
  return out ;
}


// registration

static const R_CallMethodDef CallEntries[] = {
  {"puny_encode", (DL_FUNC) &puny_encode, 1},
  {NULL, NULL, 0}
};

void R_init_puny(DllInfo *dll)
{
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
