%option noyywrap
%option outfile="t3-lex.c" header-file="t3-lex.h"
%option noreject
%option debug
%array
%s ARGSTART
%s SWITCHARGSTART
%x CASESTART

%{
  /* stuff from t3-lex.l */
#include <math.h>
#include "y.tab.h"
#define BUFMAX 16000

int enter_case = 0;

char buf[BUFMAX] = {0};
char * buf_ptr = buf;

static int parse_stringdata();
static int parse_quoted_arg();
static int parse_curly_brased_arg();

%}

VARIABLE  [\$][a-zA-Z_][a-zA-Z0-9_]*
VARIABLE2 [\$][\{][^\}\[]*[\}]

OPENCB   [\{]

%%

<INITIAL>\[else\/\][ \t\f\r\n]*|\[else\] {
  yylval.str = "";
  return(ELSE);
}

<INITIAL>\[comment\/\][ \t\f\r\n]*|\[comment\] {
  yylval.str = "";
  /* do nothing */
}

<INITIAL>\[ws\/\][ \t\f\r\n]*|\[ws\] {
  yylval.str = "";
  /* do nothing */
}

<INITIAL>\[comment[ \t]+ {
  yylval.str = "";
  BEGIN(ARGSTART);
  return(COMMENT);
}

<INITIAL>\[ws[ \t]+ {
  yylval.str = "";
  BEGIN(ARGSTART);
  return(WS);
}

<INITIAL>\[elseif[ \t]+ {
  yylval.str = "";
  BEGIN(ARGSTART);
  return(ELSEIF);
}

<INITIAL>\[if[ \t]+ {
  BEGIN(ARGSTART);
  return(IFBEGIN);
}

<INITIAL>\[break\]|\[break\/][ \t\f\r\n]+ {
  
  return(BREAK);
}

<INITIAL>\[continue\]|\[continue\/][ \t\f\r\n]+ {
  
  return(CONTINUE);
}

<INITIAL>\[\/if\/\][ \t\f\r\n]*|\[\/if\] {
  return(IFEND);
}

<INITIAL>\[incr[ \t]+ {
  BEGIN(ARGSTART);
  return(INCR);
}

<INITIAL>\[incrn[ \t]+ {
  BEGIN(ARGSTART);
  return(INCRN);
}

<INITIAL>\[expr[ \t]+ {
   BEGIN(ARGSTART);
   return(EXPR);
}

<INITIAL>\[expr-to[ \t]+ {
   BEGIN(ARGSTART);
   return(EXPRTO);
}

<INITIAL>\[foreach[ \t]+ {
  BEGIN(ARGSTART);
  return(FOREACHBEGIN);
}

<INITIAL>\[format[ \t]+ {
   BEGIN(ARGSTART);
   return(FORMAT);
}

<INITIAL>\[format-to[ \t]+ {
   BEGIN(ARGSTART);
   return(FORMATTO);
}

<INITIAL>\[regexp[ \t]+ {
   BEGIN(ARGSTART);
   return(REGEXP);
}
<INITIAL>\[regexp-to[ \t]+ {
   BEGIN(ARGSTART);
   return(REGEXPTO);
}

<INITIAL>\[ifreg[ \t]+ {
   BEGIN(ARGSTART);
   return(IFREG);
}
<INITIAL>\[else-ifreg[ \t]+ {
   BEGIN(ARGSTART);
   return(ELSEIFREG);
}

<INITIAL>\[regsub[ \t]+ {
   BEGIN(ARGSTART);
   return(REGSUB);
}

<INITIAL>\[regsub-to[ \t]+ {
   BEGIN(ARGSTART);
   return(REGSUBTO);
}

<INITIAL>\[xr[ \t]+ {
   BEGIN(ARGSTART);
   return(XRESOURCE);
}

<INITIAL>\[\/foreach\/\][ \t\f\r\n]*|\[\/foreach\] {
  return(FOREACHENDCMD);
}

<INITIAL>\[lappend[ \t]+ {
  BEGIN(ARGSTART);
  return(LAPPEND);
}

<INITIAL>\[lsort-to[ \t]+ {
  BEGIN(ARGSTART);
  return(LSORTTO);
}

<INITIAL>\[lassign[ \t]+ {
  BEGIN(ARGSTART);
  return(LASSIGN);
}

<INITIAL>\[lassign-to[ \t]+ {
  BEGIN(ARGSTART);
  return(LASSIGNTO);
}

<INITIAL>\[lindex[ \t]+ {
  BEGIN(ARGSTART);
  return(LINDEX);
}

<INITIAL>\[lindex-to[ \t]+ {
  BEGIN(ARGSTART);
  return(LINDEXTO);
}

<INITIAL>\[linsert-to[ \t]+ {
  BEGIN(ARGSTART);
  return(LINSERTTO);
}

<INITIAL>\[list[ \t]+ {
  BEGIN(ARGSTART);
  return(LIST);
}

<INITIAL>\[list-to[ \t]+ {
  BEGIN(ARGSTART);
  return(LISTTO);
}

<INITIAL>\[llength[ \t]+ {
  BEGIN(ARGSTART);
  return(LLENGTH);
}

<INITIAL>\[llength-to[ \t]+ {
  BEGIN(ARGSTART);
  return(LLENGTHTO);
}

<INITIAL>\[lrange[ \t]+ {
  BEGIN(ARGSTART);
  return(LRANGE);
}

<INITIAL>\[lrange-to[ \t]+ {
  BEGIN(ARGSTART);
  return(LRANGETO);
}

<INITIAL>\[lrepeat[ \t]+ {
  BEGIN(ARGSTART);
  return(LREPEAT);
}

<INITIAL>\[lrepeat-to[ \t]+ {
  BEGIN(ARGSTART);
  return(LREPEATTO);
}

<INITIAL>\[lreplace[ \t]+ {
  BEGIN(ARGSTART);
  return(LREPLACE);
}

<INITIAL>\[lreplace-to[ \t]+ {
  BEGIN(ARGSTART);
  return(LREPLACETO);
}

<INITIAL>\[lreverse-to[ \t]+ {
  BEGIN(ARGSTART);
  return(LREVERSETO);
}

<INITIAL>\[lreverse[ \t]+ {
  BEGIN(ARGSTART);
  return(LREVERSE);
}

<INITIAL>\[lsearch-to[ \t]+ {
  BEGIN(ARGSTART);
  return(LSEARCHTO);
}

<INITIAL>\[lsearch[ \t]+ {
  BEGIN(ARGSTART);
  return(LSEARCH);
}

<INITIAL>\[lset[ \t]+ {
  BEGIN(ARGSTART);
  return(LSET);
}

<INITIAL>\[dict-to[ \t]+ {
  BEGIN(ARGSTART);
  return(DICTTO);
}

<INITIAL>\[dict[ \t]+ {
  BEGIN(ARGSTART);
  return(DICT);
}

<INITIAL>\[dict-filter|\[dict[ \t]+filter[ \t]+ {
  BEGIN(ARGSTART);
  return(DICTFILTER);
}

<INITIAL>\[dict-filter-to|\[dict-to[ \t]+filter|\[dict[ \t]+filter-to[ \t]+ {
  BEGIN(ARGSTART);
  return(DICTFILTERTO);
}

<INITIAL>\[dict-print[ \t]+ {
  BEGIN(ARGSTART);
  return(DICTPRINT);
}

<INITIAL>\[dict-for|\[dict[ \t]+for[ \t]+ {
  BEGIN(ARGSTART);
  return(DICTFORBEGIN);
}

<INITIAL>\[\/dict-for\/\][ \t\f\r\n]*|\[\/dict-for\] {
  return(DICTFOREND);
}

<INITIAL>\[dict-with|\[dict[ \t]+with[ \t]+ {
  BEGIN(ARGSTART);
  return(DICTWITHBEGIN);
}

<INITIAL>\[\/dict-with\/\][ \t\f\r\n]*|\[\/dict-with\] {
  return(DICTWITHEND);
}


<INITIAL>\[scan[ \t]+ {
  BEGIN(ARGSTART);
  return(SCAN);
}

<INITIAL>\[scan-to[ \t]+ {
  BEGIN(ARGSTART);
  return(SCANTO);
}

<INITIAL>\[namespace-eval[ \t]+ {
  BEGIN(ARGSTART);
  return(NSEVALBEGIN);
}

<INITIAL>\[\/namespace-eval\/\][ \t\f\r\n]*|\[\/namespace-eval\] {
  return(NSEVALEND);
}

<INITIAL>\[namespace[ \t]+ {
  BEGIN(ARGSTART);
  return(NSBEGIN);
}

<INITIAL>\[\/namespace\/\][ \t\f\r\n]*|\[\/namespace\] {
  return(NSEND);
}

<INITIAL>\[proc[ \t]+ {
  BEGIN(ARGSTART);
  return(PROCBEGIN);
}

<INITIAL>\[\/proc\/\][ \t\f\r\n]*|\[\/proc\] {
  return(PROCEND);
}

<INITIAL>\[variable[ \t]+ {
  BEGIN(ARGSTART);
  return(VARIABLE_COMMAND);
}

<INITIAL>\[set[ \t]+ {
  BEGIN(ARGSTART);
  return(SET);
}

<INITIAL>\[get[ \t]+ {
  BEGIN(ARGSTART);
  return(GET);
}

<INITIAL>\[string[ \t]+ {
  BEGIN(ARGSTART);
  return(STRING);
}

<INITIAL>\[string-to[ \t]+ {
  BEGIN(ARGSTART);
  return(STRINGTO);
}

<INITIAL>\[split[ \t]+ {
  BEGIN(ARGSTART);
  return(SPLIT);
}

<INITIAL>\[split-to[ \t]+ {
  BEGIN(ARGSTART);
  return(SPLITTO);
}

<INITIAL>\[encoding[ \t]+ {
  BEGIN(ARGSTART);
  return(ENCODING);
}

<INITIAL>\[encoding-to[ \t]+ {
  BEGIN(ARGSTART);
  return(ENCODINGTO);
}

<INITIAL>\[clock[ \t]+ {
  BEGIN(ARGSTART);
  return(CLOCK);
}

<INITIAL>\[clock-to[ \t]+ {
  BEGIN(ARGSTART);
  return(CLOCKTO);
}

<INITIAL>\[info[ \t]+ {
  BEGIN(ARGSTART);
  return(INFO);
}

<INITIAL>\[info-to[ \t]+ {
  BEGIN(ARGSTART);
  return(INFOTO);
}

<INITIAL>\[array[ \t]+ {
  BEGIN(ARGSTART);
  return(ARRAY);
}

<INITIAL>\[array-to[ \t]+ {
  BEGIN(ARGSTART);
  return(ARRAYTO);
}

<INITIAL>\[concat[ \t]+ {
  BEGIN(ARGSTART);
  return(CONCAT);
}

<INITIAL>\[concat-to[ \t]+ {
  BEGIN(ARGSTART);
  return(CONCATTO);
}

<INITIAL>\[join[ \t]+ {
  BEGIN(ARGSTART);
  return(JOIN);
}

<INITIAL>\[join-to[ \t]+ {
  BEGIN(ARGSTART);
  return(JOINTO);
}

<INITIAL>\[append[ \t]+ {
  BEGIN(ARGSTART);
  return(APPEND);
}

<INITIAL>\[append-to[ \t]+ {
  BEGIN(ARGSTART);
  return(APPENDTO);
}

<INITIAL>\[binary[ \t]+ {
  BEGIN(ARGSTART);
  return(BINARY);
}

<INITIAL>\[binary-to[ \t]+ {
  BEGIN(ARGSTART);
  return(BINARYTO);
}

<INITIAL>\[glob[ \t]+ {
  BEGIN(ARGSTART);
  return(GLOB);
}

<INITIAL>\[glob-to[ \t]+ {
  BEGIN(ARGSTART);
  return(GLOBTO);
}

<INITIAL>\[file[ \t]+ {
  BEGIN(ARGSTART);
  return(FILEX);
}

<INITIAL>\[file-to[ \t]+ {
  BEGIN(ARGSTART);
  return(FILEXTO);
}

<INITIAL>\[unset[ \t]+ {
  BEGIN(ARGSTART);
  return(UNSET);
}

<INITIAL>\[switch[ \t]+ {
  BEGIN(SWITCHARGSTART);
  return(SWITCHBEGIN);
}

<CASESTART>\[case[ \t]+ {
  BEGIN(ARGSTART);
  return(CASEBEGIN);
}

<CASESTART>\[default\] {
  BEGIN(INITIAL);
  return(DEFAULTCASEBEGIN);
}

<CASESTART>[ \t\n\f\r]* {
  /* do nothing whitespace allowed between case/switch tags */
}

<CASESTART>[^ \t\n\f\r\[] {
  /* error */
  yy_state_type previous_state = yy_get_previous_state();
  printf ( " => BAD TEXT IN SWITCH/CASE: Error! '%s' PREVIOUS STATE = '%i'\n",
        yytext,
       (int)previous_state );
  yylval.str = "ERROR: BAD TEXT IN SWITCH/CASE";
  return(BADTEXTINSWITCH);
}

<CASESTART>\[\/switch\/\][ \t\f\r\n]*|\[\/switch\] {
  BEGIN(INITIAL);
  return(SWITCHEND);
}

<INITIAL>\[\/case\/\][ \t\f\r\n]*|\[\/case\] {
  BEGIN(CASESTART);
  return(CASEEND);
}

<INITIAL>\[\/default\/\][ \t\f\r\n]*|\[\/default\] {
  BEGIN(CASESTART);
  return(CASEEND);
}


<INITIAL>\[while[ \t]+ {
  BEGIN(ARGSTART);
  return(WHILEBEGIN);
}

<INITIAL>\[\/while\/\][ \t\f\r\n]*|\[\/while\] {
  BEGIN(INITIAL);
  return(WHILEEND);
}

<INITIAL>{VARIABLE}\({VARIABLE}|{VARIABLE2}|[!-Z\]-~]+\) {
    yylval.str = yytext;
    return(VAR);
}

<INITIAL>{VARIABLE} {
    yylval.str = yytext;
    return(VAR);
}

<INITIAL>{VARIABLE2} {
    yylval.str = yytext;
    return(VAR);
}

<ARGSTART,SWITCHARGSTART>[ \t]+ { 
  yylval.str = "";
  /* do nothing else */ 
}

<ARGSTART,SWITCHARGSTART>[\[]+ { 
  yylval.str = "ERROR: OPEN BRACKET IN ARGS";
  /* do nothing else, let bison exit */ 
  return(BADWSINARG);
}

<ARGSTART,SWITCHARGSTART>[\f\n\r\v\b\a] {
  yylval.str = "ERROR: BAD WHITESPACE";
  return(BADWSINARG);
}

<ARGSTART,SWITCHARGSTART>[^"\{\}\\\$ \t\n\r\f\v\b\a\[\]\/]+ {
  yylval.str = yytext;
  /* printf ( "   ARG: Naked arg '%s'\n", yytext); */
  return(ARG);
}

<ARGSTART,SWITCHARGSTART>[\"] {
  unput('"');
  int len = parse_quoted_arg();
  if (len >= 2) {
      yylval.str = buf;
      /* printf("len = %i, yytext = '%s' ", len, buf); */
  }
  return(ARG);
}

<ARGSTART,SWITCHARGSTART>[\{] {
  unput('\{');
  int len = parse_curly_brased_arg();
  if (len >= 2) {
      yylval.str = buf;
      /* printf("len = %i, yytext = '%s' ", len, buf); */
  }
  return(ARG);
}

<ARGSTART,SWITCHARGSTART>\/\][ \t\f\r\n]* {
  /* printf( "      CLOSETAG: Eat Whitespace... ']' yytext = '%s'\n", yytext ); */
  yylval.str = '\0';
  BEGIN(INITIAL);
  return(CLOSETAG);
}

<ARGSTART,SWITCHARGSTART>\] { 
  /* printf( "      CLOSETAG: Finished args... '/]' yytext = '%s'\n", yytext ); */
  yylval.str = '\0';
  if (YYSTATE == ARGSTART) {
      BEGIN(INITIAL);
  } else {
      BEGIN(CASESTART);
  }
  return(CLOSETAG);
}

<INITIAL>.|\n {
  unput(yytext[0]);
  /* printf( "Starting to parse_stringdata()"); */
  int len = parse_stringdata();
  yylval.str = buf;
  return(STRINGDATA);
}

%%

/*
 functions used in this file
*/
static int parse_stringdata() {

  int i = 0;
  int level = 1;
  char c;
  char ctmp;

  while ( (i < BUFMAX) && ( (c = input()) != EOF )   )
  {
    
    switch (c) 
    {
    case '\{' :
    case '"':
      /* things which need escaping */
      /* printf("...Escaping '%c'\n", c); */
      buf[i] = '\\';
      i++;
      buf[i] = c;
      i++;
      break;
    case '\\':
      
      /* must step over backslash plus following char */
      
      ctmp = input();
      buf[i] = '\\';
      i++;
      buf[i] = ctmp;
      i++;
      break;
    case '\[':
    case '$':
      if (i == 0) {
       /* pattern doesn't match existing 
        * variable or command
        */
       buf[i] = '\\';
       i++;
       buf[i] = c;
       i++;
       break;
      }
      /* end of the line, all strings end with closing double quote */
      unput(c);
      /* printf("End of string with '%c'\n", c); */
      buf[i] = '\0';
      return (i);
    default:
      /*printf("buffing '%c' at buf[%i]\n", c, i); */
      buf[i] = c;
      i++;
      break;
    }   /* end switch */
    
  }    /* end while */

  /* all strings end with closing double quote */
  /*printf("ran out of data, cleaning up\n"); */
  buf[i] = '\0';
  return (i);
}


static int parse_curly_brased_arg() {

  int i = 0;
  int level = 1;
  char c;
  char ctmp;
  
  
  if ( (c = input()) != '\{' )
    return i;
  else
    buf[i] = '\{';
  
  while ( (c = input()) != EOF  && (i < BUFMAX) )
  {
      
    i++;
      
    switch (c) 
    {
    case '\{' :
      
      level++;
      buf[i] = c;
      break;
      
    case '}' :
      
      level--;
      buf[i] = '}';
      
      if (level == 0) 
	{
	  
	  c = input();
	  
	  if (c == ']' || c == ' ' || c == '\t') {
	    i++;
	    buf[i] = '\0';
	    unput(c);
	    /* printf("buf = '%s'", buf); */
	    return i;
	  } else if (c == '/') {
	    
	    ctmp = input();
	    
	    if (ctmp == ']') {
	      i++;
	      buf[i] = '\0';
	      unput(ctmp);
	      unput(c);
	      return i;
	      /* printf("buf = '%s'", buf); */
	    } else {
	      unput(ctmp);
	      unput(c);
	      return 0;
	    }
	    
	  } else {
	    /* illegal char following braced string */
	    /* printf("illegal char following braced string, '%c'\n", c); */
	    unput(c);
	    return 0;
	  }
	}
      break;
      
    case '\\':
      
      /* must step over backslash plus following char */
      
      ctmp = input();
      buf[i] = '\\';
      i++;
      buf[i] = ctmp;
      break;
      
    case '\[':
      
      /* must escape bracket char */
      
      buf[i] = '\\';
      i++;
      buf[i] = c;
      
      break;
    default:
      
      buf[i] = c;
      break;
      
    }   /* end switch */
    
  }    /* end while */
}


static int parse_quoted_arg() {

   int i = 0;
   char c;
   char ctmp;

   if ( (c = input()) != '\"' ) {
      return i;
   } else {
      buf[i] = '\"';
   }

   while ( (c = input()) != EOF && (i < BUFMAX) ) {

      i++;

      switch (c) {
      case '\"' :
         /* printf("in case '\"' at i = '%i'\n", i);
            printf("buf = '%s'\n", buf); */
         buf[i] = '\"';

         c = input();

         if (c == ']' || c == ' ' || c == '\t') {
             i++;
             buf[i] = '\0';
             unput(c);
             /* printf("buf = '%s'", buf); */
             return i;
         } else if (c == '/') {

             ctmp = input();

             if (ctmp == ']') {
                i++;
                buf[i] = '\0';
                unput(ctmp);
                unput(c);
                return i;
                /* printf("buf = '%s'", buf); */
             } else {
                unput(ctmp);
                unput(c);
                return 0;
             }

         } else {
             /* illegal char following quoted string */
             /* printf("illegal char following quoted string, '%c'\n", c); */
             unput(c);
             return 0;
         }
         break;

      case '\\':

         /* must step over backslash plus following char */

         ctmp = input();

         buf[i] = '\\';
         i++;
         buf[i] = ctmp;

         break;

      case '[':

         /* must escape bracket char */
         buf[i] = '\\';
         i++;
         buf[i] = c;

         break;
      default:

         /* printf("appending %c to buf\n", c); */
         buf[i] = c;
         break;
      }

      /* printf("i = %i, buf[%i] = %c\n", i, i, buf[i]); */
   }
   return 0;
}








