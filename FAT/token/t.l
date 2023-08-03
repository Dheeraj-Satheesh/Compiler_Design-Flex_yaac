/* Design a LEX Code for Tokenizing (identify and print OPERATORS, SEPERATORS, KEYWORDS, IDENTIFIERS) the following C- fragment. */

%{
    int n=0;
%}
 


%%

while|if|else|int|float {n++; printf("\t keywords: %s",yytext);}
[a-zA-Z_][a-zA-Z0-9_]* {n++; printf("\t Identifier: %s",yytext);}
"<="|"=="|"="|"++"|"-"|"*"|"+""("|")"|","	{n++; printf("\t Operators: %s",yytext);}
"{"|"}"|";" {n++; printf("\t Seperators: %s",yytext);}

%%

int yywrap()
{
    return 1;
}

int main()
{ 
    yylex();
    printf("\nTotal number of token = %d \n",n); 
    return 0;
}