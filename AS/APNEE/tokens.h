/* Gilles tools around the flex scanner to allow for easier interaction
 * outside a yacc/bison environment. */

#ifndef SIMPLE_ASSIGN_TOKENS_H
#define SIMPLE_ASSIGN_TOKENS_H

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     NUMBER = 258,
     PLUS = 259,
     MINUS = 260,
     MULT = 261,
     DIV = 262,
     EXPON = 263,
     SEMICOLON = 264,
     LB = 265,
     RB = 266,
     VAR = 267,
     MODULO = 268,
     ASSIGN = 269,
     UNDERSCORE = 270,
     LSB = 271,
     RSB = 272,
     COMBINATION = 273,
     SINE = 274,
     COSINE = 275,
     PI = 276
   };
#endif
/* Tokens.  */
#define NUMBER 258
#define PLUS 259
#define MINUS 260
#define MULT 261
#define DIV 262
#define EXPON 263
#define SEMICOLON 264
#define LB 265
#define RB 266
#define VAR 267
#define MODULO 268
#define ASSIGN 269
#define UNDERSCORE 270
#define LSB 271
#define RSB 272
#define COMBINATION 273
#define SINE 274
#define COSINE 275
#define PI 276





typedef struct Token {
    int type;
    char * text;
    float value; // only defined when the token type allows for it
    int intValue; // only defined when the token type allows for it
} Token;

/*Token * _newToken(int type, int compute_float_value);*/

void _freeToken(Token* t);

// Define the profile of the yylex function generated by flex tool.
#define YY_DECL Token *yylex(void)

#endif //SIMPLE_ASSIGN_TOKENS_H
