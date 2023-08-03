%option yylineno
%{
#include<stdio.h>
#include<string.h>
#include"sample.tab.h"
#include<math.h>
extern int var_count;
extern int yylex();
extern int yylineno;
extern char* yytext;
extern int yylval;
extern void yyerror(const char* msg);
%}
%%
"#include<stdio.h>" { return HEADER; }
"if" {
    printf("Usage of keyword \"%s\" is prohibited\n", yytext);
    exit(0);
}
"int" {
    yylval.data_type = INT;
    return INT;
}
"char" {
    yylval.data_type = CHAR;
    return CHAR;
}
"main" { return MAIN; }
"(" { return LB; }
")" { return RB; }
"{" { return LCB; }
"}" { return RCB; }
"," { return COMA; }
";" { return SC; }
[\+\-\*\/] { return OP; }
"=" { return EQ; }
[a-z]+ {
    strcpy(yylval.var_name, yytext);
    return VAR;
}
[\n\t ]+ {/*new line or space*/}
. {
    printf("Invalid character sequence %s\n", yytext);
    exit(0);
}
%%
int yywrap(void) {
    return 1;
}
