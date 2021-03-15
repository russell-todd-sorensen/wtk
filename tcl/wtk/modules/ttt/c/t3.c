#include "t3-lex.h"

void yyerror(char *);

main( argc, argv )
     int argc;
     char **argv;
{
  ++argv, --argc;  /* skip over program name */
  if ( argc > 0 )
    yyin = fopen( argv[0], "r" );
  else
    yyin = stdin;

  /* yylex(); */
  return yyparse();
}

void yyerror(char * myerror) {
  printf(myerror);
}
