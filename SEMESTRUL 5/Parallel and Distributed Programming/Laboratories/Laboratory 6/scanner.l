%{
#include "parser.tab.h"
#include <stdio.h>
#include <string.h>

int mapToken(const char *t);
int isInt(const char *t);
int isFloat(const char *t);
int isStringLiteral(const char *t);
int isCharLiteral(const char *t);
int isIdentifier(const char *t);
%}

%option noyywrap

%%

[ \t]+            { /* skip whitespace */ }

^[^\n]+           {
    char token[256];
    if (sscanf(yytext, "%255s", token) == 1) {
        int tok = mapToken(token);
        if (tok != 0)
            return tok;
        else
            return ID;  // fallback for identifiers like x, y, name
    }
}

\n                { /* ignore newlines */ }

.                 {
    int tok = mapToken(yytext);
    if (tok != 0) return tok;
}

%%

int mapToken(const char *t)
{
    /* Keywords */
    if (!strcmp(t,"VAR")) return VAR;
    if (!strcmp(t,"BEGIN")) return BEGIN_;
    if (!strcmp(t,"END")) return END;
    if (!strcmp(t,"IF")) return IF;
    if (!strcmp(t,"THEN")) return THEN;
    if (!strcmp(t,"ELSE")) return ELSE;
    if (!strcmp(t,"WHILE")) return WHILE;
    if (!strcmp(t,"DO")) return DO;
    if (!strcmp(t,"READ")) return READ;
    if (!strcmp(t,"WRITE")) return WRITE;

    /* Types */
    if (!strcmp(t,"BOOLEAN")) return BOOLEAN;
    if (!strcmp(t,"CHAR")) return CHAR;
    if (!strcmp(t,"INTEGER")) return INTEGER;
    if (!strcmp(t,"REAL")) return REAL;
    if (!strcmp(t,"int")) return INT;
    if (!strcmp(t,"float")) return FLOAT;
    if (!strcmp(t,"string")) return STRING;
    if (!strcmp(t,"char")) return CHAR_T;

    /* Arrays */
    if (!strcmp(t,"ARRAY")) return ARRAY;
    if (!strcmp(t,"OF")) return OF;

    /* Operators */
    if (!strcmp(t,":=")) return ASSIGN;
    if (!strcmp(t,"+")) return PLUS;
    if (!strcmp(t,"-")) return MINUS;
    if (!strcmp(t,"*")) return MUL;
    if (!strcmp(t,"/")) return DIV;
    if (!strcmp(t,"%")) return MOD;

    /* Relational */
    if (!strcmp(t,"<")) return LT;
    if (!strcmp(t,"<=")) return LE;
    if (!strcmp(t,"=")) return EQ;
    if (!strcmp(t,"<>")) return NE;
    if (!strcmp(t,">=")) return GE;
    if (!strcmp(t,">")) return GT;

    /* Boolean ops */
    if (!strcmp(t,"AND")) return AND;
    if (!strcmp(t,"OR")) return OR;
    if (!strcmp(t,"NOT")) return NOT;

    /* Punctuators */
    if (!strcmp(t,"(")) return LPAREN;
    if (!strcmp(t,")")) return RPAREN;
    if (!strcmp(t,"[")) return LBRACK;
    if (!strcmp(t,"]")) return RBRACK;
    if (!strcmp(t,";")) return SEMI;
    if (!strcmp(t,":")) return COLON;
    if (!strcmp(t,".")) return DOT;

    /* Literals */
    if (isStringLiteral(t)) return STRING_LITERAL;
    if (isCharLiteral(t)) return CHAR_LITERAL;
    if (isFloat(t)) return FLOAT_LITERAL;
    if (isInt(t)) return INT_LITERAL;
    if (isIdentifier(t)) return ID;

    return 0;
}

/* ------------------------------------------ */
/* HELPERS */
/* ------------------------------------------ */

int isCharLiteral(const char* t) {
    int len = strlen(t);
    return len == 3 && t[0]=='\'' && t[2]=='\'';
}

int isStringLiteral(const char* t) {
    int len = strlen(t);
    return len >= 2 && t[0]=='"' && t[len-1]=='"';
}

int isInt(const char *t) {
    for (int i=0; t[i]; ++i)
        if (t[i]<'0' || t[i]>'9') return 0;
    return 1;
}

int isFloat(const char *t) {
    int dot = 0;
    for (int i=0; t[i]; ++i) {
        if (t[i]=='.') dot++;
        else if (t[i]<'0' || t[i]>'9') return 0;
    }
    return dot == 1;
}

int isIdentifier(const char* t) {
    if (!((t[0]>='a' && t[0]<='z') || (t[0]>='A' && t[0]<='Z') || t[0]=='_')) return 0;
    for (int i=1; t[i]; ++i)
        if (!((t[i]>='a' && t[i]<='z') ||
              (t[i]>='A' && t[i]<='Z') ||
              (t[i]>='0' && t[i]<='9') ||
              t[i]=='_')) return 0;
    return 1;
}
