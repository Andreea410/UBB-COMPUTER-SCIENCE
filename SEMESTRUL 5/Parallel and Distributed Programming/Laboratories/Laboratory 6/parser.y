%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "globals.h"

int yylex(void);
void logProd(const char *s);
int yyerror(const char *s);

%}

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%token VAR BEGIN_ END IF THEN ELSE WHILE DO READ WRITE
%token BOOLEAN CHAR INTEGER REAL INT FLOAT STRING CHAR_T
%token ARRAY OF
%token COLON SEMI DOT LPAREN RPAREN LBRACK RBRACK
%token ID INT_LITERAL FLOAT_LITERAL STRING_LITERAL CHAR_LITERAL
%token PLUS MINUS MUL DIV MOD
%token ASSIGN LT LE EQ NE GE GT
%token AND OR NOT

%%

program
    : VAR declList compoundStmt DOT
        { logProd("program -> VAR declList ; compoundStmt ."); }
    ;

declList
    : declarationList
    ;

declarationList
    : declaration SEMI
        { logProd("declarationList -> declaration ;"); }
    | declarationList declaration SEMI
        { logProd("declarationList -> declarationList declaration ;"); }
    ;

declaration
    : ID COLON dataType
        { logProd("declaration -> ID : dataType"); }
    | ID COLON arrayType
        { logProd("declaration -> ID : arrayType"); }
    ;

dataType
    : BOOLEAN
    | CHAR
    | INTEGER
    | REAL
    | INT
    | FLOAT
    | STRING
    | CHAR_T
        { logProd("dataType -> basic_type"); }
    ;

arrayType
    : ARRAY LBRACK INT_LITERAL RBRACK OF dataType
        { logProd("arrayType -> ARRAY [ INT_LITERAL ] OF dataType"); }
    ;

compoundStmt
    : BEGIN_ statements END
        { logProd("compoundStmt -> BEGIN statements END"); }
    ;

statements
    : statementList
    ;

statementList
    : statement
        { logProd("statementList -> statement"); }
    | statementList SEMI statement
        { logProd("statementList -> statementList ; statement"); }
    ;

statement
    : simpleStmt
        { logProd("statement -> simpleStmt"); }
    | structuredStmt
        { logProd("statement -> structuredStmt"); }
    ;

simpleStmt
    : assignmentStmt
        { logProd("simpleStmt -> assignmentStmt"); }
    | ioStmt
        { logProd("simpleStmt -> ioStmt"); }
    ;

assignmentStmt
    : ID ASSIGN expr
        { logProd("assignmentStmt -> ID := expr"); }
    ;

ioStmt
    : READ LPAREN ID RPAREN
        { logProd("ioStmt -> READ ( ID )"); }
    | WRITE LPAREN ID RPAREN
        { logProd("ioStmt -> WRITE ( ID )"); }
    ;

structuredStmt
    : compoundStmt
        { logProd("structuredStmt -> compoundStmt"); }
    | ifStmt
        { logProd("structuredStmt -> ifStmt"); }
    | whileStmt
        { logProd("structuredStmt -> whileStmt"); }
    ;

ifStmt
    : IF condition THEN statement %prec LOWER_THAN_ELSE
        { logProd("ifStmt -> IF condition THEN statement"); }
    | IF condition THEN statement ELSE statement
        { logProd("ifStmt -> IF condition THEN statement ELSE statement"); }
    ;

whileStmt
    : WHILE condition DO statement
        { logProd("whileStmt -> WHILE condition DO statement"); }
    ;

condition
    : orCondition
        { logProd("condition -> orCondition"); }
    ;

orCondition
    : andCondition
        { logProd("orCondition -> andCondition"); }
    | andCondition OR andCondition
        { logProd("orCondition -> andCondition OR andCondition"); }
    ;

andCondition
    : notCondition
        { logProd("andCondition -> notCondition"); }
    | notCondition AND notCondition
        { logProd("andCondition -> notCondition AND notCondition"); }
    ;

notCondition
    : NOT notCondition
        { logProd("notCondition -> NOT notCondition"); }
    | LPAREN expr relOp expr RPAREN
        { logProd("notCondition -> ( expr relOp expr )"); }
    ;

relOp
    : LT | LE | EQ | NE | GE | GT
        { logProd("relOp -> operator"); }
    ;

expr
    : term
        { logProd("expr -> term"); }
    | term PLUS term
        { logProd("expr -> term + term"); }
    | term MINUS term
        { logProd("expr -> term - term"); }
    ;

term
    : factor
        { logProd("term -> factor"); }
    | factor MUL factor
        { logProd("term -> factor * factor"); }
    | factor DIV factor
        { logProd("term -> factor / factor"); }
    | factor MOD factor
        { logProd("term -> factor % factor"); }
    ;

factor
    : ID
        { logProd("factor -> ID"); }
    | INT_LITERAL
        { logProd("factor -> INT_LITERAL"); }
    | FLOAT_LITERAL
        { logProd("factor -> FLOAT_LITERAL"); }
    | STRING_LITERAL
        { logProd("factor -> STRING_LITERAL"); }
    | CHAR_LITERAL
        { logProd("factor -> CHAR_LITERAL"); }
    | LPAREN expr RPAREN
        { logProd("factor -> ( expr )"); }
    ;

%%

void logProd(const char *s) {
    fprintf(prodFile, "%s\n", s);
}

