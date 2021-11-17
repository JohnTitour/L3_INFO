/*
 * expr.lex : Scanner for a simple
 *            expression parser.
 */

%{
#include "tokens.h"
#include <errno.h>

#define ERROR(s, e) {errno=(e); perror((s)); exit((e)); }
#define YY_SKIP_YYWRAP 1
#define INTVALUE 2
#define FLOATVALUE 1


Token * _newToken(int type, int compute_value) {
    Token *t = (Token *)calloc(1, sizeof(Token));
    t->type = type;
    t->text = (char *)calloc(yyleng + 1, 1);
    if (t->text == NULL) {
        ERROR("calloc", EXIT_FAILURE);
    }
    memmove(t->text, yytext, yyleng);
    if (compute_value & FLOATVALUE) {
        //fprintf(stderr, "Computing value of : %s -> %s", yytext, t->text);
        sscanf(yytext,"%f",&t->value);
    }
    if (compute_value & INTVALUE) {
        //fprintf(stderr, "Computing value of : %s -> %s", yytext, t->text);
        sscanf(yytext,"%d",&t->intValue);
    }
    return t;
}

void _freeToken(Token* t) {
    if (t != NULL) {
        if (t->text != NULL) {
            free(t->text);
        }
        free(t);
    }
}

Token * newToken(int type) {
    return _newToken(type, 0);
}

Token * newTokenWithFloatValue(int type) {
    return _newToken(type, FLOATVALUE);
}

Token * newTokenWithIntValue(int type) {
    return _newToken(type, INTVALUE | FLOATVALUE);
}

void yyerror (char const *s) {
  fprintf (stderr, "%s\n", s);
}

int yywrap() {
    return 1;
}

%}

%%

"C"         return(newToken(COMBINATION));
"sin"         return(newToken(SINE));
"cos"         return(newToken(COSINE));
"π"         return(newToken(PI));

[0-9]+          return(newTokenWithIntValue(NUMBER));
[0-9]+\.[0-9]+  return(newTokenWithFloatValue(NUMBER));

[a-zA-Z]+       return( newToken(VAR));

"+"        return(newToken(PLUS));
"-"        return(newToken(MINUS));
"*"        return(newToken(MULT));
"/"        return(newToken(DIV));
"^"        return(newToken(EXPON));
"%"        return(newToken(MODULO));
"("        return(newToken(LB));
")"        return(newToken(RB));
"["        return(newToken(LSB));
"]"        return(newToken(RSB));
"="        return(newToken(ASSIGN));
";"         return(newToken(SEMICOLON));
"_"         return(newToken(UNDERSCORE));
[\n\t ]*     /* throw away whitespace */
.          { yyerror("Illegal character");
             return(newToken(SEMICOLON));
           }
<<EOF>>  { return(NULL); }
%%



