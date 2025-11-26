/* A Bison parser, made by GNU Bison 3.8.2.  */

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

#ifndef YY_YY_PARSER_TAB_H_INCLUDED
# define YY_YY_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
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
    LOWER_THAN_ELSE = 258,         /* LOWER_THAN_ELSE  */
    VAR = 259,                     /* VAR  */
    BEGIN_ = 260,                  /* BEGIN_  */
    END = 261,                     /* END  */
    IF = 262,                      /* IF  */
    THEN = 263,                    /* THEN  */
    ELSE = 264,                    /* ELSE  */
    WHILE = 265,                   /* WHILE  */
    DO = 266,                      /* DO  */
    READ = 267,                    /* READ  */
    WRITE = 268,                   /* WRITE  */
    BOOLEAN = 269,                 /* BOOLEAN  */
    CHAR = 270,                    /* CHAR  */
    INTEGER = 271,                 /* INTEGER  */
    REAL = 272,                    /* REAL  */
    INT = 273,                     /* INT  */
    FLOAT = 274,                   /* FLOAT  */
    STRING = 275,                  /* STRING  */
    CHAR_T = 276,                  /* CHAR_T  */
    ARRAY = 277,                   /* ARRAY  */
    OF = 278,                      /* OF  */
    COLON = 279,                   /* COLON  */
    SEMI = 280,                    /* SEMI  */
    DOT = 281,                     /* DOT  */
    LPAREN = 282,                  /* LPAREN  */
    RPAREN = 283,                  /* RPAREN  */
    LBRACK = 284,                  /* LBRACK  */
    RBRACK = 285,                  /* RBRACK  */
    ID = 286,                      /* ID  */
    INT_LITERAL = 287,             /* INT_LITERAL  */
    FLOAT_LITERAL = 288,           /* FLOAT_LITERAL  */
    STRING_LITERAL = 289,          /* STRING_LITERAL  */
    CHAR_LITERAL = 290,            /* CHAR_LITERAL  */
    PLUS = 291,                    /* PLUS  */
    MINUS = 292,                   /* MINUS  */
    MUL = 293,                     /* MUL  */
    DIV = 294,                     /* DIV  */
    MOD = 295,                     /* MOD  */
    ASSIGN = 296,                  /* ASSIGN  */
    LT = 297,                      /* LT  */
    LE = 298,                      /* LE  */
    EQ = 299,                      /* EQ  */
    NE = 300,                      /* NE  */
    GE = 301,                      /* GE  */
    GT = 302,                      /* GT  */
    AND = 303,                     /* AND  */
    OR = 304,                      /* OR  */
    NOT = 305                      /* NOT  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */
