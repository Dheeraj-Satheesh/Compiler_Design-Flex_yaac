%{
    #include<stdio.h>
    #include<ctype.h>
    int i;
%}

%%
[a-zA-Z]* {
        for(i=0;i<yyleng;i++)
        {
            yytext[i]=tolower(yytext[i]);
        }
        printf("Require: %s",yytext);
}
%%

int yywrap()
{
    return 1;
}

int main()
{
    printf("Enter the input: ");
    yylex();
    return 0;
}
