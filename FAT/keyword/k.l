%{
#include<stdio.h>
#include<string.h>
int key=0;
int sep=0;
int op=0;
int iden=0;
int n;
%}

%%
auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|int|long|register|return|short|signed|sizeof|static|struct|switch|typedef|union|unsigned|void|volatile|while { key++;n++;}
[{};,()] { sep++;n++;}
[a-zA-Z_][a-zA-Z0-9_]* { iden++;n++;}
[+-/=*%<><=>=!] { op++;n++;}
. ;

%%

int yywrap()
{
    return 1;
}

int main()
{
    printf("Enter the input:\n");
    yylex();
    printf("\nKeywords: %d\n", key);
    printf("\nIdentifiers: %d\n", iden);
    printf("\nOperators: %d\n", op);
    printf("\nSeparators: %d\n", sep);
    printf("\nTotal number of tokens: %d\n",n);
    return 0;
}
