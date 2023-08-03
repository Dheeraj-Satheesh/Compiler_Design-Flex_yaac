%option yylineno
%{
#include<stdio.h>
#include"y.tab.h"
#include<math.h>
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
([a-fA-F][a-zA-Z0-9]*) {return VAR;}
[\n\t ]+ {/new line or space/}
. {printf("Invalid character sequence %s\n", yytext); exit(0);}
%%
int yywrap(void)
{
    return 1;
}