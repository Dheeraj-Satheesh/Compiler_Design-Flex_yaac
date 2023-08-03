%option yylineno
%{
#include<stdio.h>
#include<string.h>
#include"sample.tab.h"
extern int var_count;
%}
%%
"#include<stdio.h>" {return HEADER;}
"int" {yylval.data_type=0;return INT;}
"main" {return MAIN;}
"for" {return FOR;}
"if" {return IF;}
"while" {return WHILE;}
"(" {return LB;}
")" {return RB;}
"{" {return LCB;}
"}" {return RCB;}
"=" {return EQ;}
";" {return SC;}
"!" {return NOT;}
">" {return GT;}
"<" {return LT;}
"==" {return EQUAL;}
"++" {return INCREMENT;}
"?" {return TERNARY_IF;}
":" {return TERNARY_ELSE;}
"%" {return MOD;}
"^" {return POW;}
[a-zA-Z_][a-zA-Z0-9_]* {strcpy(yylval.var_name,yytext);return VAR;}
[\n\t ]+ {/*new line or space*/}
. {printf("Invalid character sequence: %s\n",yytext); exit(0);}
%%
int yywrap(void)
{
    return 1;
}
