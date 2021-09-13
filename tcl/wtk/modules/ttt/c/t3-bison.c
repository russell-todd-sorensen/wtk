/* A Bison parser, made by GNU Bison 3.7.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.7"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 1 "t3-bison.y"

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


#line 87 "y.tab.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Use api.header.include to #include this header
   instead of duplicating it here.  */
#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    ARG = 258,                     /* ARG  */
    QUOTEDSTRING = 259,            /* QUOTEDSTRING  */
    STRINGDATA = 260,              /* STRINGDATA  */
    VAR = 261,                     /* VAR  */
    VAR2 = 262,                    /* VAR2  */
    APPEND = 263,                  /* APPEND  */
    APPENDTO = 264,                /* APPENDTO  */
    ARRAY = 265,                   /* ARRAY  */
    ARRAYTO = 266,                 /* ARRAYTO  */
    BADTEXTINSWITCH = 267,         /* BADTEXTINSWITCH  */
    BADWSINARG = 268,              /* BADWSINARG  */
    BINARY = 269,                  /* BINARY  */
    BINARYTO = 270,                /* BINARYTO  */
    BREAK = 271,                   /* BREAK  */
    CASEBEGIN = 272,               /* CASEBEGIN  */
    CASEEND = 273,                 /* CASEEND  */
    CHAR = 274,                    /* CHAR  */
    CLOSETAG = 275,                /* CLOSETAG  */
    CLOCK = 276,                   /* CLOCK  */
    CLOCKTO = 277,                 /* CLOCKTO  */
    COMMENT = 278,                 /* COMMENT  */
    CONCAT = 279,                  /* CONCAT  */
    CONCATTO = 280,                /* CONCATTO  */
    CONTINUE = 281,                /* CONTINUE  */
    DEFAULTCASEBEGIN = 282,        /* DEFAULTCASEBEGIN  */
    DICT = 283,                    /* DICT  */
    DICTFILTER = 284,              /* DICTFILTER  */
    DICTFILTERTO = 285,            /* DICTFILTERTO  */
    DICTFORBEGIN = 286,            /* DICTFORBEGIN  */
    DICTFOREND = 287,              /* DICTFOREND  */
    DICTPRINT = 288,               /* DICTPRINT  */
    DICTTO = 289,                  /* DICTTO  */
    DICTWITHBEGIN = 290,           /* DICTWITHBEGIN  */
    DICTWITHEND = 291,             /* DICTWITHEND  */
    ENCODING = 292,                /* ENCODING  */
    ENCODINGTO = 293,              /* ENCODINGTO  */
    ELSE = 294,                    /* ELSE  */
    ELSEIF = 295,                  /* ELSEIF  */
    ELSEIFREG = 296,               /* ELSEIFREG  */
    EXPR = 297,                    /* EXPR  */
    EXPRTO = 298,                  /* EXPRTO  */
    FILEX = 299,                   /* FILEX  */
    FILEXTO = 300,                 /* FILEXTO  */
    FOREACHBEGIN = 301,            /* FOREACHBEGIN  */
    FOREACHENDCMD = 302,           /* FOREACHENDCMD  */
    FORMAT = 303,                  /* FORMAT  */
    FORMATTO = 304,                /* FORMATTO  */
    GET = 305,                     /* GET  */
    GLOB = 306,                    /* GLOB  */
    GLOBTO = 307,                  /* GLOBTO  */
    IFBEGIN = 308,                 /* IFBEGIN  */
    IFEND = 309,                   /* IFEND  */
    IFREG = 310,                   /* IFREG  */
    INCR = 311,                    /* INCR  */
    INCRN = 312,                   /* INCRN  */
    INFO = 313,                    /* INFO  */
    INFOTO = 314,                  /* INFOTO  */
    JOIN = 315,                    /* JOIN  */
    JOINTO = 316,                  /* JOINTO  */
    LAPPEND = 317,                 /* LAPPEND  */
    LASSIGN = 318,                 /* LASSIGN  */
    LASSIGNTO = 319,               /* LASSIGNTO  */
    LINSERTTO = 320,               /* LINSERTTO  */
    LINDEX = 321,                  /* LINDEX  */
    LINDEXTO = 322,                /* LINDEXTO  */
    LIST = 323,                    /* LIST  */
    LISTTO = 324,                  /* LISTTO  */
    LLENGTH = 325,                 /* LLENGTH  */
    LLENGTHTO = 326,               /* LLENGTHTO  */
    LRANGE = 327,                  /* LRANGE  */
    LRANGETO = 328,                /* LRANGETO  */
    LREPEAT = 329,                 /* LREPEAT  */
    LREPEATTO = 330,               /* LREPEATTO  */
    LREPLACE = 331,                /* LREPLACE  */
    LREPLACETO = 332,              /* LREPLACETO  */
    LREVERSE = 333,                /* LREVERSE  */
    LREVERSETO = 334,              /* LREVERSETO  */
    LSEARCH = 335,                 /* LSEARCH  */
    LSEARCHTO = 336,               /* LSEARCHTO  */
    LSET = 337,                    /* LSET  */
    LSORTTO = 338,                 /* LSORTTO  */
    NSBEGIN = 339,                 /* NSBEGIN  */
    NSEND = 340,                   /* NSEND  */
    NSEVALBEGIN = 341,             /* NSEVALBEGIN  */
    NSEVALEND = 342,               /* NSEVALEND  */
    PROCBEGIN = 343,               /* PROCBEGIN  */
    PROCEND = 344,                 /* PROCEND  */
    REGEXP = 345,                  /* REGEXP  */
    REGEXPTO = 346,                /* REGEXPTO  */
    REGSUB = 347,                  /* REGSUB  */
    REGSUBTO = 348,                /* REGSUBTO  */
    SCAN = 349,                    /* SCAN  */
    SCANTO = 350,                  /* SCANTO  */
    SPLIT = 351,                   /* SPLIT  */
    SPLITTO = 352,                 /* SPLITTO  */
    STRING = 353,                  /* STRING  */
    STRINGTO = 354,                /* STRINGTO  */
    SWITCHBEGIN = 355,             /* SWITCHBEGIN  */
    SWITCHEND = 356,               /* SWITCHEND  */
    SET = 357,                     /* SET  */
    UNSET = 358,                   /* UNSET  */
    VARIABLE = 359,                /* VARIABLE  */
    WHILEBEGIN = 360,              /* WHILEBEGIN  */
    WHILEEND = 361,                /* WHILEEND  */
    WS = 362,                      /* WS  */
    X = 363,                       /* X  */
    XRESOURCE = 364                /* XRESOURCE  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define ARG 258
#define QUOTEDSTRING 259
#define STRINGDATA 260
#define VAR 261
#define VAR2 262
#define APPEND 263
#define APPENDTO 264
#define ARRAY 265
#define ARRAYTO 266
#define BADTEXTINSWITCH 267
#define BADWSINARG 268
#define BINARY 269
#define BINARYTO 270
#define BREAK 271
#define CASEBEGIN 272
#define CASEEND 273
#define CHAR 274
#define CLOSETAG 275
#define CLOCK 276
#define CLOCKTO 277
#define COMMENT 278
#define CONCAT 279
#define CONCATTO 280
#define CONTINUE 281
#define DEFAULTCASEBEGIN 282
#define DICT 283
#define DICTFILTER 284
#define DICTFILTERTO 285
#define DICTFORBEGIN 286
#define DICTFOREND 287
#define DICTPRINT 288
#define DICTTO 289
#define DICTWITHBEGIN 290
#define DICTWITHEND 291
#define ENCODING 292
#define ENCODINGTO 293
#define ELSE 294
#define ELSEIF 295
#define ELSEIFREG 296
#define EXPR 297
#define EXPRTO 298
#define FILEX 299
#define FILEXTO 300
#define FOREACHBEGIN 301
#define FOREACHENDCMD 302
#define FORMAT 303
#define FORMATTO 304
#define GET 305
#define GLOB 306
#define GLOBTO 307
#define IFBEGIN 308
#define IFEND 309
#define IFREG 310
#define INCR 311
#define INCRN 312
#define INFO 313
#define INFOTO 314
#define JOIN 315
#define JOINTO 316
#define LAPPEND 317
#define LASSIGN 318
#define LASSIGNTO 319
#define LINSERTTO 320
#define LINDEX 321
#define LINDEXTO 322
#define LIST 323
#define LISTTO 324
#define LLENGTH 325
#define LLENGTHTO 326
#define LRANGE 327
#define LRANGETO 328
#define LREPEAT 329
#define LREPEATTO 330
#define LREPLACE 331
#define LREPLACETO 332
#define LREVERSE 333
#define LREVERSETO 334
#define LSEARCH 335
#define LSEARCHTO 336
#define LSET 337
#define LSORTTO 338
#define NSBEGIN 339
#define NSEND 340
#define NSEVALBEGIN 341
#define NSEVALEND 342
#define PROCBEGIN 343
#define PROCEND 344
#define REGEXP 345
#define REGEXPTO 346
#define REGSUB 347
#define REGSUBTO 348
#define SCAN 349
#define SCANTO 350
#define SPLIT 351
#define SPLITTO 352
#define STRING 353
#define STRINGTO 354
#define SWITCHBEGIN 355
#define SWITCHEND 356
#define SET 357
#define UNSET 358
#define VARIABLE 359
#define WHILEBEGIN 360
#define WHILEEND 361
#define WS 362
#define X 363
#define XRESOURCE 364

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 18 "t3-bison.y"

  char  *str;
  int   var;

#line 362 "y.tab.c"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
/* Symbol kind.  */
enum yysymbol_kind_t
{
  YYSYMBOL_YYEMPTY = -2,
  YYSYMBOL_YYEOF = 0,                      /* "end of file"  */
  YYSYMBOL_YYerror = 1,                    /* error  */
  YYSYMBOL_YYUNDEF = 2,                    /* "invalid token"  */
  YYSYMBOL_ARG = 3,                        /* ARG  */
  YYSYMBOL_QUOTEDSTRING = 4,               /* QUOTEDSTRING  */
  YYSYMBOL_STRINGDATA = 5,                 /* STRINGDATA  */
  YYSYMBOL_VAR = 6,                        /* VAR  */
  YYSYMBOL_VAR2 = 7,                       /* VAR2  */
  YYSYMBOL_APPEND = 8,                     /* APPEND  */
  YYSYMBOL_APPENDTO = 9,                   /* APPENDTO  */
  YYSYMBOL_ARRAY = 10,                     /* ARRAY  */
  YYSYMBOL_ARRAYTO = 11,                   /* ARRAYTO  */
  YYSYMBOL_BADTEXTINSWITCH = 12,           /* BADTEXTINSWITCH  */
  YYSYMBOL_BADWSINARG = 13,                /* BADWSINARG  */
  YYSYMBOL_BINARY = 14,                    /* BINARY  */
  YYSYMBOL_BINARYTO = 15,                  /* BINARYTO  */
  YYSYMBOL_BREAK = 16,                     /* BREAK  */
  YYSYMBOL_CASEBEGIN = 17,                 /* CASEBEGIN  */
  YYSYMBOL_CASEEND = 18,                   /* CASEEND  */
  YYSYMBOL_CHAR = 19,                      /* CHAR  */
  YYSYMBOL_CLOSETAG = 20,                  /* CLOSETAG  */
  YYSYMBOL_CLOCK = 21,                     /* CLOCK  */
  YYSYMBOL_CLOCKTO = 22,                   /* CLOCKTO  */
  YYSYMBOL_COMMENT = 23,                   /* COMMENT  */
  YYSYMBOL_CONCAT = 24,                    /* CONCAT  */
  YYSYMBOL_CONCATTO = 25,                  /* CONCATTO  */
  YYSYMBOL_CONTINUE = 26,                  /* CONTINUE  */
  YYSYMBOL_DEFAULTCASEBEGIN = 27,          /* DEFAULTCASEBEGIN  */
  YYSYMBOL_DICT = 28,                      /* DICT  */
  YYSYMBOL_DICTFILTER = 29,                /* DICTFILTER  */
  YYSYMBOL_DICTFILTERTO = 30,              /* DICTFILTERTO  */
  YYSYMBOL_DICTFORBEGIN = 31,              /* DICTFORBEGIN  */
  YYSYMBOL_DICTFOREND = 32,                /* DICTFOREND  */
  YYSYMBOL_DICTPRINT = 33,                 /* DICTPRINT  */
  YYSYMBOL_DICTTO = 34,                    /* DICTTO  */
  YYSYMBOL_DICTWITHBEGIN = 35,             /* DICTWITHBEGIN  */
  YYSYMBOL_DICTWITHEND = 36,               /* DICTWITHEND  */
  YYSYMBOL_ENCODING = 37,                  /* ENCODING  */
  YYSYMBOL_ENCODINGTO = 38,                /* ENCODINGTO  */
  YYSYMBOL_ELSE = 39,                      /* ELSE  */
  YYSYMBOL_ELSEIF = 40,                    /* ELSEIF  */
  YYSYMBOL_ELSEIFREG = 41,                 /* ELSEIFREG  */
  YYSYMBOL_EXPR = 42,                      /* EXPR  */
  YYSYMBOL_EXPRTO = 43,                    /* EXPRTO  */
  YYSYMBOL_FILEX = 44,                     /* FILEX  */
  YYSYMBOL_FILEXTO = 45,                   /* FILEXTO  */
  YYSYMBOL_FOREACHBEGIN = 46,              /* FOREACHBEGIN  */
  YYSYMBOL_FOREACHENDCMD = 47,             /* FOREACHENDCMD  */
  YYSYMBOL_FORMAT = 48,                    /* FORMAT  */
  YYSYMBOL_FORMATTO = 49,                  /* FORMATTO  */
  YYSYMBOL_GET = 50,                       /* GET  */
  YYSYMBOL_GLOB = 51,                      /* GLOB  */
  YYSYMBOL_GLOBTO = 52,                    /* GLOBTO  */
  YYSYMBOL_IFBEGIN = 53,                   /* IFBEGIN  */
  YYSYMBOL_IFEND = 54,                     /* IFEND  */
  YYSYMBOL_IFREG = 55,                     /* IFREG  */
  YYSYMBOL_INCR = 56,                      /* INCR  */
  YYSYMBOL_INCRN = 57,                     /* INCRN  */
  YYSYMBOL_INFO = 58,                      /* INFO  */
  YYSYMBOL_INFOTO = 59,                    /* INFOTO  */
  YYSYMBOL_JOIN = 60,                      /* JOIN  */
  YYSYMBOL_JOINTO = 61,                    /* JOINTO  */
  YYSYMBOL_LAPPEND = 62,                   /* LAPPEND  */
  YYSYMBOL_LASSIGN = 63,                   /* LASSIGN  */
  YYSYMBOL_LASSIGNTO = 64,                 /* LASSIGNTO  */
  YYSYMBOL_LINSERTTO = 65,                 /* LINSERTTO  */
  YYSYMBOL_LINDEX = 66,                    /* LINDEX  */
  YYSYMBOL_LINDEXTO = 67,                  /* LINDEXTO  */
  YYSYMBOL_LIST = 68,                      /* LIST  */
  YYSYMBOL_LISTTO = 69,                    /* LISTTO  */
  YYSYMBOL_LLENGTH = 70,                   /* LLENGTH  */
  YYSYMBOL_LLENGTHTO = 71,                 /* LLENGTHTO  */
  YYSYMBOL_LRANGE = 72,                    /* LRANGE  */
  YYSYMBOL_LRANGETO = 73,                  /* LRANGETO  */
  YYSYMBOL_LREPEAT = 74,                   /* LREPEAT  */
  YYSYMBOL_LREPEATTO = 75,                 /* LREPEATTO  */
  YYSYMBOL_LREPLACE = 76,                  /* LREPLACE  */
  YYSYMBOL_LREPLACETO = 77,                /* LREPLACETO  */
  YYSYMBOL_LREVERSE = 78,                  /* LREVERSE  */
  YYSYMBOL_LREVERSETO = 79,                /* LREVERSETO  */
  YYSYMBOL_LSEARCH = 80,                   /* LSEARCH  */
  YYSYMBOL_LSEARCHTO = 81,                 /* LSEARCHTO  */
  YYSYMBOL_LSET = 82,                      /* LSET  */
  YYSYMBOL_LSORTTO = 83,                   /* LSORTTO  */
  YYSYMBOL_NSBEGIN = 84,                   /* NSBEGIN  */
  YYSYMBOL_NSEND = 85,                     /* NSEND  */
  YYSYMBOL_NSEVALBEGIN = 86,               /* NSEVALBEGIN  */
  YYSYMBOL_NSEVALEND = 87,                 /* NSEVALEND  */
  YYSYMBOL_PROCBEGIN = 88,                 /* PROCBEGIN  */
  YYSYMBOL_PROCEND = 89,                   /* PROCEND  */
  YYSYMBOL_REGEXP = 90,                    /* REGEXP  */
  YYSYMBOL_REGEXPTO = 91,                  /* REGEXPTO  */
  YYSYMBOL_REGSUB = 92,                    /* REGSUB  */
  YYSYMBOL_REGSUBTO = 93,                  /* REGSUBTO  */
  YYSYMBOL_SCAN = 94,                      /* SCAN  */
  YYSYMBOL_SCANTO = 95,                    /* SCANTO  */
  YYSYMBOL_SPLIT = 96,                     /* SPLIT  */
  YYSYMBOL_SPLITTO = 97,                   /* SPLITTO  */
  YYSYMBOL_STRING = 98,                    /* STRING  */
  YYSYMBOL_STRINGTO = 99,                  /* STRINGTO  */
  YYSYMBOL_SWITCHBEGIN = 100,              /* SWITCHBEGIN  */
  YYSYMBOL_SWITCHEND = 101,                /* SWITCHEND  */
  YYSYMBOL_SET = 102,                      /* SET  */
  YYSYMBOL_UNSET = 103,                    /* UNSET  */
  YYSYMBOL_VARIABLE = 104,                 /* VARIABLE  */
  YYSYMBOL_WHILEBEGIN = 105,               /* WHILEBEGIN  */
  YYSYMBOL_WHILEEND = 106,                 /* WHILEEND  */
  YYSYMBOL_WS = 107,                       /* WS  */
  YYSYMBOL_X = 108,                        /* X  */
  YYSYMBOL_XRESOURCE = 109,                /* XRESOURCE  */
  YYSYMBOL_YYACCEPT = 110,                 /* $accept  */
  YYSYMBOL_statements = 111,               /* statements  */
  YYSYMBOL_statement = 112,                /* statement  */
  YYSYMBOL_stringdata = 113,               /* stringdata  */
  YYSYMBOL_quotedstring = 114,             /* quotedstring  */
  YYSYMBOL_unset_cmd = 115,                /* unset_cmd  */
  YYSYMBOL_unset_begin = 116,              /* unset_begin  */
  YYSYMBOL_unset_end = 117,                /* unset_end  */
  YYSYMBOL_switch_cmd = 118,               /* switch_cmd  */
  YYSYMBOL_switch_begin = 119,             /* switch_begin  */
  YYSYMBOL_switch_args = 120,              /* switch_args  */
  YYSYMBOL_switch_end = 121,               /* switch_end  */
  YYSYMBOL_case_cmd = 122,                 /* case_cmd  */
  YYSYMBOL_case_begin = 123,               /* case_begin  */
  YYSYMBOL_case_args = 124,                /* case_args  */
  YYSYMBOL_case_end = 125,                 /* case_end  */
  YYSYMBOL_default_begin = 126,            /* default_begin  */
  YYSYMBOL_case_cmds = 127,                /* case_cmds  */
  YYSYMBOL_while_cmd = 128,                /* while_cmd  */
  YYSYMBOL_while_begin = 129,              /* while_begin  */
  YYSYMBOL_while_end = 130,                /* while_end  */
  YYSYMBOL_proc_cmd = 131,                 /* proc_cmd  */
  YYSYMBOL_proc_begin = 132,               /* proc_begin  */
  YYSYMBOL_133_1 = 133,                    /* $@1  */
  YYSYMBOL_134_2 = 134,                    /* $@2  */
  YYSYMBOL_proc_end = 135,                 /* proc_end  */
  YYSYMBOL_nseval_cmd = 136,               /* nseval_cmd  */
  YYSYMBOL_nseval_begin = 137,             /* nseval_begin  */
  YYSYMBOL_138_3 = 138,                    /* $@3  */
  YYSYMBOL_nseval_end = 139,               /* nseval_end  */
  YYSYMBOL_ns_cmd = 140,                   /* ns_cmd  */
  YYSYMBOL_ns_begin = 141,                 /* ns_begin  */
  YYSYMBOL_ns_arg = 142,                   /* ns_arg  */
  YYSYMBOL_ns_end = 143,                   /* ns_end  */
  YYSYMBOL_break_cmd = 144,                /* break_cmd  */
  YYSYMBOL_continue_cmd = 145,             /* continue_cmd  */
  YYSYMBOL_expr_cmd = 146,                 /* expr_cmd  */
  YYSYMBOL_147_4 = 147,                    /* $@4  */
  YYSYMBOL_exprto_cmd = 148,               /* exprto_cmd  */
  YYSYMBOL_149_5 = 149,                    /* $@5  */
  YYSYMBOL_foreach_cmd = 150,              /* foreach_cmd  */
  YYSYMBOL_foreach_begin = 151,            /* foreach_begin  */
  YYSYMBOL_152_6 = 152,                    /* $@6  */
  YYSYMBOL_foreach_end = 153,              /* foreach_end  */
  YYSYMBOL_foreach_endcmd = 154,           /* foreach_endcmd  */
  YYSYMBOL_format_cmd = 155,               /* format_cmd  */
  YYSYMBOL_156_7 = 156,                    /* $@7  */
  YYSYMBOL_formatto_cmd = 157,             /* formatto_cmd  */
  YYSYMBOL_158_8 = 158,                    /* $@8  */
  YYSYMBOL_extension_resource_cmd = 159,   /* extension_resource_cmd  */
  YYSYMBOL_160_9 = 160,                    /* $@9  */
  YYSYMBOL_regexp_cmd = 161,               /* regexp_cmd  */
  YYSYMBOL_162_10 = 162,                   /* $@10  */
  YYSYMBOL_regexpto_cmd = 163,             /* regexpto_cmd  */
  YYSYMBOL_164_11 = 164,                   /* $@11  */
  YYSYMBOL_regsub_cmd = 165,               /* regsub_cmd  */
  YYSYMBOL_166_12 = 166,                   /* $@12  */
  YYSYMBOL_regsubto_cmd = 167,             /* regsubto_cmd  */
  YYSYMBOL_168_13 = 168,                   /* $@13  */
  YYSYMBOL_ifreg_cmd = 169,                /* ifreg_cmd  */
  YYSYMBOL_ifreg_begin = 170,              /* ifreg_begin  */
  YYSYMBOL_171_14 = 171,                   /* $@14  */
  YYSYMBOL_var = 172,                      /* var  */
  YYSYMBOL_if_cmd = 173,                   /* if_cmd  */
  YYSYMBOL_if_begin = 174,                 /* if_begin  */
  YYSYMBOL_if_end = 175,                   /* if_end  */
  YYSYMBOL_else_cmd = 176,                 /* else_cmd  */
  YYSYMBOL_else_begin = 177,               /* else_begin  */
  YYSYMBOL_else_end = 178,                 /* else_end  */
  YYSYMBOL_elseif_cmd = 179,               /* elseif_cmd  */
  YYSYMBOL_elseif_begin = 180,             /* elseif_begin  */
  YYSYMBOL_181_15 = 181,                   /* $@15  */
  YYSYMBOL_182_16 = 182,                   /* $@16  */
  YYSYMBOL_elseif_end = 183,               /* elseif_end  */
  YYSYMBOL_set_cmd = 184,                  /* set_cmd  */
  YYSYMBOL_185_17 = 185,                   /* $@17  */
  YYSYMBOL_186_18 = 186,                   /* $@18  */
  YYSYMBOL_get_cmd = 187,                  /* get_cmd  */
  YYSYMBOL_188_19 = 188,                   /* $@19  */
  YYSYMBOL_incr_cmd = 189,                 /* incr_cmd  */
  YYSYMBOL_190_20 = 190,                   /* $@20  */
  YYSYMBOL_incrn_cmd = 191,                /* incrn_cmd  */
  YYSYMBOL_192_21 = 192,                   /* $@21  */
  YYSYMBOL_193_22 = 193,                   /* $@22  */
  YYSYMBOL_lappend_cmd = 194,              /* lappend_cmd  */
  YYSYMBOL_lappend_begin = 195,            /* lappend_begin  */
  YYSYMBOL_196_23 = 196,                   /* $@23  */
  YYSYMBOL_lappend_end = 197,              /* lappend_end  */
  YYSYMBOL_lassign_cmd = 198,              /* lassign_cmd  */
  YYSYMBOL_199_24 = 199,                   /* $@24  */
  YYSYMBOL_lassignto_cmd = 200,            /* lassignto_cmd  */
  YYSYMBOL_201_25 = 201,                   /* $@25  */
  YYSYMBOL_lsortto_cmd = 202,              /* lsortto_cmd  */
  YYSYMBOL_203_26 = 203,                   /* $@26  */
  YYSYMBOL_lindex_cmd = 204,               /* lindex_cmd  */
  YYSYMBOL_205_27 = 205,                   /* $@27  */
  YYSYMBOL_lindexto_cmd = 206,             /* lindexto_cmd  */
  YYSYMBOL_207_28 = 207,                   /* $@28  */
  YYSYMBOL_linsertto_cmd = 208,            /* linsertto_cmd  */
  YYSYMBOL_209_29 = 209,                   /* $@29  */
  YYSYMBOL_list_cmd = 210,                 /* list_cmd  */
  YYSYMBOL_211_30 = 211,                   /* $@30  */
  YYSYMBOL_listto_cmd = 212,               /* listto_cmd  */
  YYSYMBOL_213_31 = 213,                   /* $@31  */
  YYSYMBOL_llength_cmd = 214,              /* llength_cmd  */
  YYSYMBOL_215_32 = 215,                   /* $@32  */
  YYSYMBOL_llengthto_cmd = 216,            /* llengthto_cmd  */
  YYSYMBOL_217_33 = 217,                   /* $@33  */
  YYSYMBOL_lrange_cmd = 218,               /* lrange_cmd  */
  YYSYMBOL_219_34 = 219,                   /* $@34  */
  YYSYMBOL_lrangeto_cmd = 220,             /* lrangeto_cmd  */
  YYSYMBOL_221_35 = 221,                   /* $@35  */
  YYSYMBOL_lrepeat_cmd = 222,              /* lrepeat_cmd  */
  YYSYMBOL_223_36 = 223,                   /* $@36  */
  YYSYMBOL_lrepeatto_cmd = 224,            /* lrepeatto_cmd  */
  YYSYMBOL_225_37 = 225,                   /* $@37  */
  YYSYMBOL_lreplace_cmd = 226,             /* lreplace_cmd  */
  YYSYMBOL_227_38 = 227,                   /* $@38  */
  YYSYMBOL_lreplaceto_cmd = 228,           /* lreplaceto_cmd  */
  YYSYMBOL_229_39 = 229,                   /* $@39  */
  YYSYMBOL_lreverse_cmd = 230,             /* lreverse_cmd  */
  YYSYMBOL_231_40 = 231,                   /* $@40  */
  YYSYMBOL_lreverseto_cmd = 232,           /* lreverseto_cmd  */
  YYSYMBOL_233_41 = 233,                   /* $@41  */
  YYSYMBOL_lsearch_cmd = 234,              /* lsearch_cmd  */
  YYSYMBOL_235_42 = 235,                   /* $@42  */
  YYSYMBOL_lsearchto_cmd = 236,            /* lsearchto_cmd  */
  YYSYMBOL_237_43 = 237,                   /* $@43  */
  YYSYMBOL_lset_cmd = 238,                 /* lset_cmd  */
  YYSYMBOL_239_44 = 239,                   /* $@44  */
  YYSYMBOL_dict_cmd = 240,                 /* dict_cmd  */
  YYSYMBOL_241_45 = 241,                   /* $@45  */
  YYSYMBOL_dictprint_cmd = 242,            /* dictprint_cmd  */
  YYSYMBOL_243_46 = 243,                   /* $@46  */
  YYSYMBOL_dictto_cmd = 244,               /* dictto_cmd  */
  YYSYMBOL_245_47 = 245,                   /* $@47  */
  YYSYMBOL_dictfor_cmd = 246,              /* dictfor_cmd  */
  YYSYMBOL_dictfor_begin = 247,            /* dictfor_begin  */
  YYSYMBOL_248_48 = 248,                   /* $@48  */
  YYSYMBOL_249_49 = 249,                   /* $@49  */
  YYSYMBOL_dictfor_end = 250,              /* dictfor_end  */
  YYSYMBOL_dictfilter_cmd = 251,           /* dictfilter_cmd  */
  YYSYMBOL_252_50 = 252,                   /* $@50  */
  YYSYMBOL_253_51 = 253,                   /* $@51  */
  YYSYMBOL_254_52 = 254,                   /* $@52  */
  YYSYMBOL_dictfilterto_cmd = 255,         /* dictfilterto_cmd  */
  YYSYMBOL_256_53 = 256,                   /* $@53  */
  YYSYMBOL_257_54 = 257,                   /* $@54  */
  YYSYMBOL_258_55 = 258,                   /* $@55  */
  YYSYMBOL_259_56 = 259,                   /* $@56  */
  YYSYMBOL_dictwith_cmd = 260,             /* dictwith_cmd  */
  YYSYMBOL_dictwith_begin = 261,           /* dictwith_begin  */
  YYSYMBOL_262_57 = 262,                   /* $@57  */
  YYSYMBOL_dictwith_end = 263,             /* dictwith_end  */
  YYSYMBOL_scan_cmd = 264,                 /* scan_cmd  */
  YYSYMBOL_265_58 = 265,                   /* $@58  */
  YYSYMBOL_scanto_cmd = 266,               /* scanto_cmd  */
  YYSYMBOL_267_59 = 267,                   /* $@59  */
  YYSYMBOL_string_cmd = 268,               /* string_cmd  */
  YYSYMBOL_269_60 = 269,                   /* $@60  */
  YYSYMBOL_stringto_cmd = 270,             /* stringto_cmd  */
  YYSYMBOL_271_61 = 271,                   /* $@61  */
  YYSYMBOL_split_cmd = 272,                /* split_cmd  */
  YYSYMBOL_273_62 = 273,                   /* $@62  */
  YYSYMBOL_splitto_cmd = 274,              /* splitto_cmd  */
  YYSYMBOL_275_63 = 275,                   /* $@63  */
  YYSYMBOL_encoding_cmd = 276,             /* encoding_cmd  */
  YYSYMBOL_277_64 = 277,                   /* $@64  */
  YYSYMBOL_encodingto_cmd = 278,           /* encodingto_cmd  */
  YYSYMBOL_279_65 = 279,                   /* $@65  */
  YYSYMBOL_clock_cmd = 280,                /* clock_cmd  */
  YYSYMBOL_281_66 = 281,                   /* $@66  */
  YYSYMBOL_clockto_cmd = 282,              /* clockto_cmd  */
  YYSYMBOL_283_67 = 283,                   /* $@67  */
  YYSYMBOL_info_cmd = 284,                 /* info_cmd  */
  YYSYMBOL_285_68 = 285,                   /* $@68  */
  YYSYMBOL_infoto_cmd = 286,               /* infoto_cmd  */
  YYSYMBOL_287_69 = 287,                   /* $@69  */
  YYSYMBOL_array_cmd = 288,                /* array_cmd  */
  YYSYMBOL_289_70 = 289,                   /* $@70  */
  YYSYMBOL_arrayto_cmd = 290,              /* arrayto_cmd  */
  YYSYMBOL_291_71 = 291,                   /* $@71  */
  YYSYMBOL_concat_cmd = 292,               /* concat_cmd  */
  YYSYMBOL_293_72 = 293,                   /* $@72  */
  YYSYMBOL_concatto_cmd = 294,             /* concatto_cmd  */
  YYSYMBOL_295_73 = 295,                   /* $@73  */
  YYSYMBOL_join_cmd = 296,                 /* join_cmd  */
  YYSYMBOL_297_74 = 297,                   /* $@74  */
  YYSYMBOL_jointo_cmd = 298,               /* jointo_cmd  */
  YYSYMBOL_299_75 = 299,                   /* $@75  */
  YYSYMBOL_append_cmd = 300,               /* append_cmd  */
  YYSYMBOL_301_76 = 301,                   /* $@76  */
  YYSYMBOL_appendto_cmd = 302,             /* appendto_cmd  */
  YYSYMBOL_303_77 = 303,                   /* $@77  */
  YYSYMBOL_binary_cmd = 304,               /* binary_cmd  */
  YYSYMBOL_305_78 = 305,                   /* $@78  */
  YYSYMBOL_binaryto_cmd = 306,             /* binaryto_cmd  */
  YYSYMBOL_307_79 = 307,                   /* $@79  */
  YYSYMBOL_glob_cmd = 308,                 /* glob_cmd  */
  YYSYMBOL_309_80 = 309,                   /* $@80  */
  YYSYMBOL_globto_cmd = 310,               /* globto_cmd  */
  YYSYMBOL_311_81 = 311,                   /* $@81  */
  YYSYMBOL_file_cmd = 312,                 /* file_cmd  */
  YYSYMBOL_313_82 = 313,                   /* $@82  */
  YYSYMBOL_fileto_cmd = 314,               /* fileto_cmd  */
  YYSYMBOL_315_83 = 315,                   /* $@83  */
  YYSYMBOL_variable_cmd = 316,             /* variable_cmd  */
  YYSYMBOL_317_84 = 317,                   /* $@84  */
  YYSYMBOL_comment_cmd = 318,              /* comment_cmd  */
  YYSYMBOL_whitespace_cmd = 319,           /* whitespace_cmd  */
  YYSYMBOL_arg = 320,                      /* arg  */
  YYSYMBOL_args = 321,                     /* args  */
  YYSYMBOL_nparg = 322,                    /* nparg  */
  YYSYMBOL_npargs = 323                    /* npargs  */
};
typedef enum yysymbol_kind_t yysymbol_kind_t;




#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))


/* Stored state numbers (used for stacks). */
typedef yytype_int16 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif


#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && ! defined __ICC && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                            \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if !defined yyoverflow

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* !defined yyoverflow */

#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  267
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   465

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  110
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  214
/* YYNRULES -- Number of rules.  */
#define YYNRULES  308
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  580

/* YYMAXUTOK -- Last valid token kind.  */
#define YYMAXUTOK   364


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK                     \
   ? YY_CAST (yysymbol_kind_t, yytranslate[YYX])        \
   : YYSYMBOL_YYUNDEF)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51,    52,    53,    54,
      55,    56,    57,    58,    59,    60,    61,    62,    63,    64,
      65,    66,    67,    68,    69,    70,    71,    72,    73,    74,
      75,    76,    77,    78,    79,    80,    81,    82,    83,    84,
      85,    86,    87,    88,    89,    90,    91,    92,    93,    94,
      95,    96,    97,    98,    99,   100,   101,   102,   103,   104,
     105,   106,   107,   108,   109
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,   134,   134,   136,   140,   141,   142,   143,   144,   145,
     146,   147,   148,   149,   150,   151,   152,   153,   154,   155,
     156,   157,   158,   159,   160,   161,   162,   163,   164,   165,
     166,   167,   168,   169,   170,   171,   172,   173,   174,   175,
     176,   177,   178,   179,   180,   181,   182,   183,   184,   185,
     186,   187,   188,   189,   190,   191,   192,   193,   194,   195,
     196,   197,   198,   199,   200,   201,   202,   203,   204,   205,
     206,   207,   208,   209,   210,   211,   212,   213,   214,   215,
     216,   217,   218,   219,   220,   221,   222,   223,   224,   230,
     234,   239,   243,   249,   255,   260,   264,   267,   271,   273,
     277,   281,   285,   289,   292,   294,   300,   304,   308,   314,
     318,   323,   318,   332,   340,   344,   344,   353,   361,   365,
     371,   377,   386,   390,   396,   396,   400,   400,   406,   410,
     410,   414,   418,   424,   424,   428,   428,   434,   434,   445,
     445,   449,   449,   453,   453,   457,   457,   461,   465,   465,
     471,   477,   481,   485,   486,   487,   491,   495,   499,   503,
     507,   507,   509,   509,   513,   514,   515,   521,   521,   521,
     525,   525,   531,   531,   535,   535,   535,   541,   545,   545,
     549,   555,   555,   559,   559,   563,   563,   567,   567,   571,
     571,   575,   575,   579,   579,   583,   583,   587,   587,   591,
     591,   595,   595,   599,   599,   603,   603,   607,   607,   611,
     611,   615,   615,   619,   619,   623,   623,   626,   626,   630,
     630,   634,   634,   642,   642,   646,   646,   650,   650,   656,
     660,   664,   660,   675,   684,   688,   692,   684,   706,   710,
     714,   718,   706,   731,   735,   735,   746,   754,   754,   758,
     758,   763,   763,   767,   767,   772,   772,   776,   776,   782,
     782,   786,   786,   792,   792,   796,   796,   802,   802,   806,
     806,   812,   812,   816,   816,   822,   822,   826,   826,   832,
     832,   836,   836,   842,   842,   846,   846,   852,   852,   856,
     856,   862,   862,   866,   866,   872,   872,   876,   876,   882,
     882,   888,   894,   900,   903,   905,   911,   914,   916
};
#endif

/** Accessing symbol of state STATE.  */
#define YY_ACCESSING_SYMBOL(State) YY_CAST (yysymbol_kind_t, yystos[State])

#if YYDEBUG || 0
/* The user-facing name of the symbol whose (internal) number is
   YYSYMBOL.  No bounds checking.  */
static const char *yysymbol_name (yysymbol_kind_t yysymbol) YY_ATTRIBUTE_UNUSED;

/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "\"end of file\"", "error", "\"invalid token\"", "ARG", "QUOTEDSTRING",
  "STRINGDATA", "VAR", "VAR2", "APPEND", "APPENDTO", "ARRAY", "ARRAYTO",
  "BADTEXTINSWITCH", "BADWSINARG", "BINARY", "BINARYTO", "BREAK",
  "CASEBEGIN", "CASEEND", "CHAR", "CLOSETAG", "CLOCK", "CLOCKTO",
  "COMMENT", "CONCAT", "CONCATTO", "CONTINUE", "DEFAULTCASEBEGIN", "DICT",
  "DICTFILTER", "DICTFILTERTO", "DICTFORBEGIN", "DICTFOREND", "DICTPRINT",
  "DICTTO", "DICTWITHBEGIN", "DICTWITHEND", "ENCODING", "ENCODINGTO",
  "ELSE", "ELSEIF", "ELSEIFREG", "EXPR", "EXPRTO", "FILEX", "FILEXTO",
  "FOREACHBEGIN", "FOREACHENDCMD", "FORMAT", "FORMATTO", "GET", "GLOB",
  "GLOBTO", "IFBEGIN", "IFEND", "IFREG", "INCR", "INCRN", "INFO", "INFOTO",
  "JOIN", "JOINTO", "LAPPEND", "LASSIGN", "LASSIGNTO", "LINSERTTO",
  "LINDEX", "LINDEXTO", "LIST", "LISTTO", "LLENGTH", "LLENGTHTO", "LRANGE",
  "LRANGETO", "LREPEAT", "LREPEATTO", "LREPLACE", "LREPLACETO", "LREVERSE",
  "LREVERSETO", "LSEARCH", "LSEARCHTO", "LSET", "LSORTTO", "NSBEGIN",
  "NSEND", "NSEVALBEGIN", "NSEVALEND", "PROCBEGIN", "PROCEND", "REGEXP",
  "REGEXPTO", "REGSUB", "REGSUBTO", "SCAN", "SCANTO", "SPLIT", "SPLITTO",
  "STRING", "STRINGTO", "SWITCHBEGIN", "SWITCHEND", "SET", "UNSET",
  "VARIABLE", "WHILEBEGIN", "WHILEEND", "WS", "X", "XRESOURCE", "$accept",
  "statements", "statement", "stringdata", "quotedstring", "unset_cmd",
  "unset_begin", "unset_end", "switch_cmd", "switch_begin", "switch_args",
  "switch_end", "case_cmd", "case_begin", "case_args", "case_end",
  "default_begin", "case_cmds", "while_cmd", "while_begin", "while_end",
  "proc_cmd", "proc_begin", "$@1", "$@2", "proc_end", "nseval_cmd",
  "nseval_begin", "$@3", "nseval_end", "ns_cmd", "ns_begin", "ns_arg",
  "ns_end", "break_cmd", "continue_cmd", "expr_cmd", "$@4", "exprto_cmd",
  "$@5", "foreach_cmd", "foreach_begin", "$@6", "foreach_end",
  "foreach_endcmd", "format_cmd", "$@7", "formatto_cmd", "$@8",
  "extension_resource_cmd", "$@9", "regexp_cmd", "$@10", "regexpto_cmd",
  "$@11", "regsub_cmd", "$@12", "regsubto_cmd", "$@13", "ifreg_cmd",
  "ifreg_begin", "$@14", "var", "if_cmd", "if_begin", "if_end", "else_cmd",
  "else_begin", "else_end", "elseif_cmd", "elseif_begin", "$@15", "$@16",
  "elseif_end", "set_cmd", "$@17", "$@18", "get_cmd", "$@19", "incr_cmd",
  "$@20", "incrn_cmd", "$@21", "$@22", "lappend_cmd", "lappend_begin",
  "$@23", "lappend_end", "lassign_cmd", "$@24", "lassignto_cmd", "$@25",
  "lsortto_cmd", "$@26", "lindex_cmd", "$@27", "lindexto_cmd", "$@28",
  "linsertto_cmd", "$@29", "list_cmd", "$@30", "listto_cmd", "$@31",
  "llength_cmd", "$@32", "llengthto_cmd", "$@33", "lrange_cmd", "$@34",
  "lrangeto_cmd", "$@35", "lrepeat_cmd", "$@36", "lrepeatto_cmd", "$@37",
  "lreplace_cmd", "$@38", "lreplaceto_cmd", "$@39", "lreverse_cmd", "$@40",
  "lreverseto_cmd", "$@41", "lsearch_cmd", "$@42", "lsearchto_cmd", "$@43",
  "lset_cmd", "$@44", "dict_cmd", "$@45", "dictprint_cmd", "$@46",
  "dictto_cmd", "$@47", "dictfor_cmd", "dictfor_begin", "$@48", "$@49",
  "dictfor_end", "dictfilter_cmd", "$@50", "$@51", "$@52",
  "dictfilterto_cmd", "$@53", "$@54", "$@55", "$@56", "dictwith_cmd",
  "dictwith_begin", "$@57", "dictwith_end", "scan_cmd", "$@58",
  "scanto_cmd", "$@59", "string_cmd", "$@60", "stringto_cmd", "$@61",
  "split_cmd", "$@62", "splitto_cmd", "$@63", "encoding_cmd", "$@64",
  "encodingto_cmd", "$@65", "clock_cmd", "$@66", "clockto_cmd", "$@67",
  "info_cmd", "$@68", "infoto_cmd", "$@69", "array_cmd", "$@70",
  "arrayto_cmd", "$@71", "concat_cmd", "$@72", "concatto_cmd", "$@73",
  "join_cmd", "$@74", "jointo_cmd", "$@75", "append_cmd", "$@76",
  "appendto_cmd", "$@77", "binary_cmd", "$@78", "binaryto_cmd", "$@79",
  "glob_cmd", "$@80", "globto_cmd", "$@81", "file_cmd", "$@82",
  "fileto_cmd", "$@83", "variable_cmd", "$@84", "comment_cmd",
  "whitespace_cmd", "arg", "args", "nparg", "npargs", YY_NULLPTR
};

static const char *
yysymbol_name (yysymbol_kind_t yysymbol)
{
  return yytname[yysymbol];
}
#endif

#ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_int16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304,
     305,   306,   307,   308,   309,   310,   311,   312,   313,   314,
     315,   316,   317,   318,   319,   320,   321,   322,   323,   324,
     325,   326,   327,   328,   329,   330,   331,   332,   333,   334,
     335,   336,   337,   338,   339,   340,   341,   342,   343,   344,
     345,   346,   347,   348,   349,   350,   351,   352,   353,   354,
     355,   356,   357,   358,   359,   360,   361,   362,   363,   364
};
#endif

#define YYPACT_NINF (-279)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-1)

#define yytable_value_is_error(Yyn) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
      70,  -279,  -279,  -279,     6,     8,    10,    11,    12,    16,
    -279,    18,    19,    20,    21,    22,  -279,    23,    24,    25,
      27,    28,    29,    30,    32,    33,    34,    35,    36,    37,
      38,    39,    40,    41,    42,    43,    44,    45,    46,    47,
      48,    49,    50,    51,    52,    53,    54,    55,    56,    57,
      58,    59,    60,    62,    63,    64,    66,    67,    68,    69,
      74,    79,    80,    84,    85,    86,    87,    94,    99,   103,
     106,   107,   114,   121,   152,   154,   156,   168,   173,   175,
     177,   178,   180,   181,    20,   182,    73,    70,  -279,  -279,
    -279,   166,  -279,   184,  -279,   169,  -279,    70,  -279,    70,
    -279,   187,  -279,  -279,  -279,  -279,  -279,   184,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,    70,  -279,  -279,   171,
    -279,  -279,  -279,  -279,  -279,   184,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,    70,  -279,  -279,  -279,    70,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,    20,   172,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,   174,  -279,  -279,  -279,  -279,
    -279,  -279,    -9,   184,   185,    70,   104,   108,  -279,   186,
     190,  -279,   -37,    70,   191,  -279,   183,   176,   184,   184,
     184,   184,   184,   184,   184,   184,  -279,  -279,   184,   184,
     184,   219,   222,   226,   184,   184,   210,   184,   184,   184,
     184,   184,   184,   232,   184,   184,   237,   184,   184,   184,
     238,   266,   184,   184,   184,   184,   268,   184,   184,   184,
     184,   184,   184,   184,   184,   184,   184,   184,   184,   184,
     184,   184,   184,   184,   184,   184,   184,   184,   253,   271,
     184,   184,   184,   184,   184,   184,   184,   184,   184,   184,
     272,   184,  -279,   184,   274,  -279,    -9,   184,    70,   179,
    -279,  -279,   188,  -279,  -279,  -279,  -279,  -279,  -279,    70,
    -279,   275,   276,  -279,  -279,  -279,    70,  -279,    70,   -37,
    -279,  -279,  -279,  -279,  -279,   262,   263,   264,   265,   267,
     269,   270,   273,   277,   278,   280,  -279,  -279,  -279,   282,
     283,  -279,   284,   285,   286,   287,   288,   289,  -279,   290,
     291,  -279,   292,   293,   294,  -279,  -279,   295,   296,   297,
     298,  -279,   299,   300,   301,   302,   303,   304,   305,   306,
     307,   308,   309,   310,   311,   312,   313,   314,   315,   316,
     317,   318,   319,  -279,  -279,   320,   321,   322,   323,   324,
     325,   326,   327,   328,   329,  -279,   330,   331,  -279,  -279,
     332,  -279,   335,  -279,  -279,  -279,  -279,   239,  -279,  -279,
     234,   -34,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,   351,   352,   336,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
     337,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,   338,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,   339,  -279,  -279,
      70,  -279,  -279,  -279,  -279,   340,   184,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,   335,
    -279,   341,   342,   360,  -279,  -279,  -279,  -279,   344,  -279
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_int16 yydefact[] =
{
       2,    90,    89,   150,     0,     0,     0,     0,     0,     0,
     122,     0,     0,   307,     0,     0,   123,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,   307,     0,     0,     2,    81,    70,
      84,     0,    83,   304,    87,     0,    69,     2,    67,     2,
      68,     0,    10,    16,    26,    27,    31,   304,    32,    33,
      28,    71,    72,    73,    74,    38,     2,    85,    37,     0,
      77,    34,    39,    40,    45,   304,    46,    47,    66,    48,
      49,    50,    51,    52,    53,    54,    55,    56,    57,    58,
      59,    60,    61,    62,    63,    64,    65,    17,    21,    22,
      20,     2,    18,    19,    23,     2,    75,    76,    80,    82,
      78,    79,    24,    25,    11,    12,    41,    42,     6,     7,
      14,    15,    43,    44,     4,     5,     8,     9,    35,    36,
      29,    30,    86,    13,    88,   283,   285,   271,   273,   287,
     289,   263,   265,   306,   307,     0,   275,   277,   223,   234,
     238,   230,   225,   227,   244,   259,   261,   124,   126,   295,
     297,   129,   133,   135,   170,   291,   293,   152,   148,   172,
     174,   267,   269,   279,   281,   178,   181,   183,   191,   187,
     189,   193,   195,   197,   199,   201,   203,   205,   207,   209,
     211,   213,   215,   217,   219,   221,   185,   119,   115,   110,
     139,   141,   143,   145,   247,   249,   255,   257,   251,   253,
      95,   167,    92,   299,   107,     0,   137,     1,     3,    93,
      91,   303,   104,   304,     0,     2,     0,     0,   120,     0,
       0,   131,     0,     2,     0,   180,     0,     0,   304,   304,
     304,   304,   304,   304,   304,   304,   308,   301,   304,   304,
     304,     0,     0,     0,   304,   304,     0,   304,   304,   304,
     304,   304,   304,     0,   304,   304,     0,   304,   304,   304,
       0,     0,   304,   304,   304,   304,     0,   304,   304,   304,
     304,   304,   304,   304,   304,   304,   304,   304,   304,   304,
     304,   304,   304,   304,   304,   304,   304,   304,     0,     0,
     304,   304,   304,   304,   304,   304,   304,   304,   304,   304,
       0,   304,   302,   304,     0,   103,   104,   304,     2,     0,
     305,    96,     0,   113,   109,   117,   114,   121,   118,     2,
     157,     0,     0,   153,   147,   154,     2,   155,     2,     0,
     177,   233,   229,   246,   243,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,   235,   239,   231,     0,
       0,   245,     0,     0,     0,     0,     0,     0,   130,     0,
       0,   171,     0,     0,     0,   173,   175,     0,     0,     0,
       0,   179,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,   116,   111,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,   168,     0,     0,   100,   105,
       0,   101,     0,    97,    94,   108,   106,     0,   160,   162,
       0,     0,   151,   284,   286,   272,   274,   288,   290,   264,
     266,   276,   278,   224,     0,     0,     0,   226,   228,   260,
     262,   125,   127,   296,   298,   134,   136,   292,   294,   149,
       0,   268,   270,   280,   282,   182,   184,   192,   188,   190,
     194,   196,   198,   200,   202,   204,   206,   208,   210,   212,
     214,   216,   218,   220,   222,   186,     0,   140,   142,   144,
     146,   248,   250,   256,   258,   252,   254,     0,   300,   138,
       2,   102,    99,   132,   128,     0,   304,   158,   156,   164,
     166,   165,   159,   236,   240,   232,   176,   112,   169,     0,
     161,     0,     0,     0,    98,   163,   237,   241,     0,   242
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -279,   -87,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -278,  -279,   -71,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,   -93,  -116,  -279,  -279,  -115,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,  -279,
    -279,   -91,  -279,   -83
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,    86,    87,    88,    89,    90,    91,   270,    92,    93,
     272,   474,   366,   367,   470,   552,   368,   369,    94,    95,
     476,    96,    97,   349,   536,   374,    98,    99,   348,   376,
     100,   101,   279,   378,   102,   103,   104,   309,   105,   310,
     106,   107,   313,   280,   554,   108,   314,   109,   315,   110,
     363,   111,   350,   112,   351,   113,   352,   114,   353,   115,
     116,   319,   117,   118,   119,   384,   385,   386,   558,   387,
     388,   555,   556,   562,   120,   360,   547,   121,   316,   122,
     320,   123,   321,   510,   124,   125,   326,   284,   126,   327,
     127,   328,   128,   347,   129,   330,   130,   331,   131,   329,
     132,   332,   133,   333,   134,   334,   135,   335,   136,   336,
     137,   337,   138,   338,   139,   339,   140,   340,   141,   341,
     142,   342,   143,   343,   144,   344,   145,   345,   146,   346,
     147,   300,   148,   304,   149,   305,   150,   151,   303,   496,
     392,   152,   301,   494,   572,   153,   302,   495,   573,   578,
     154,   155,   306,   394,   156,   354,   157,   355,   158,   358,
     159,   359,   160,   356,   161,   357,   162,   307,   163,   308,
     164,   294,   165,   295,   166,   322,   167,   323,   168,   290,
     169,   291,   170,   298,   171,   299,   172,   324,   173,   325,
     174,   288,   175,   289,   176,   292,   177,   293,   178,   317,
     179,   318,   180,   311,   181,   312,   182,   361,   183,   184,
     273,   274,   194,   195
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
     268,   265,   380,   381,   382,   380,   381,   382,   364,   185,
     276,   186,   277,   187,   188,   189,   281,   383,   365,   190,
     559,   191,   192,   193,   196,   197,   198,   199,   200,   282,
     201,   202,   203,   204,   285,   205,   206,   207,   208,   209,
     210,   211,   212,   213,   214,   215,   216,   217,   218,   219,
     220,   221,   222,   223,   224,   225,   226,   227,   228,   229,
     230,   231,   232,   233,   286,   234,   235,   236,   287,   237,
     238,   239,   240,   267,     1,     2,     3,   241,     4,     5,
       6,     7,   242,   243,     8,     9,    10,   244,   245,   246,
     247,    11,    12,    13,    14,    15,    16,   248,    17,    18,
      19,    20,   249,    21,    22,    23,   250,    24,    25,   251,
     252,   296,    26,    27,    28,    29,    30,   253,    31,    32,
      33,    34,    35,    36,   254,    37,    38,    39,    40,    41,
      42,    43,    44,    45,    46,    47,    48,    49,    50,    51,
      52,    53,    54,    55,    56,    57,    58,    59,    60,    61,
      62,    63,    64,    65,    66,   255,    67,   256,    68,   257,
      69,    70,    71,    72,    73,    74,    75,    76,    77,    78,
      79,   258,    80,    81,    82,    83,   259,    84,   260,    85,
     261,   262,   370,   263,   264,   266,   269,   271,   372,   275,
     278,   283,   297,   373,   362,   375,   389,   395,   396,   397,
     398,   399,   400,   401,   402,   371,   377,   403,   404,   405,
     379,   390,   393,   409,   410,   391,   412,   413,   414,   415,
     416,   417,   406,   419,   420,   407,   422,   423,   424,   408,
     411,   427,   428,   429,   430,   418,   432,   433,   434,   435,
     436,   437,   438,   439,   440,   441,   442,   443,   444,   445,
     446,   447,   448,   449,   450,   451,   452,   421,   425,   455,
     456,   457,   458,   459,   460,   461,   462,   463,   464,   426,
     466,   431,   467,   453,   454,   465,   471,   468,   478,   479,
     473,   472,   483,   484,   485,   486,   553,   487,   557,   488,
     489,   574,   477,   490,   475,   469,   482,   491,   492,   480,
     493,   481,   497,   498,   499,   500,   501,   502,   503,   504,
     505,   506,   507,   508,   509,   511,   512,   513,   514,   515,
     516,   517,   518,   519,   520,   521,   522,   523,   524,   525,
     526,   527,   528,   529,   530,   531,   532,   533,   534,   535,
     537,   538,   539,   540,   541,   542,   543,   544,   545,   546,
     548,   549,   550,   551,   563,   564,   565,   566,   567,   568,
     570,   575,   576,   577,   579,   560,   561,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,   569,     0,   571
};

static const yytype_int16 yycheck[] =
{
      87,    84,    39,    40,    41,    39,    40,    41,    17,     3,
      97,     3,    99,     3,     3,     3,   107,    54,    27,     3,
      54,     3,     3,     3,     3,     3,     3,     3,     3,   116,
       3,     3,     3,     3,   125,     3,     3,     3,     3,     3,
       3,     3,     3,     3,     3,     3,     3,     3,     3,     3,
       3,     3,     3,     3,     3,     3,     3,     3,     3,     3,
       3,     3,     3,     3,   151,     3,     3,     3,   155,     3,
       3,     3,     3,     0,     4,     5,     6,     3,     8,     9,
      10,    11,     3,     3,    14,    15,    16,     3,     3,     3,
       3,    21,    22,    23,    24,    25,    26,     3,    28,    29,
      30,    31,     3,    33,    34,    35,     3,    37,    38,     3,
       3,   194,    42,    43,    44,    45,    46,     3,    48,    49,
      50,    51,    52,    53,     3,    55,    56,    57,    58,    59,
      60,    61,    62,    63,    64,    65,    66,    67,    68,    69,
      70,    71,    72,    73,    74,    75,    76,    77,    78,    79,
      80,    81,    82,    83,    84,     3,    86,     3,    88,     3,
      90,    91,    92,    93,    94,    95,    96,    97,    98,    99,
     100,     3,   102,   103,   104,   105,     3,   107,     3,   109,
       3,     3,   273,     3,     3,     3,    20,     3,   275,    20,
       3,    20,    20,    89,    20,    87,   283,   288,   289,   290,
     291,   292,   293,   294,   295,    20,    20,   298,   299,   300,
      20,    20,    36,   304,   305,    32,   307,   308,   309,   310,
     311,   312,     3,   314,   315,     3,   317,   318,   319,     3,
      20,   322,   323,   324,   325,     3,   327,   328,   329,   330,
     331,   332,   333,   334,   335,   336,   337,   338,   339,   340,
     341,   342,   343,   344,   345,   346,   347,    20,    20,   350,
     351,   352,   353,   354,   355,   356,   357,   358,   359,     3,
     361,     3,   363,    20,     3,     3,   367,     3,     3,     3,
     101,   368,    20,    20,    20,    20,    47,    20,    54,    20,
      20,   569,   379,    20,   106,   366,   389,    20,    20,   386,
      20,   388,    20,    20,    20,    20,    20,    20,    20,    20,
      20,    20,    20,    20,    20,    20,    20,    20,    20,    20,
      20,    20,    20,    20,    20,    20,    20,    20,    20,    20,
      20,    20,    20,    20,    20,    20,    20,    20,    20,    20,
      20,    20,    20,    20,    20,    20,    20,    20,    20,    20,
      20,    20,    20,    18,     3,     3,    20,    20,    20,    20,
      20,    20,    20,     3,    20,   481,   481,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,   550,    -1,   556
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_int16 yystos[] =
{
       0,     4,     5,     6,     8,     9,    10,    11,    14,    15,
      16,    21,    22,    23,    24,    25,    26,    28,    29,    30,
      31,    33,    34,    35,    37,    38,    42,    43,    44,    45,
      46,    48,    49,    50,    51,    52,    53,    55,    56,    57,
      58,    59,    60,    61,    62,    63,    64,    65,    66,    67,
      68,    69,    70,    71,    72,    73,    74,    75,    76,    77,
      78,    79,    80,    81,    82,    83,    84,    86,    88,    90,
      91,    92,    93,    94,    95,    96,    97,    98,    99,   100,
     102,   103,   104,   105,   107,   109,   111,   112,   113,   114,
     115,   116,   118,   119,   128,   129,   131,   132,   136,   137,
     140,   141,   144,   145,   146,   148,   150,   151,   155,   157,
     159,   161,   163,   165,   167,   169,   170,   172,   173,   174,
     184,   187,   189,   191,   194,   195,   198,   200,   202,   204,
     206,   208,   210,   212,   214,   216,   218,   220,   222,   224,
     226,   228,   230,   232,   234,   236,   238,   240,   242,   244,
     246,   247,   251,   255,   260,   261,   264,   266,   268,   270,
     272,   274,   276,   278,   280,   282,   284,   286,   288,   290,
     292,   294,   296,   298,   300,   302,   304,   306,   308,   310,
     312,   314,   316,   318,   319,     3,     3,     3,     3,     3,
       3,     3,     3,     3,   322,   323,     3,     3,     3,     3,
       3,     3,     3,     3,     3,     3,     3,     3,     3,     3,
       3,     3,     3,     3,     3,     3,     3,     3,     3,     3,
       3,     3,     3,     3,     3,     3,     3,     3,     3,     3,
       3,     3,     3,     3,     3,     3,     3,     3,     3,     3,
       3,     3,     3,     3,     3,     3,     3,     3,     3,     3,
       3,     3,     3,     3,     3,     3,     3,     3,     3,     3,
       3,     3,     3,     3,     3,   323,     3,     0,   111,    20,
     117,     3,   120,   320,   321,    20,   111,   111,     3,   142,
     153,   321,   111,    20,   197,   321,   111,   111,   301,   303,
     289,   291,   305,   307,   281,   283,   323,    20,   293,   295,
     241,   252,   256,   248,   243,   245,   262,   277,   279,   147,
     149,   313,   315,   152,   156,   158,   188,   309,   311,   171,
     190,   192,   285,   287,   297,   299,   196,   199,   201,   209,
     205,   207,   211,   213,   215,   217,   219,   221,   223,   225,
     227,   229,   231,   233,   235,   237,   239,   203,   138,   133,
     162,   164,   166,   168,   265,   267,   273,   275,   269,   271,
     185,   317,    20,   160,    17,    27,   122,   123,   126,   127,
     321,    20,   111,    89,   135,    87,   139,    20,   143,    20,
      39,    40,    41,    54,   175,   176,   177,   179,   180,   111,
      20,    32,   250,    36,   263,   321,   321,   321,   321,   321,
     321,   321,   321,   321,   321,   321,     3,     3,     3,   321,
     321,    20,   321,   321,   321,   321,   321,   321,     3,   321,
     321,    20,   321,   321,   321,    20,     3,   321,   321,   321,
     321,     3,   321,   321,   321,   321,   321,   321,   321,   321,
     321,   321,   321,   321,   321,   321,   321,   321,   321,   321,
     321,   321,   321,    20,     3,   321,   321,   321,   321,   321,
     321,   321,   321,   321,   321,     3,   321,   321,     3,   127,
     124,   321,   111,   101,   121,   106,   130,   111,     3,     3,
     111,   111,   175,    20,    20,    20,    20,    20,    20,    20,
      20,    20,    20,    20,   253,   257,   249,    20,    20,    20,
      20,    20,    20,    20,    20,    20,    20,    20,    20,    20,
     193,    20,    20,    20,    20,    20,    20,    20,    20,    20,
      20,    20,    20,    20,    20,    20,    20,    20,    20,    20,
      20,    20,    20,    20,    20,    20,   134,    20,    20,    20,
      20,    20,    20,    20,    20,    20,    20,   186,    20,    20,
      20,    18,   125,    47,   154,   181,   182,    54,   178,    54,
     176,   179,   183,     3,     3,    20,    20,    20,    20,   111,
      20,   321,   254,   258,   125,    20,    20,     3,   259,    20
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_int16 yyr1[] =
{
       0,   110,   111,   111,   112,   112,   112,   112,   112,   112,
     112,   112,   112,   112,   112,   112,   112,   112,   112,   112,
     112,   112,   112,   112,   112,   112,   112,   112,   112,   112,
     112,   112,   112,   112,   112,   112,   112,   112,   112,   112,
     112,   112,   112,   112,   112,   112,   112,   112,   112,   112,
     112,   112,   112,   112,   112,   112,   112,   112,   112,   112,
     112,   112,   112,   112,   112,   112,   112,   112,   112,   112,
     112,   112,   112,   112,   112,   112,   112,   112,   112,   112,
     112,   112,   112,   112,   112,   112,   112,   112,   112,   113,
     114,   115,   116,   117,   118,   119,   120,   121,   122,   122,
     123,   124,   125,   126,   127,   127,   128,   129,   130,   131,
     133,   134,   132,   135,   136,   138,   137,   139,   140,   141,
     142,   143,   144,   145,   147,   146,   149,   148,   150,   152,
     151,   153,   154,   156,   155,   158,   157,   160,   159,   162,
     161,   164,   163,   166,   165,   168,   167,   169,   171,   170,
     172,   173,   174,   175,   175,   175,   176,   177,   178,   179,
     181,   180,   182,   180,   183,   183,   183,   185,   186,   184,
     188,   187,   190,   189,   192,   193,   191,   194,   196,   195,
     197,   199,   198,   201,   200,   203,   202,   205,   204,   207,
     206,   209,   208,   211,   210,   213,   212,   215,   214,   217,
     216,   219,   218,   221,   220,   223,   222,   225,   224,   227,
     226,   229,   228,   231,   230,   233,   232,   235,   234,   237,
     236,   239,   238,   241,   240,   243,   242,   245,   244,   246,
     248,   249,   247,   250,   252,   253,   254,   251,   256,   257,
     258,   259,   255,   260,   262,   261,   263,   265,   264,   267,
     266,   269,   268,   271,   270,   273,   272,   275,   274,   277,
     276,   279,   278,   281,   280,   283,   282,   285,   284,   287,
     286,   289,   288,   291,   290,   293,   292,   295,   294,   297,
     296,   299,   298,   301,   300,   303,   302,   305,   304,   307,
     306,   309,   308,   311,   310,   313,   312,   315,   314,   317,
     316,   318,   319,   320,   321,   321,   322,   323,   323
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     0,     2,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     2,     2,     1,     4,     2,     2,     1,     5,     3,
       2,     1,     1,     1,     0,     2,     4,     2,     1,     3,
       0,     0,     6,     1,     3,     0,     4,     1,     3,     2,
       1,     1,     1,     1,     0,     5,     0,     5,     5,     0,
       4,     1,     1,     0,     5,     0,     5,     0,     5,     0,
       5,     0,     5,     0,     5,     0,     5,     3,     0,     5,
       1,     4,     2,     1,     1,     1,     3,     1,     1,     3,
       0,     4,     0,     5,     1,     1,     1,     0,     0,     6,
       0,     4,     0,     4,     0,     0,     6,     3,     0,     4,
       1,     0,     5,     0,     5,     0,     5,     0,     5,     0,
       5,     0,     5,     0,     5,     0,     5,     0,     5,     0,
       5,     0,     5,     0,     5,     0,     5,     0,     5,     0,
       5,     0,     5,     0,     5,     0,     5,     0,     5,     0,
       5,     0,     5,     0,     5,     0,     5,     0,     5,     3,
       0,     0,     6,     1,     0,     0,     0,     8,     0,     0,
       0,     0,    10,     3,     0,     4,     1,     0,     5,     0,
       5,     0,     5,     0,     5,     0,     5,     0,     5,     0,
       5,     0,     5,     0,     5,     0,     5,     0,     5,     0,
       5,     0,     5,     0,     5,     0,     5,     0,     5,     0,
       5,     0,     5,     0,     5,     0,     5,     0,     5,     0,
       5,     0,     5,     0,     5,     0,     5,     0,     5,     0,
       5,     3,     3,     1,     0,     2,     1,     0,     2
};


enum { YYENOMEM = -2 };

#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Backward compatibility with an undocumented macro.
   Use YYerror or YYUNDEF. */
#define YYERRCODE YYUNDEF


/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
# ifndef YY_LOCATION_PRINT
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif


# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Kind, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo,
                       yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YYUSE (yyoutput);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yykind < YYNTOKENS)
    YYPRINT (yyo, yytoknum[yykind], *yyvaluep);
# endif
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo,
                 yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yykind < YYNTOKENS ? "token" : "nterm", yysymbol_name (yykind));

  yy_symbol_value_print (yyo, yykind, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp,
                 int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       YY_ACCESSING_SYMBOL (+yyssp[yyi + 1 - yynrhs]),
                       &yyvsp[(yyi + 1) - (yynrhs)]);
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args) ((void) 0)
# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif






/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg,
            yysymbol_kind_t yykind, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yykind, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/* Lookahead token kind.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;




/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate = 0;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus = 0;

    /* Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* Their size.  */
    YYPTRDIFF_T yystacksize = YYINITDEPTH;

    /* The state stack: array, bottom, top.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss = yyssa;
    yy_state_t *yyssp = yyss;

    /* The semantic value stack: array, bottom, top.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs = yyvsa;
    YYSTYPE *yyvsp = yyvs;

  int yyn;
  /* The return value of yyparse.  */
  int yyresult;
  /* Lookahead symbol kind.  */
  yysymbol_kind_t yytoken = YYSYMBOL_YYEMPTY;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END
  YY_STACK_PRINT (yyss, yyssp);

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    goto yyexhaustedlab;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either empty, or end-of-input, or a valid lookahead.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token\n"));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = YYEOF;
      yytoken = YYSYMBOL_YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else if (yychar == YYerror)
    {
      /* The scanner already issued an error message, process directly
         to error recovery.  But do not keep the error token as
         lookahead, it is too special and may lead us to an endless
         loop in error recovery. */
      yychar = YYUNDEF;
      yytoken = YYSYMBOL_YYerror;
      goto yyerrlab1;
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 89: /* stringdata: STRINGDATA  */
#line 230 "t3-bison.y"
             {printf("append __string \"%s\"\n", (yyvsp[0].str));}
#line 2112 "y.tab.c"
    break;

  case 90: /* quotedstring: QUOTEDSTRING  */
#line 234 "t3-bison.y"
               {printf("append __string \{%s}\n", (yyvsp[0].str));}
#line 2118 "y.tab.c"
    break;

  case 92: /* unset_begin: UNSET ARG  */
#line 243 "t3-bison.y"
            {
    printf("unset '%s'\n", (yyvsp[0].str));
  }
#line 2126 "y.tab.c"
    break;

  case 95: /* switch_begin: SWITCHBEGIN ARG  */
#line 260 "t3-bison.y"
                  {printf("switch %s", (yyvsp[0].str));}
#line 2132 "y.tab.c"
    break;

  case 96: /* switch_args: args CLOSETAG  */
#line 264 "t3-bison.y"
                {printf(" \{\n");}
#line 2138 "y.tab.c"
    break;

  case 97: /* switch_end: SWITCHEND  */
#line 267 "t3-bison.y"
             {printf("}\n");}
#line 2144 "y.tab.c"
    break;

  case 100: /* case_begin: CASEBEGIN ARG  */
#line 277 "t3-bison.y"
                {printf("   %s", (yyvsp[0].str));}
#line 2150 "y.tab.c"
    break;

  case 101: /* case_args: args  */
#line 281 "t3-bison.y"
       {printf(" \{\n   ");}
#line 2156 "y.tab.c"
    break;

  case 102: /* case_end: CASEEND  */
#line 285 "t3-bison.y"
          {printf("   }\n");}
#line 2162 "y.tab.c"
    break;

  case 103: /* default_begin: DEFAULTCASEBEGIN  */
#line 289 "t3-bison.y"
                   {printf("   default \{\n   ");}
#line 2168 "y.tab.c"
    break;

  case 107: /* while_begin: WHILEBEGIN ARG  */
#line 304 "t3-bison.y"
                 {printf("\nwhile %s \{\n", (yyvsp[0].str));}
#line 2174 "y.tab.c"
    break;

  case 108: /* while_end: WHILEEND  */
#line 308 "t3-bison.y"
           {printf("\n}\n");}
#line 2180 "y.tab.c"
    break;

  case 110: /* $@1: %empty  */
#line 318 "t3-bison.y"
                {
    printf("if \{[llength [info procs ::t3::%s]] == 0} \{\n\t", (yyvsp[0].str));
    /* printf("namespace eval ::t3 \{}\n\t"); */
    printf("proc ::t3::%s", (yyvsp[0].str));
  }
#line 2190 "y.tab.c"
    break;

  case 111: /* $@2: %empty  */
#line 323 "t3-bison.y"
      {
    printf(" %s", (yyvsp[0].str));
  }
#line 2198 "y.tab.c"
    break;

  case 112: /* proc_begin: PROCBEGIN ARG $@1 ARG $@2 CLOSETAG  */
#line 326 "t3-bison.y"
           {
    printf(" \{\n");
  }
#line 2206 "y.tab.c"
    break;

  case 113: /* proc_end: PROCEND  */
#line 332 "t3-bison.y"
          {
    printf("\n\t\treturn $__string\n\t}\n}\n");
  }
#line 2214 "y.tab.c"
    break;

  case 115: /* $@3: %empty  */
#line 344 "t3-bison.y"
                  {
    printf("namespace eval ::t3::%s", (yyvsp[0].str));
  }
#line 2222 "y.tab.c"
    break;

  case 116: /* nseval_begin: NSEVALBEGIN ARG $@3 CLOSETAG  */
#line 347 "t3-bison.y"
           {
    printf(" \{\n");
  }
#line 2230 "y.tab.c"
    break;

  case 117: /* nseval_end: NSEVALEND  */
#line 353 "t3-bison.y"
            {
    printf("\n}\n");
  }
#line 2238 "y.tab.c"
    break;

  case 119: /* ns_begin: NSBEGIN ARG  */
#line 365 "t3-bison.y"
              {
    printf("append __string [namespace %s", (yyvsp[0].str));
  }
#line 2246 "y.tab.c"
    break;

  case 120: /* ns_arg: ARG  */
#line 371 "t3-bison.y"
      {
    printf(" %s", (yyvsp[0].str));
  }
#line 2254 "y.tab.c"
    break;

  case 121: /* ns_end: CLOSETAG  */
#line 377 "t3-bison.y"
           {
    printf("]\n");
 }
#line 2262 "y.tab.c"
    break;

  case 122: /* break_cmd: BREAK  */
#line 386 "t3-bison.y"
        {printf("break\n");}
#line 2268 "y.tab.c"
    break;

  case 123: /* continue_cmd: CONTINUE  */
#line 390 "t3-bison.y"
           {printf("continue\n");}
#line 2274 "y.tab.c"
    break;

  case 124: /* $@4: %empty  */
#line 396 "t3-bison.y"
           {printf("append __string [expr %s", (yyvsp[0].str));}
#line 2280 "y.tab.c"
    break;

  case 125: /* expr_cmd: EXPR ARG $@4 args CLOSETAG  */
#line 396 "t3-bison.y"
                                                                   {printf("]\n");}
#line 2286 "y.tab.c"
    break;

  case 126: /* $@5: %empty  */
#line 400 "t3-bison.y"
             {printf("set %s [expr", (yyvsp[0].str));}
#line 2292 "y.tab.c"
    break;

  case 127: /* exprto_cmd: EXPRTO ARG $@5 args CLOSETAG  */
#line 400 "t3-bison.y"
                                                         {printf("]\n");}
#line 2298 "y.tab.c"
    break;

  case 129: /* $@6: %empty  */
#line 410 "t3-bison.y"
                   {printf("foreach %s", (yyvsp[0].str));}
#line 2304 "y.tab.c"
    break;

  case 130: /* foreach_begin: FOREACHBEGIN ARG $@6 ARG  */
#line 410 "t3-bison.y"
                                                   {printf(" %s", (yyvsp[0].str));}
#line 2310 "y.tab.c"
    break;

  case 131: /* foreach_end: args  */
#line 414 "t3-bison.y"
       {printf(" \{\n");}
#line 2316 "y.tab.c"
    break;

  case 132: /* foreach_endcmd: FOREACHENDCMD  */
#line 418 "t3-bison.y"
                {printf("}\n");}
#line 2322 "y.tab.c"
    break;

  case 133: /* $@7: %empty  */
#line 424 "t3-bison.y"
             {printf("append __string [format %s", (yyvsp[0].str));}
#line 2328 "y.tab.c"
    break;

  case 134: /* format_cmd: FORMAT ARG $@7 args CLOSETAG  */
#line 424 "t3-bison.y"
                                                                       {printf("]\n");}
#line 2334 "y.tab.c"
    break;

  case 135: /* $@8: %empty  */
#line 428 "t3-bison.y"
               {printf("set %s [format", (yyvsp[0].str));}
#line 2340 "y.tab.c"
    break;

  case 136: /* formatto_cmd: FORMATTO ARG $@8 args CLOSETAG  */
#line 428 "t3-bison.y"
                                                             {printf("]\n");}
#line 2346 "y.tab.c"
    break;

  case 137: /* $@9: %empty  */
#line 434 "t3-bison.y"
                {
     printf("if {[::ext::resource::exists %s]} {\next::resource::eval %s", (yyvsp[0].str), (yyvsp[0].str));
   }
#line 2354 "y.tab.c"
    break;

  case 138: /* extension_resource_cmd: XRESOURCE ARG $@9 args CLOSETAG  */
#line 437 "t3-bison.y"
                 {
     printf("\n}\n");
   }
#line 2362 "y.tab.c"
    break;

  case 139: /* $@10: %empty  */
#line 445 "t3-bison.y"
             {printf("regexp %s", (yyvsp[0].str));}
#line 2368 "y.tab.c"
    break;

  case 140: /* regexp_cmd: REGEXP ARG $@10 args CLOSETAG  */
#line 445 "t3-bison.y"
                                                      {printf("\n");}
#line 2374 "y.tab.c"
    break;

  case 141: /* $@11: %empty  */
#line 449 "t3-bison.y"
               {printf("set %s [regexp ", (yyvsp[0].str));}
#line 2380 "y.tab.c"
    break;

  case 142: /* regexpto_cmd: REGEXPTO ARG $@11 args CLOSETAG  */
#line 449 "t3-bison.y"
                                                              {printf("]\n");}
#line 2386 "y.tab.c"
    break;

  case 143: /* $@12: %empty  */
#line 453 "t3-bison.y"
             {printf("append __string [regsub %s", (yyvsp[0].str));}
#line 2392 "y.tab.c"
    break;

  case 144: /* regsub_cmd: REGSUB ARG $@12 args CLOSETAG  */
#line 453 "t3-bison.y"
                                                                       {printf("]\n");}
#line 2398 "y.tab.c"
    break;

  case 145: /* $@13: %empty  */
#line 457 "t3-bison.y"
               {printf("set %s [regsub", (yyvsp[0].str));}
#line 2404 "y.tab.c"
    break;

  case 146: /* regsubto_cmd: REGSUBTO ARG $@13 args CLOSETAG  */
#line 457 "t3-bison.y"
                                                             {printf("]\n");}
#line 2410 "y.tab.c"
    break;

  case 148: /* $@14: %empty  */
#line 465 "t3-bison.y"
            {printf("if {[regexp %s ", (yyvsp[0].str));}
#line 2416 "y.tab.c"
    break;

  case 149: /* ifreg_begin: IFREG ARG $@14 args CLOSETAG  */
#line 465 "t3-bison.y"
                                                           {printf("]} {\n");}
#line 2422 "y.tab.c"
    break;

  case 150: /* var: VAR  */
#line 471 "t3-bison.y"
      {printf("\nappend __string %s\n", (yyvsp[0].str));}
#line 2428 "y.tab.c"
    break;

  case 152: /* if_begin: IFBEGIN ARG  */
#line 481 "t3-bison.y"
              {printf("if %s {\n", (yyvsp[0].str));}
#line 2434 "y.tab.c"
    break;

  case 153: /* if_end: IFEND  */
#line 485 "t3-bison.y"
        {printf("}\n");}
#line 2440 "y.tab.c"
    break;

  case 157: /* else_begin: ELSE  */
#line 495 "t3-bison.y"
       {printf(" } else {\n");}
#line 2446 "y.tab.c"
    break;

  case 158: /* else_end: IFEND  */
#line 499 "t3-bison.y"
        {printf("}\n");}
#line 2452 "y.tab.c"
    break;

  case 160: /* $@15: %empty  */
#line 507 "t3-bison.y"
             {printf("\n} elseif %s {\n", (yyvsp[0].str));}
#line 2458 "y.tab.c"
    break;

  case 162: /* $@16: %empty  */
#line 509 "t3-bison.y"
                {printf("\n} elseif {[regexp %s ", (yyvsp[0].str));}
#line 2464 "y.tab.c"
    break;

  case 163: /* elseif_begin: ELSEIFREG ARG $@16 args CLOSETAG  */
#line 509 "t3-bison.y"
                                                                       {printf("]} {\n");}
#line 2470 "y.tab.c"
    break;

  case 164: /* elseif_end: IFEND  */
#line 513 "t3-bison.y"
        {printf("}\n");}
#line 2476 "y.tab.c"
    break;

  case 167: /* $@17: %empty  */
#line 521 "t3-bison.y"
          {printf("set %s", (yyvsp[0].str));}
#line 2482 "y.tab.c"
    break;

  case 168: /* $@18: %empty  */
#line 521 "t3-bison.y"
                                      {printf(" %s\n", (yyvsp[0].str));}
#line 2488 "y.tab.c"
    break;

  case 170: /* $@19: %empty  */
#line 525 "t3-bison.y"
          {printf("append __string [set %s]\n", (yyvsp[0].str));}
#line 2494 "y.tab.c"
    break;

  case 172: /* $@20: %empty  */
#line 531 "t3-bison.y"
           {printf("incr %s 1\n", (yyvsp[0].str));}
#line 2500 "y.tab.c"
    break;

  case 174: /* $@21: %empty  */
#line 535 "t3-bison.y"
            {printf("incr %s", (yyvsp[0].str));}
#line 2506 "y.tab.c"
    break;

  case 175: /* $@22: %empty  */
#line 535 "t3-bison.y"
                                         {printf(" %s\n", (yyvsp[0].str));}
#line 2512 "y.tab.c"
    break;

  case 177: /* lappend_cmd: lappend_begin lappend_end CLOSETAG  */
#line 541 "t3-bison.y"
                                     {printf("\n");}
#line 2518 "y.tab.c"
    break;

  case 178: /* $@23: %empty  */
#line 545 "t3-bison.y"
              {printf("lappend %s", (yyvsp[0].str));}
#line 2524 "y.tab.c"
    break;

  case 179: /* lappend_begin: LAPPEND ARG $@23 ARG  */
#line 545 "t3-bison.y"
                                              {printf(" %s", (yyvsp[0].str));}
#line 2530 "y.tab.c"
    break;

  case 181: /* $@24: %empty  */
#line 555 "t3-bison.y"
              {printf("lassign %s", (yyvsp[0].str));}
#line 2536 "y.tab.c"
    break;

  case 182: /* lassign_cmd: LASSIGN ARG $@24 args CLOSETAG  */
#line 555 "t3-bison.y"
                                                        {printf("\n");}
#line 2542 "y.tab.c"
    break;

  case 183: /* $@25: %empty  */
#line 559 "t3-bison.y"
                {printf("set %s [lassign", (yyvsp[0].str));}
#line 2548 "y.tab.c"
    break;

  case 184: /* lassignto_cmd: LASSIGNTO ARG $@25 args CLOSETAG  */
#line 559 "t3-bison.y"
                                                               {printf("]\n");}
#line 2554 "y.tab.c"
    break;

  case 185: /* $@26: %empty  */
#line 563 "t3-bison.y"
              {printf("set %s [lsort", (yyvsp[0].str));}
#line 2560 "y.tab.c"
    break;

  case 186: /* lsortto_cmd: LSORTTO ARG $@26 args CLOSETAG  */
#line 563 "t3-bison.y"
                                                           {printf("]\n");}
#line 2566 "y.tab.c"
    break;

  case 187: /* $@27: %empty  */
#line 567 "t3-bison.y"
             {printf("append __string [lindex %s", (yyvsp[0].str));}
#line 2572 "y.tab.c"
    break;

  case 188: /* lindex_cmd: LINDEX ARG $@27 args CLOSETAG  */
#line 567 "t3-bison.y"
                                                                       {printf("]\n");}
#line 2578 "y.tab.c"
    break;

  case 189: /* $@28: %empty  */
#line 571 "t3-bison.y"
               {printf("set %s [lindex", (yyvsp[0].str));}
#line 2584 "y.tab.c"
    break;

  case 190: /* lindexto_cmd: LINDEXTO ARG $@28 args CLOSETAG  */
#line 571 "t3-bison.y"
                                                             {printf("]\n");}
#line 2590 "y.tab.c"
    break;

  case 191: /* $@29: %empty  */
#line 575 "t3-bison.y"
                {printf("set %s [linsert", (yyvsp[0].str));}
#line 2596 "y.tab.c"
    break;

  case 192: /* linsertto_cmd: LINSERTTO ARG $@29 args CLOSETAG  */
#line 575 "t3-bison.y"
                                                               {printf("]\n");}
#line 2602 "y.tab.c"
    break;

  case 193: /* $@30: %empty  */
#line 579 "t3-bison.y"
           {printf("append __string [list %s", (yyvsp[0].str));}
#line 2608 "y.tab.c"
    break;

  case 194: /* list_cmd: LIST ARG $@30 args CLOSETAG  */
#line 579 "t3-bison.y"
                                                                   {printf("]\n");}
#line 2614 "y.tab.c"
    break;

  case 195: /* $@31: %empty  */
#line 583 "t3-bison.y"
             {printf("set %s [list", (yyvsp[0].str));}
#line 2620 "y.tab.c"
    break;

  case 196: /* listto_cmd: LISTTO ARG $@31 args CLOSETAG  */
#line 583 "t3-bison.y"
                                                         {printf("]\n");}
#line 2626 "y.tab.c"
    break;

  case 197: /* $@32: %empty  */
#line 587 "t3-bison.y"
              {printf("append __string [llength %s", (yyvsp[0].str));}
#line 2632 "y.tab.c"
    break;

  case 198: /* llength_cmd: LLENGTH ARG $@32 args CLOSETAG  */
#line 587 "t3-bison.y"
                                                                         {printf("]\n");}
#line 2638 "y.tab.c"
    break;

  case 199: /* $@33: %empty  */
#line 591 "t3-bison.y"
                {printf("set %s [llength", (yyvsp[0].str));}
#line 2644 "y.tab.c"
    break;

  case 200: /* llengthto_cmd: LLENGTHTO ARG $@33 args CLOSETAG  */
#line 591 "t3-bison.y"
                                                               {printf("]\n");}
#line 2650 "y.tab.c"
    break;

  case 201: /* $@34: %empty  */
#line 595 "t3-bison.y"
             {printf("append __string [lrange %s", (yyvsp[0].str));}
#line 2656 "y.tab.c"
    break;

  case 202: /* lrange_cmd: LRANGE ARG $@34 args CLOSETAG  */
#line 595 "t3-bison.y"
                                                                       {printf("]\n");}
#line 2662 "y.tab.c"
    break;

  case 203: /* $@35: %empty  */
#line 599 "t3-bison.y"
               {printf("set %s [lrange", (yyvsp[0].str));}
#line 2668 "y.tab.c"
    break;

  case 204: /* lrangeto_cmd: LRANGETO ARG $@35 args CLOSETAG  */
#line 599 "t3-bison.y"
                                                             {printf("]\n");}
#line 2674 "y.tab.c"
    break;

  case 205: /* $@36: %empty  */
#line 603 "t3-bison.y"
              {printf("append __string [lrepeat %s", (yyvsp[0].str));}
#line 2680 "y.tab.c"
    break;

  case 206: /* lrepeat_cmd: LREPEAT ARG $@36 args CLOSETAG  */
#line 603 "t3-bison.y"
                                                                         {printf("]\n");}
#line 2686 "y.tab.c"
    break;

  case 207: /* $@37: %empty  */
#line 607 "t3-bison.y"
                {printf("lappend %s {*}[lrepeat", (yyvsp[0].str));}
#line 2692 "y.tab.c"
    break;

  case 208: /* lrepeatto_cmd: LREPEATTO ARG $@37 args CLOSETAG  */
#line 607 "t3-bison.y"
                                                                      {printf("]\n");}
#line 2698 "y.tab.c"
    break;

  case 209: /* $@38: %empty  */
#line 611 "t3-bison.y"
               {printf("append __string [lreplace %s", (yyvsp[0].str));}
#line 2704 "y.tab.c"
    break;

  case 210: /* lreplace_cmd: LREPLACE ARG $@38 args CLOSETAG  */
#line 611 "t3-bison.y"
                                                                           {printf("]\n");}
#line 2710 "y.tab.c"
    break;

  case 211: /* $@39: %empty  */
#line 615 "t3-bison.y"
                 {printf("set %s [lreplace", (yyvsp[0].str));}
#line 2716 "y.tab.c"
    break;

  case 212: /* lreplaceto_cmd: LREPLACETO ARG $@39 args CLOSETAG  */
#line 615 "t3-bison.y"
                                                                 {printf("]\n");}
#line 2722 "y.tab.c"
    break;

  case 213: /* $@40: %empty  */
#line 619 "t3-bison.y"
               {printf("append __string [lreverse %s", (yyvsp[0].str));}
#line 2728 "y.tab.c"
    break;

  case 214: /* lreverse_cmd: LREVERSE ARG $@40 args CLOSETAG  */
#line 619 "t3-bison.y"
                                                                           {printf("]\n");}
#line 2734 "y.tab.c"
    break;

  case 215: /* $@41: %empty  */
#line 623 "t3-bison.y"
                 {printf("set %s [lreverse", (yyvsp[0].str));}
#line 2740 "y.tab.c"
    break;

  case 216: /* lreverseto_cmd: LREVERSETO ARG $@41 args CLOSETAG  */
#line 623 "t3-bison.y"
                                                                 {printf("]\n");}
#line 2746 "y.tab.c"
    break;

  case 217: /* $@42: %empty  */
#line 626 "t3-bison.y"
              {printf("append __string [lsearch %s", (yyvsp[0].str));}
#line 2752 "y.tab.c"
    break;

  case 218: /* lsearch_cmd: LSEARCH ARG $@42 args CLOSETAG  */
#line 626 "t3-bison.y"
                                                                         {printf("]\n");}
#line 2758 "y.tab.c"
    break;

  case 219: /* $@43: %empty  */
#line 630 "t3-bison.y"
                {printf("set %s [lsearch", (yyvsp[0].str));}
#line 2764 "y.tab.c"
    break;

  case 220: /* lsearchto_cmd: LSEARCHTO ARG $@43 args CLOSETAG  */
#line 630 "t3-bison.y"
                                                               {printf("]\n");}
#line 2770 "y.tab.c"
    break;

  case 221: /* $@44: %empty  */
#line 634 "t3-bison.y"
           {printf("lset %s", (yyvsp[0].str));}
#line 2776 "y.tab.c"
    break;

  case 222: /* lset_cmd: LSET ARG $@44 args CLOSETAG  */
#line 634 "t3-bison.y"
                                                  {printf("\n");}
#line 2782 "y.tab.c"
    break;

  case 223: /* $@45: %empty  */
#line 642 "t3-bison.y"
           {printf("dict %s", (yyvsp[0].str));}
#line 2788 "y.tab.c"
    break;

  case 224: /* dict_cmd: DICT ARG $@45 args CLOSETAG  */
#line 642 "t3-bison.y"
                                                  {printf("\n");}
#line 2794 "y.tab.c"
    break;

  case 225: /* $@46: %empty  */
#line 646 "t3-bison.y"
                {printf("append __string [dict %s", (yyvsp[0].str));}
#line 2800 "y.tab.c"
    break;

  case 226: /* dictprint_cmd: DICTPRINT ARG $@46 args CLOSETAG  */
#line 646 "t3-bison.y"
                                                                        {printf("]\n");}
#line 2806 "y.tab.c"
    break;

  case 227: /* $@47: %empty  */
#line 650 "t3-bison.y"
             {printf("set %s [dict", (yyvsp[0].str));}
#line 2812 "y.tab.c"
    break;

  case 228: /* dictto_cmd: DICTTO ARG $@47 args CLOSETAG  */
#line 650 "t3-bison.y"
                                                         {printf("]\n");}
#line 2818 "y.tab.c"
    break;

  case 230: /* $@48: %empty  */
#line 660 "t3-bison.y"
                   {
    /* a list containing: {keyVar valueVar} */
    printf("dict for %s", (yyvsp[0].str));
  }
#line 2827 "y.tab.c"
    break;

  case 231: /* $@49: %empty  */
#line 664 "t3-bison.y"
      {
    /* dictionaryValue */
    printf(" %s", (yyvsp[0].str));
  }
#line 2836 "y.tab.c"
    break;

  case 232: /* dictfor_begin: DICTFORBEGIN ARG $@48 ARG $@49 CLOSETAG  */
#line 668 "t3-bison.y"
           {
    /* dictionary Script coming up */
    printf(" \{\n\t");
  }
#line 2845 "y.tab.c"
    break;

  case 233: /* dictfor_end: DICTFOREND  */
#line 675 "t3-bison.y"
             {
    printf("\n}\n");
  }
#line 2853 "y.tab.c"
    break;

  case 234: /* $@50: %empty  */
#line 684 "t3-bison.y"
                 {
    /* dictionary Value */
    printf("dict filter %s", (yyvsp[0].str));
  }
#line 2862 "y.tab.c"
    break;

  case 235: /* $@51: %empty  */
#line 688 "t3-bison.y"
      {
    /* type key or value */
    printf(" %s", (yyvsp[0].str));
  }
#line 2871 "y.tab.c"
    break;

  case 236: /* $@52: %empty  */
#line 692 "t3-bison.y"
      {
    /*  globPattern */
    printf(" %s", (yyvsp[0].str));
  }
#line 2880 "y.tab.c"
    break;

  case 237: /* dictfilter_cmd: DICTFILTER ARG $@50 ARG $@51 ARG $@52 CLOSETAG  */
#line 696 "t3-bison.y"
           {
    /* dictionary Script coming up */
    printf(" ]\n");
  }
#line 2889 "y.tab.c"
    break;

  case 238: /* $@53: %empty  */
#line 706 "t3-bison.y"
                   {
    /* filtered dictionary value */
    printf("set %s [dict filter", (yyvsp[0].str));
  }
#line 2898 "y.tab.c"
    break;

  case 239: /* $@54: %empty  */
#line 710 "t3-bison.y"
      {
    /* dictionaryValue */
    printf(" %s", (yyvsp[0].str));
  }
#line 2907 "y.tab.c"
    break;

  case 240: /* $@55: %empty  */
#line 714 "t3-bison.y"
      {
    /* type key or value */
    printf(" %s", (yyvsp[0].str));
  }
#line 2916 "y.tab.c"
    break;

  case 241: /* $@56: %empty  */
#line 718 "t3-bison.y"
      {
    /*  globPattern */
    printf(" %s", (yyvsp[0].str));
  }
#line 2925 "y.tab.c"
    break;

  case 242: /* dictfilterto_cmd: DICTFILTERTO ARG $@53 ARG $@54 ARG $@55 ARG $@56 CLOSETAG  */
#line 722 "t3-bison.y"
           {
    /* dictionary Script coming up */
    printf("]\n");
  }
#line 2934 "y.tab.c"
    break;

  case 244: /* $@57: %empty  */
#line 735 "t3-bison.y"
                    {
    /* a list containing: {keyVar valueVar} */
    printf("dict with %s", (yyvsp[0].str));
  }
#line 2943 "y.tab.c"
    break;

  case 245: /* dictwith_begin: DICTWITHBEGIN ARG $@57 CLOSETAG  */
#line 739 "t3-bison.y"
           {
    /* dictionary Script coming up */
    printf(" \{\n\t");
  }
#line 2952 "y.tab.c"
    break;

  case 246: /* dictwith_end: DICTWITHEND  */
#line 746 "t3-bison.y"
              {
    printf("\n}\n");
  }
#line 2960 "y.tab.c"
    break;

  case 247: /* $@58: %empty  */
#line 754 "t3-bison.y"
           {printf("append __string [scan ", (yyvsp[0].str));}
#line 2966 "y.tab.c"
    break;

  case 248: /* scan_cmd: SCAN ARG $@58 args CLOSETAG  */
#line 754 "t3-bison.y"
                                                                 {printf("]\n");}
#line 2972 "y.tab.c"
    break;

  case 249: /* $@59: %empty  */
#line 758 "t3-bison.y"
             {printf("set %s [scan ", (yyvsp[0].str));}
#line 2978 "y.tab.c"
    break;

  case 250: /* scanto_cmd: SCANTO ARG $@59 args CLOSETAG  */
#line 758 "t3-bison.y"
                                                          {printf("]\n");}
#line 2984 "y.tab.c"
    break;

  case 251: /* $@60: %empty  */
#line 763 "t3-bison.y"
             {printf("append __string [string %s", (yyvsp[0].str));}
#line 2990 "y.tab.c"
    break;

  case 252: /* string_cmd: STRING ARG $@60 args CLOSETAG  */
#line 763 "t3-bison.y"
                                                                       {printf("]\n");}
#line 2996 "y.tab.c"
    break;

  case 253: /* $@61: %empty  */
#line 767 "t3-bison.y"
               {printf("set %s [string", (yyvsp[0].str));}
#line 3002 "y.tab.c"
    break;

  case 254: /* stringto_cmd: STRINGTO ARG $@61 args CLOSETAG  */
#line 767 "t3-bison.y"
                                                             {printf("]\n");}
#line 3008 "y.tab.c"
    break;

  case 255: /* $@62: %empty  */
#line 772 "t3-bison.y"
            {printf("append __string [split %s", (yyvsp[0].str));}
#line 3014 "y.tab.c"
    break;

  case 256: /* split_cmd: SPLIT ARG $@62 args CLOSETAG  */
#line 772 "t3-bison.y"
                                                                     {printf("]\n");}
#line 3020 "y.tab.c"
    break;

  case 257: /* $@63: %empty  */
#line 776 "t3-bison.y"
              {printf("set %s [split", (yyvsp[0].str));}
#line 3026 "y.tab.c"
    break;

  case 258: /* splitto_cmd: SPLITTO ARG $@63 args CLOSETAG  */
#line 776 "t3-bison.y"
                                                           {printf("]\n");}
#line 3032 "y.tab.c"
    break;

  case 259: /* $@64: %empty  */
#line 782 "t3-bison.y"
               {printf("append __string [encoding %s", (yyvsp[0].str));}
#line 3038 "y.tab.c"
    break;

  case 260: /* encoding_cmd: ENCODING ARG $@64 args CLOSETAG  */
#line 782 "t3-bison.y"
                                                                           {printf("]\n");}
#line 3044 "y.tab.c"
    break;

  case 261: /* $@65: %empty  */
#line 786 "t3-bison.y"
                 {printf("set %s [encoding", (yyvsp[0].str));}
#line 3050 "y.tab.c"
    break;

  case 262: /* encodingto_cmd: ENCODINGTO ARG $@65 args CLOSETAG  */
#line 786 "t3-bison.y"
                                                                 {printf("]\n");}
#line 3056 "y.tab.c"
    break;

  case 263: /* $@66: %empty  */
#line 792 "t3-bison.y"
            {printf("append __string [clock %s", (yyvsp[0].str));}
#line 3062 "y.tab.c"
    break;

  case 264: /* clock_cmd: CLOCK ARG $@66 args CLOSETAG  */
#line 792 "t3-bison.y"
                                                                     {printf("]\n");}
#line 3068 "y.tab.c"
    break;

  case 265: /* $@67: %empty  */
#line 796 "t3-bison.y"
              {printf("set %s [clock", (yyvsp[0].str));}
#line 3074 "y.tab.c"
    break;

  case 266: /* clockto_cmd: CLOCKTO ARG $@67 args CLOSETAG  */
#line 796 "t3-bison.y"
                                                           {printf("]\n");}
#line 3080 "y.tab.c"
    break;

  case 267: /* $@68: %empty  */
#line 802 "t3-bison.y"
           {printf("append __string [info %s", (yyvsp[0].str));}
#line 3086 "y.tab.c"
    break;

  case 268: /* info_cmd: INFO ARG $@68 args CLOSETAG  */
#line 802 "t3-bison.y"
                                                                   {printf("]\n");}
#line 3092 "y.tab.c"
    break;

  case 269: /* $@69: %empty  */
#line 806 "t3-bison.y"
             {printf("set %s [info", (yyvsp[0].str));}
#line 3098 "y.tab.c"
    break;

  case 270: /* infoto_cmd: INFOTO ARG $@69 args CLOSETAG  */
#line 806 "t3-bison.y"
                                                         {printf("]\n");}
#line 3104 "y.tab.c"
    break;

  case 271: /* $@70: %empty  */
#line 812 "t3-bison.y"
            {printf("append __string [array %s", (yyvsp[0].str));}
#line 3110 "y.tab.c"
    break;

  case 272: /* array_cmd: ARRAY ARG $@70 args CLOSETAG  */
#line 812 "t3-bison.y"
                                                                     {printf("]\n");}
#line 3116 "y.tab.c"
    break;

  case 273: /* $@71: %empty  */
#line 816 "t3-bison.y"
              {printf("set %s [array", (yyvsp[0].str));}
#line 3122 "y.tab.c"
    break;

  case 274: /* arrayto_cmd: ARRAYTO ARG $@71 args CLOSETAG  */
#line 816 "t3-bison.y"
                                                           {printf("]\n");}
#line 3128 "y.tab.c"
    break;

  case 275: /* $@72: %empty  */
#line 822 "t3-bison.y"
             {printf("append __string [concat %s", (yyvsp[0].str));}
#line 3134 "y.tab.c"
    break;

  case 276: /* concat_cmd: CONCAT ARG $@72 args CLOSETAG  */
#line 822 "t3-bison.y"
                                                                       {printf("]\n");}
#line 3140 "y.tab.c"
    break;

  case 277: /* $@73: %empty  */
#line 826 "t3-bison.y"
               {printf("set %s [concat", (yyvsp[0].str));}
#line 3146 "y.tab.c"
    break;

  case 278: /* concatto_cmd: CONCATTO ARG $@73 args CLOSETAG  */
#line 826 "t3-bison.y"
                                                             {printf("]\n");}
#line 3152 "y.tab.c"
    break;

  case 279: /* $@74: %empty  */
#line 832 "t3-bison.y"
           {printf("append __string [join %s", (yyvsp[0].str));}
#line 3158 "y.tab.c"
    break;

  case 280: /* join_cmd: JOIN ARG $@74 args CLOSETAG  */
#line 832 "t3-bison.y"
                                                                   {printf("]\n");}
#line 3164 "y.tab.c"
    break;

  case 281: /* $@75: %empty  */
#line 836 "t3-bison.y"
             {printf("set %s [join", (yyvsp[0].str));}
#line 3170 "y.tab.c"
    break;

  case 282: /* jointo_cmd: JOINTO ARG $@75 args CLOSETAG  */
#line 836 "t3-bison.y"
                                                         {printf("]\n");}
#line 3176 "y.tab.c"
    break;

  case 283: /* $@76: %empty  */
#line 842 "t3-bison.y"
             {printf("append __string [append %s", (yyvsp[0].str));}
#line 3182 "y.tab.c"
    break;

  case 284: /* append_cmd: APPEND ARG $@76 args CLOSETAG  */
#line 842 "t3-bison.y"
                                                                       {printf("]\n");}
#line 3188 "y.tab.c"
    break;

  case 285: /* $@77: %empty  */
#line 846 "t3-bison.y"
               {printf("set %s [append", (yyvsp[0].str));}
#line 3194 "y.tab.c"
    break;

  case 286: /* appendto_cmd: APPENDTO ARG $@77 args CLOSETAG  */
#line 846 "t3-bison.y"
                                                             {printf("]\n");}
#line 3200 "y.tab.c"
    break;

  case 287: /* $@78: %empty  */
#line 852 "t3-bison.y"
             {printf("append __string [binary %s", (yyvsp[0].str));}
#line 3206 "y.tab.c"
    break;

  case 288: /* binary_cmd: BINARY ARG $@78 args CLOSETAG  */
#line 852 "t3-bison.y"
                                                                       {printf("]\n");}
#line 3212 "y.tab.c"
    break;

  case 289: /* $@79: %empty  */
#line 856 "t3-bison.y"
               {printf("set %s [binary", (yyvsp[0].str));}
#line 3218 "y.tab.c"
    break;

  case 290: /* binaryto_cmd: BINARYTO ARG $@79 args CLOSETAG  */
#line 856 "t3-bison.y"
                                                             {printf("]\n");}
#line 3224 "y.tab.c"
    break;

  case 291: /* $@80: %empty  */
#line 862 "t3-bison.y"
           {printf("append __string [glob -nocomplain %s", (yyvsp[0].str));}
#line 3230 "y.tab.c"
    break;

  case 292: /* glob_cmd: GLOB ARG $@80 args CLOSETAG  */
#line 862 "t3-bison.y"
                                                                               {printf("]\n");}
#line 3236 "y.tab.c"
    break;

  case 293: /* $@81: %empty  */
#line 866 "t3-bison.y"
             {printf("set %s [glob -nocomplain", (yyvsp[0].str));}
#line 3242 "y.tab.c"
    break;

  case 294: /* globto_cmd: GLOBTO ARG $@81 args CLOSETAG  */
#line 866 "t3-bison.y"
                                                                     {printf("]\n");}
#line 3248 "y.tab.c"
    break;

  case 295: /* $@82: %empty  */
#line 872 "t3-bison.y"
            {printf("append __string [file %s", (yyvsp[0].str));}
#line 3254 "y.tab.c"
    break;

  case 296: /* file_cmd: FILEX ARG $@82 args CLOSETAG  */
#line 872 "t3-bison.y"
                                                                    {printf("]\n");}
#line 3260 "y.tab.c"
    break;

  case 297: /* $@83: %empty  */
#line 876 "t3-bison.y"
              {printf("set %s [file", (yyvsp[0].str));}
#line 3266 "y.tab.c"
    break;

  case 298: /* fileto_cmd: FILEXTO ARG $@83 args CLOSETAG  */
#line 876 "t3-bison.y"
                                                          {printf("]\n");}
#line 3272 "y.tab.c"
    break;

  case 299: /* $@84: %empty  */
#line 882 "t3-bison.y"
               {printf("variable %s", (yyvsp[0].str));}
#line 3278 "y.tab.c"
    break;

  case 300: /* variable_cmd: VARIABLE ARG $@84 args CLOSETAG  */
#line 882 "t3-bison.y"
                                                          {printf("\n");}
#line 3284 "y.tab.c"
    break;

  case 301: /* comment_cmd: COMMENT npargs CLOSETAG  */
#line 888 "t3-bison.y"
                          {/* do nothing */}
#line 3290 "y.tab.c"
    break;

  case 302: /* whitespace_cmd: WS npargs CLOSETAG  */
#line 894 "t3-bison.y"
                     {/* do nothing */}
#line 3296 "y.tab.c"
    break;

  case 303: /* arg: ARG  */
#line 900 "t3-bison.y"
      {printf(" %s", (yyvsp[0].str));}
#line 3302 "y.tab.c"
    break;

  case 306: /* nparg: ARG  */
#line 911 "t3-bison.y"
      {/* do nothing here */}
#line 3308 "y.tab.c"
    break;


#line 3312 "y.tab.c"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", YY_CAST (yysymbol_kind_t, yyr1[yyn]), &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYSYMBOL_YYEMPTY : YYTRANSLATE (yychar);
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
      yyerror (YY_("syntax error"));
    }

  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  /* Pop stack until we find a state that shifts the error token.  */
  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYSYMBOL_YYerror;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYSYMBOL_YYerror)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  YY_ACCESSING_SYMBOL (yystate), yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", YY_ACCESSING_SYMBOL (yyn), yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;


#if !defined yyoverflow
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  goto yyreturn;
#endif


/*-------------------------------------------------------.
| yyreturn -- parsing is finished, clean up and return.  |
`-------------------------------------------------------*/
yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  YY_ACCESSING_SYMBOL (+*yyssp), yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif

  return yyresult;
}

#line 919 "t3-bison.y"


  /* main is in myprog.c */
