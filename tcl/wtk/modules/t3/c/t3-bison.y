%{
/* stuff from ttlite-bison.y */
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>
#include "t3.h"
#define YYDEBUG 1

char * temp;
int len;
extern char buf[];
int depth = 0;

%}


%union {
  char  *str;
  int   var;
}

%token  <str> ARG
%token  <str> QUOTEDSTRING
%token  <str> STRINGDATA
%token  <str> VAR
%token  <str> VAR2

%token  APPEND
%token  APPENDTO
%token  ARRAY
%token  ARRAYTO
%token  BADTEXTINSWITCH
%token  BADWSINARG
%token  BINARY
%token  BINARYTO
%token  BREAK
%token  CASEBEGIN
%token  CASEEND
%token  CHAR
%token  CLOSETAG
%token  CLOCK
%token  CLOCKTO
%token  COMMENT
%token  CONCAT
%token  CONCATTO
%token  CONTINUE
%token  DEFAULTCASEBEGIN
%token  DICT
%token  DICTFILTER
%token  DICTFILTERTO
%token  DICTFORBEGIN
%token  DICTFOREND
%token  DICTPRINT
%token  DICTTO
%token  DICTWITHBEGIN
%token  DICTWITHEND
%token  ENCODING
%token  ENCODINGTO
%token  ELSE
%token  ELSEIF
%token  ELSEIFREG
%token  EXPR
%token  EXPRTO
%token  FILEX
%token  FILEXTO
%token  FOREACHBEGIN
%token  FOREACHENDCMD
%token  FORMAT
%token  FORMATTO
%token  GET
%token  GLOB
%token  GLOBTO
%token  IFBEGIN
%token  IFEND
%token  IFREG
%token  INCR
%token  INCRN
%token  INFO
%token  INFOTO
%token  JOIN
%token  JOINTO
%token  LAPPEND
%token  LASSIGN
%token  LASSIGNTO
%token  LINSERTTO
%token  LINDEX
%token  LINDEXTO
%token  LIST
%token  LISTTO
%token  LLENGTH
%token  LLENGTHTO
%token  LRANGE
%token  LRANGETO
%token  LREPEAT
%token  LREPEATTO
%token  LREPLACE
%token  LREPLACETO
%token  LREVERSE
%token  LREVERSETO
%token  LSEARCH
%token  LSEARCHTO
%token  LSET
%token  LSORTTO
%token  NSBEGIN
%token  NSEND
%token  NSEVALBEGIN
%token  NSEVALEND
%token  PROCBEGIN
%token  PROCEND
%token  REGEXP
%token  REGEXPTO
%token  REGSUB
%token  REGSUBTO
%token  SCAN
%token  SCANTO
%token  SPLIT
%token  SPLITTO
%token  STRING
%token  STRINGTO
%token  SWITCHBEGIN
%token  SWITCHEND
%token  SET
%token  UNSET
%token  VARIABLE
%token  WHILEBEGIN
%token  WHILEEND
%token  WS
%token  X
%token  XRESOURCE

%%

statements: 
 /* empty */
 | statement statements
;

statement:
    append_cmd
  | appendto_cmd
  | array_cmd
  | arrayto_cmd
  | binary_cmd
  | binaryto_cmd
  | break_cmd
  | clock_cmd
  | clockto_cmd
  | comment_cmd
  | concat_cmd
  | concatto_cmd
  | continue_cmd
  | dict_cmd
  | dictfilter_cmd
  | dictfilterto_cmd
  | dictfor_cmd
  | dictprint_cmd
  | dictto_cmd
  | dictwith_cmd
  | encoding_cmd
  | encodingto_cmd
  | expr_cmd
  | exprto_cmd
  | extension_resource_cmd
  | file_cmd
  | fileto_cmd
  | foreach_cmd
  | format_cmd
  | formatto_cmd
  | get_cmd
  | glob_cmd
  | globto_cmd
  | if_cmd
  | ifreg_cmd
  | incr_cmd
  | incrn_cmd
  | info_cmd
  | infoto_cmd
  | join_cmd
  | jointo_cmd
  | lappend_cmd
  | lassign_cmd
  | lassignto_cmd
  | lindex_cmd
  | lindexto_cmd
  | linsertto_cmd
  | list_cmd
  | listto_cmd
  | llength_cmd
  | llengthto_cmd
  | lrange_cmd
  | lrangeto_cmd
  | lrepeat_cmd
  | lrepeatto_cmd
  | lreplace_cmd
  | lreplaceto_cmd
  | lreverse_cmd
  | lreverseto_cmd
  | lsearch_cmd
  | lsearchto_cmd
  | lset_cmd
  | lsortto_cmd
  | nseval_cmd
  | ns_cmd
  | proc_cmd
  | quotedstring
  | regexp_cmd
  | regexpto_cmd
  | regsub_cmd
  | regsubto_cmd
  | scan_cmd
  | scanto_cmd
  | set_cmd
  | split_cmd
  | splitto_cmd
  | string_cmd
  | stringdata
  | stringto_cmd
  | switch_cmd
  | unset_cmd
  | var
  | variable_cmd
  | while_cmd
  | whitespace_cmd
;

/* ***** STRINGDATA/QUOTEDSTRING HANDLER ***** */

stringdata:
  STRINGDATA {printf("append __string \"%s\"\n", $1);}
;

quotedstring:
  QUOTEDSTRING {printf("append __string \{%s}\n", $1);}
;

/* ***** UNSET COMMAND ***** */
unset_cmd:
  unset_begin unset_end
  ;

unset_begin:
  UNSET ARG {
    printf("unset '%s'\n", $2);
  }
;

unset_end:
  CLOSETAG
  ;

/* ***** SWITCH/CASE COMMANDS ***** */

switch_cmd:
  switch_begin switch_args case_cmds switch_end

;

switch_begin:
  SWITCHBEGIN ARG {printf("switch %s", $2);}
;

switch_args:
  args CLOSETAG {printf(" \{\n");}
  ;
switch_end:
  SWITCHEND  {printf("}\n");}
  ;

case_cmd: 
  case_begin case_args CLOSETAG statements case_end
  |
  default_begin statements case_end
  ;

case_begin:
  CASEBEGIN ARG {printf("   %s", $2);}
;

case_args:
  args {printf(" \{\n   ");}
;

case_end:
  CASEEND {printf("   }\n");}
;

default_begin:
  DEFAULTCASEBEGIN {printf("   default \{\n   ");}
;

case_cmds:
  /*empty */
  | case_cmd case_cmds
  ;

/* ***** WHILE COMMAND ***** */

while_cmd:
 while_begin CLOSETAG statements while_end
 ;

while_begin: 
  WHILEBEGIN ARG {printf("\nwhile %s \{\n", $2);}
;

while_end:   
  WHILEEND {printf("\n}\n");}
;

/* ***** PROC COMMAND ***** */

proc_cmd:
 proc_begin statements proc_end
 ;

proc_begin: 
  PROCBEGIN ARG {
    printf("if \{[llength [info procs ::t3::%s]] == 0} \{\n\t", $2);
    /* printf("namespace eval ::t3 \{}\n\t"); */
    printf("proc ::t3::%s", $2);
  } 
  ARG {
    printf(" %s", $4);
  } 
  CLOSETAG {
    printf(" \{\n");
  }
;

proc_end:   
  PROCEND {
    printf("\n\t\treturn $__string\n\t}\n}\n");
  }
;

/* ***** NSEVAL COMMAND ***** */

nseval_cmd:
 nseval_begin statements nseval_end
 ;

nseval_begin: 
  NSEVALBEGIN ARG {
    printf("namespace eval ::t3::%s", $2);
  }
  CLOSETAG {
    printf(" \{\n");
  }
;

nseval_end:   
  NSEVALEND {
    printf("\n}\n");
  }
;

/* ***** NS COMMAND ***** */

ns_cmd:
  ns_begin ns_arg ns_end
;

ns_begin:
  NSBEGIN ARG {
    printf("append __string [namespace %s", $2);
  }
;

ns_arg:
  ARG {
    printf(" %s", $1);
  }
;

ns_end:
  CLOSETAG {
    printf("]\n");
 } 
;


/* ***** BREAK & CONTINUE COMMANDS ***** */

break_cmd:
  BREAK {printf("break\n");}
;

continue_cmd:
  CONTINUE {printf("continue\n");}
;

/* ***** EXPR/-TO COMMAND ***** */

expr_cmd:
  EXPR ARG {printf("append __string [expr %s", $2);} args CLOSETAG {printf("]\n");}
;

exprto_cmd:
  EXPRTO ARG {printf("set %s [expr", $2);} args CLOSETAG {printf("]\n");}
;

/* ***** FOREACH COMMAND ***** */

foreach_cmd:
  foreach_begin foreach_end CLOSETAG statements foreach_endcmd
;

foreach_begin:
  FOREACHBEGIN ARG {printf("foreach %s", $2);} ARG {printf(" %s", $4);}
;

foreach_end: 
  args {printf(" \{\n");}
;

foreach_endcmd:
  FOREACHENDCMD {printf("}\n");}
;

/* ***** FORMAT/-TO COMMAND ***** */

format_cmd:
  FORMAT ARG {printf("append __string [format %s", $2);} args CLOSETAG {printf("]\n");}
;

formatto_cmd:
  FORMATTO ARG {printf("set %s [format", $2);} args CLOSETAG {printf("]\n");}
;

/* ***** EXTENSION COMMANDS X & XR ***** */

extension_resource_cmd:
  XRESOURCE ARG {
     printf("if {[::ext::resource::exists %s]} {\next::resource::eval %s", $2, $2);
   } 
   args CLOSETAG {
     printf("\n}\n");
   }
;

/* ***** REGULAR EXPRESSION COMMANDS: REGEXP/REGSUB ***** */

regexp_cmd:
  REGEXP ARG {printf("regexp %s", $2);} args CLOSETAG {printf("\n");}
;

regexpto_cmd:
  REGEXPTO ARG {printf("set %s [regexp ", $2);} args CLOSETAG {printf("]\n");}
;

regsub_cmd:
  REGSUB ARG {printf("append __string [regsub %s", $2);} args CLOSETAG {printf("]\n");}
;

regsubto_cmd:
  REGSUBTO ARG {printf("set %s [regsub", $2);} args CLOSETAG {printf("]\n");}
;

ifreg_cmd:
  ifreg_begin statements if_end
  ;

ifreg_begin:
  IFREG ARG {printf("if {[regexp %s ", $2);} args CLOSETAG {printf("]} {\n");}
;

/* ***** VAR (VARIABLE) ***** */

var: 
  VAR {printf("\nappend __string %s\n", $1);}
;

/* ***** IF COMMAND & FRIENDS ELSE/ELSEIF ***** */

if_cmd:
  if_begin CLOSETAG statements if_end 
  ;

if_begin: 
  IFBEGIN ARG {printf("if %s {\n", $2);}
;

if_end:
  IFEND {printf("}\n");}
  | else_cmd
  | elseif_cmd
  ;

else_cmd:
  else_begin statements else_end
  ; 

else_begin:
  ELSE {printf(" } else {\n");}
;

else_end:
  IFEND {printf("}\n");}
;

elseif_cmd:
  elseif_begin statements elseif_end
  ;

elseif_begin:
  ELSEIF ARG {printf("\n} elseif %s {\n", $2);} CLOSETAG
  |
  ELSEIFREG ARG {printf("\n} elseif {[regexp %s ", $2);} args CLOSETAG {printf("]} {\n");}
;

elseif_end:
  IFEND {printf("}\n");}
  | elseif_cmd
  | else_cmd
;

/* ***** SET/GET COMMANDS ***** */

set_cmd:
  SET ARG {printf("set %s", $2);} ARG {printf(" %s\n", $4);} CLOSETAG
;

get_cmd:
  GET ARG {printf("append __string [set %s]\n", $2);} CLOSETAG
  ;

/*  ******** INCR COMMAND ******** */

incr_cmd:
  INCR ARG {printf("incr %s 1\n", $2);} CLOSETAG
;

incrn_cmd:
  INCRN ARG {printf("incr %s", $2);} ARG {printf(" %s\n", $4);} CLOSETAG
;

/* ********* LAPPEND COMMAND ******* */

lappend_cmd:
  lappend_begin lappend_end CLOSETAG {printf("\n");}
;

lappend_begin:
  LAPPEND ARG {printf("lappend %s", $2);} ARG {printf(" %s", $4);}
;

lappend_end:
  args
;

/* ***** LIST COMMANDS ***** */

lassign_cmd:
  LASSIGN ARG {printf("lassign %s", $2);} args CLOSETAG {printf("\n");}
;

lassignto_cmd:
  LASSIGNTO ARG {printf("set %s [lassign", $2);} args CLOSETAG {printf("]\n");}
;

lsortto_cmd:
  LSORTTO ARG {printf("set %s [lsort", $2);} args CLOSETAG {printf("]\n");}
;

lindex_cmd:
  LINDEX ARG {printf("append __string [lindex %s", $2);} args CLOSETAG {printf("]\n");}
;

lindexto_cmd:
  LINDEXTO ARG {printf("set %s [lindex", $2);} args CLOSETAG {printf("]\n");}
;

linsertto_cmd:
  LINSERTTO ARG {printf("set %s [linsert", $2);} args CLOSETAG {printf("]\n");}
;

list_cmd:
  LIST ARG {printf("append __string [list %s", $2);} args CLOSETAG {printf("]\n");}
;

listto_cmd:
  LISTTO ARG {printf("set %s [list", $2);} args CLOSETAG {printf("]\n");}
;

llength_cmd:
  LLENGTH ARG {printf("append __string [llength %s", $2);} args CLOSETAG {printf("]\n");}
;

llengthto_cmd:
  LLENGTHTO ARG {printf("set %s [llength", $2);} args CLOSETAG {printf("]\n");}
;

lrange_cmd:
  LRANGE ARG {printf("append __string [lrange %s", $2);} args CLOSETAG {printf("]\n");}
;

lrangeto_cmd:
  LRANGETO ARG {printf("set %s [lrange", $2);} args CLOSETAG {printf("]\n");}
;

lrepeat_cmd:
  LREPEAT ARG {printf("append __string [lrepeat %s", $2);} args CLOSETAG {printf("]\n");}
;

lrepeatto_cmd:
  LREPEATTO ARG {printf("lappend %s {*}[lrepeat", $2);} args CLOSETAG {printf("]\n");}
;

lreplace_cmd:
  LREPLACE ARG {printf("append __string [lreplace %s", $2);} args CLOSETAG {printf("]\n");}
;

lreplaceto_cmd:
  LREPLACETO ARG {printf("set %s [lreplace", $2);} args CLOSETAG {printf("]\n");}
;

lreverse_cmd:
  LREVERSE ARG {printf("append __string [lreverse %s", $2);} args CLOSETAG {printf("]\n");}
;

lreverseto_cmd:
  LREVERSETO ARG {printf("set %s [lreverse", $2);} args CLOSETAG {printf("]\n");}
;
lsearch_cmd:
  LSEARCH ARG {printf("append __string [lsearch %s", $2);} args CLOSETAG {printf("]\n");}
;

lsearchto_cmd:
  LSEARCHTO ARG {printf("set %s [lsearch", $2);} args CLOSETAG {printf("]\n");}
;

lset_cmd:
  LSET ARG {printf("lset %s", $2);} args CLOSETAG {printf("\n");}
;

/* ***** DICT/DICT-TO/DICT-FOR/DICT-WITH COMMANDS ***** */

/* DICT COMMAND SIMPLY PERFORMS OPERATION WITHOUT PRINTING ANYTHING */

dict_cmd:
  DICT ARG {printf("dict %s", $2);} args CLOSETAG {printf("\n");}
;

dictprint_cmd:
  DICTPRINT ARG {printf("append __string [dict %s", $2);} args CLOSETAG {printf("]\n");}
;

dictto_cmd:
  DICTTO ARG {printf("set %s [dict", $2);} args CLOSETAG {printf("]\n");}
;

/* ***** DICTFOR COMMAND ***** */

dictfor_cmd:
 dictfor_begin statements dictfor_end
 ;

dictfor_begin: 
  DICTFORBEGIN ARG {
    /* a list containing: {keyVar valueVar} */
    printf("dict for %s", $2);
  } 
  ARG {
    /* dictionaryValue */
    printf(" %s", $4);
  }
  CLOSETAG {
    /* dictionary Script coming up */
    printf(" \{\n\t");
  }
;

dictfor_end:   
  DICTFOREND {
    printf("\n}\n");
  }
;

/* ***** DICTFILTER COMMAND ***** */


dictfilter_cmd: 
  DICTFILTER ARG {
    /* dictionary Value */
    printf("dict filter %s", $2);
  } 
  ARG {
    /* type key or value */
    printf(" %s", $4);
  }
  ARG {
    /*  globPattern */
    printf(" %s", $6);
  }
  CLOSETAG {
    /* dictionary Script coming up */
    printf(" ]\n");
  }
;

/* ***** DICTFILTERTO COMMAND ***** */


dictfilterto_cmd: 
  DICTFILTERTO ARG {
    /* filtered dictionary value */
    printf("set %s [dict filter", $2);
  }
  ARG {
    /* dictionaryValue */
    printf(" %s", $4);
  }
  ARG {
    /* type key or value */
    printf(" %s", $6);
  }
  ARG {
    /*  globPattern */
    printf(" %s", $8);
  }
  CLOSETAG {
    /* dictionary Script coming up */
    printf("]\n");
  }
;

/* ***** DICTWITH COMMAND ***** */

dictwith_cmd:
 dictwith_begin statements dictwith_end
 ;

dictwith_begin: 
  DICTWITHBEGIN ARG {
    /* a list containing: {keyVar valueVar} */
    printf("dict with %s", $2);
  }
  CLOSETAG {
    /* dictionary Script coming up */
    printf(" \{\n\t");
  }
;

dictwith_end:   
  DICTWITHEND {
    printf("\n}\n");
  }
;

/* ***** SCAN/SCAN-TO COMMAND ***** */

scan_cmd:
  SCAN ARG {printf("append __string [scan ", $2);} args CLOSETAG {printf("]\n");}
;

scanto_cmd:
  SCANTO ARG {printf("set %s [scan ", $2);} args CLOSETAG {printf("]\n");}
;

/* ***** STRING/STRINGTO COMMANDS ***** */
string_cmd:
  STRING ARG {printf("append __string [string %s", $2);} args CLOSETAG {printf("]\n");}
;

stringto_cmd:
  STRINGTO ARG {printf("set %s [string", $2);} args CLOSETAG {printf("]\n");}
;
/* ***** SPLIT/SPLIT-TO COMMANDS ***** */

split_cmd:
  SPLIT ARG {printf("append __string [split %s", $2);} args CLOSETAG {printf("]\n");}
;

splitto_cmd:
  SPLITTO ARG {printf("set %s [split", $2);} args CLOSETAG {printf("]\n");}
;

/* ***** ENCODING/ENCODING-TO COMMANDS ***** */

encoding_cmd:
  ENCODING ARG {printf("append __string [encoding %s", $2);} args CLOSETAG {printf("]\n");}
;

encodingto_cmd:
  ENCODINGTO ARG {printf("set %s [encoding", $2);} args CLOSETAG {printf("]\n");}
;

/* ***** CLOCK/CLOCK-TO COMMANDS ***** */

clock_cmd:
  CLOCK ARG {printf("append __string [clock %s", $2);} args CLOSETAG {printf("]\n");}
;

clockto_cmd:
  CLOCKTO ARG {printf("set %s [clock", $2);} args CLOSETAG {printf("]\n");}
;

/* ***** INFO/INFO-TO COMMANDS ***** */

info_cmd:
  INFO ARG {printf("append __string [info %s", $2);} args CLOSETAG {printf("]\n");}
;

infoto_cmd:
  INFOTO ARG {printf("set %s [info", $2);} args CLOSETAG {printf("]\n");}
;

/* ***** ARRAY/ARRAY-TO COMMANDS ***** */

array_cmd:
  ARRAY ARG {printf("append __string [array %s", $2);} args CLOSETAG {printf("]\n");}
;

arrayto_cmd:
  ARRAYTO ARG {printf("set %s [array", $2);} args CLOSETAG {printf("]\n");}
;

/* ***** CONCAT/CONCAT-TO COMMANDS ***** */

concat_cmd:
  CONCAT ARG {printf("append __string [concat %s", $2);} args CLOSETAG {printf("]\n");}
;

concatto_cmd:
  CONCATTO ARG {printf("set %s [concat", $2);} args CLOSETAG {printf("]\n");}
;

/* ***** JOIN/JOIN-TO COMMANDS ***** */

join_cmd:
  JOIN ARG {printf("append __string [join %s", $2);} args CLOSETAG {printf("]\n");}
;

jointo_cmd:
  JOINTO ARG {printf("set %s [join", $2);} args CLOSETAG {printf("]\n");}
;

/* ***** APPEND/APPEND-TO COMMANDS ***** */

append_cmd:
  APPEND ARG {printf("append __string [append %s", $2);} args CLOSETAG {printf("]\n");}
;

appendto_cmd:
  APPENDTO ARG {printf("set %s [append", $2);} args CLOSETAG {printf("]\n");}
;

/* ***** BINARY/BINARY-TO COMMANDS ***** */

binary_cmd:
  BINARY ARG {printf("append __string [binary %s", $2);} args CLOSETAG {printf("]\n");}
;

binaryto_cmd:
  BINARYTO ARG {printf("set %s [binary", $2);} args CLOSETAG {printf("]\n");}
;

/* ***** GLOB/GLOB-TO COMMANDS ***** */

glob_cmd:
  GLOB ARG {printf("append __string [glob -nocomplain %s", $2);} args CLOSETAG {printf("]\n");}
;

globto_cmd:
  GLOBTO ARG {printf("set %s [glob -nocomplain", $2);} args CLOSETAG {printf("]\n");}
;

/* ***** FILEX/FILEX-TO COMMANDS ***** */

file_cmd:
  FILEX ARG {printf("append __string [file %s", $2);} args CLOSETAG {printf("]\n");}
;

fileto_cmd:
  FILEXTO ARG {printf("set %s [file", $2);} args CLOSETAG {printf("]\n");}
;

/* ***** VARIABLE COMMAND ***** */

variable_cmd:
  VARIABLE ARG {printf("variable %s", $2);} args CLOSETAG {printf("\n");}
;

/* ***** COMMENT COMMAND ***** */

comment_cmd:
  COMMENT npargs CLOSETAG {/* do nothing */}
;

/* *** WHITESPACE COMMAND *** */

whitespace_cmd:
  WS npargs CLOSETAG {/* do nothing */}
;

/* ***** ARG & ARGS RULES ***** */

arg:
  ARG {printf(" %s", $1);}
;

args:
  /* empty */
  | arg args
  ;

/* ***** NON-PRINTING ARGS ***** */

nparg:
  ARG {/* do nothing here */}
  ;

npargs:
  /* empty */
  | nparg npargs
  ;

%%

  /* main is in myprog.c */
