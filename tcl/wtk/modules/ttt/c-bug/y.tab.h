/* A Bison parser, made by GNU Bison 3.7.6.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
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
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

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

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

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
#define YYEMPTY -2
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

#line 290 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
