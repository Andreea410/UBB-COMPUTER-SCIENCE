#include "globals.h"

FILE *prodFile;
extern int yylineno;
extern int yyparse(void);

int yyerror(const char *s) {
    fprintf(stderr, "Syntax error at line %d: %s\n", yylineno, s);
    return 0;
}

int main(void) {
    prodFile = fopen("productions.out", "w");
    if (!prodFile) { perror("productions.out"); return 1; }
    yyparse();
    fclose(prodFile);
    return 0;
}
