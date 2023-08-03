%{
#include <stdio.h>
#include<ctype.h>
int lineCount = 0;
int wordCount = 0;
int charCount = 0;
int intCount = 0;
int floatCount = 0;
%}

%%
[0-9]+ { intCount++; charCount+=yyleng; wordCount++;}
[0-9]+"."[0-9]+  { floatCount++;charCount+=yyleng; }
[a-zA-Z]+   { wordCount++;charCount+=yyleng;}
[A][A-Za-z]{2}[^A-Za-z]   {
                              int i;
                              for (i = 0; i < 3; i++) {
                                  yytext[i] = toupper(yytext[i]);
                              }
                              printf("Words of length three, starting with 'A' to uppercase: %s\n", yytext);
                              wordCount++;
                              charCount+=yyleng;
                          }

[\n]    { lineCount++;charCount+=yyleng; }
[^\n] { charCount++; }

"//"[\s\t a-zA-Z]*[\n]+     { lineCount++;charCount+=yyleng;wordCount++;printf("Single line comment: %s\n", yytext); }
"/*"([^*]|"*"+[^*/])*"*/" { lineCount++;charCount+=yyleng;wordCount++;printf("Multi-line comment: %s\n", yytext); }



%%
int main() {
    yylex();
    printf("Lines: %d\n", lineCount);
    printf("Words: %d\n", wordCount);
    printf("Characters: %d\n", charCount);
    printf("Floating-point count: %d\n", floatCount);
    printf("integers count: %d\n", intCount);
}
int yywrap(){
    return 1;
}
