static int parse_stringdata() {

  int i = 0;
  int level = 1;
  char c;
  char ctmp;

  /* all strings start with an open double quote */
  buf[i] = '"';

  while ( (i < BUFMAX) && ( (c = input()) != EOF )   )
  {
    
    i++;
    
    switch (c) 
    {
    case '\{' :
    case '"':
      /* things which need escaping */
      printf("...Escaping '%c'\n", c);
      buf[i] = '\\';
      i++;
      buf[i] = c;
      break;
    case '\\':
      
      /* must step over backslash plus following char */
      
      ctmp = input();
      buf[i] = c;
      i++;
      buf[i] = ctmp;
      break;
    case '\[':
    case '$':
      
      /* end of the line, all strings end with closing double quote */
      unput(c);
      printf("End of string with '%c'\n", c);
      buf[i] = '"';
      i++;
      buf[i] = '\0';
      return (i);
    default:
      
      buf[i] = c;
      break;
    }   /* end switch */
    
  }    /* end while */

  /* all strings end with closing double quote */
  i++;
  buf[i] = '"';
  i++;
  buf[i] = '\0';
  return (i);
}


/*
<INITIAL>[^\[\$\\\"]{1,80} {
  yylval.str = yytext;
  return(STRINGDATA);
}

<INITIAL>[\"][^\[\$\\\{\}]{1,80} {
  yylval.str = yytext;
  return(QUOTEDSTRING);
}
*/
