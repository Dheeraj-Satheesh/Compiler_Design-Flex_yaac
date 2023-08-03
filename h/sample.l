%option yylineno
%{
#include<stdio.h>
#include"sample.tab.h"
#include<math.h>
%}

%{
#define FLOAT 257
#define DOUBLE 258
#define CHAR 259
#define IF 260
#define WHILE 261
#define DO 262
#define FOR 263
%}

%%
"#include<stdio.h>" {return HEADER;}
"int" {return INT;}
"float" {return FLOAT;}
"double" {return DOUBLE;}
"char" {return CHAR;}
"main" {return MAIN;}
"(" {return LB;}
")" {return RB;}
"{" {return LCB;}
"}" {return RCB;}
"," {return COMA;}
";" {return SC;}
[\+\-\*\/] {return OP;}
"=" {return EQ;}
"if" {return IF;}
"while" {return WHILE;}
"do" {return DO;}
"for" {return FOR;}
([a-fA-F][a-fA-F0-9]*) {
    if(strcmp(yytext, "if") == 0 || strcmp(yytext, "while") == 0 || strcmp(yytext, "do") == 0 || strcmp(yytext, "for") == 0) {
        printf("Error: '%s' cannot be used as a variable name.\n", yytext);
        exit(0);
    }
    return VAR;
}
[\n\t ]+ {/*new line or space*/}
. {printf("Invalid character sequence %s\n", yytext); exit(0);}
%%
int yywrap(void)
{
    return 1;
}
