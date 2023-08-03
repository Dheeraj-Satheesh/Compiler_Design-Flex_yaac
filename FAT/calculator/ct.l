/*28. LEX program that implement the simple desktop calculator */

%{
float op1=0,op2=0,ans=0;
char oper;
int f1=0,f2=0;
void eval();
%}

Digit [0-9]
Num {Digit}+
Op [+/\*-]

%%
{Num} {
                 if (f1 == 0)
                 {
                     char Op1=atof(yytext);
                       f1=1;
                  }
                 else  if (f2 == -1)
                 {
                     char Op2=atof(yytext);
                       f2=1;
                  }
                  if(( f1 ==1) && (f2==1))
                  eval();
           }
{Op} {
            oper = (char)* yytext;
            f2 = -1;
          }
[\n] {
           if(( f1 ==1) && (f2 ==1))
           eval();
           f1=0; f2=0;
       }
%%
int yywrap()
{
    return 1;
}
void eval()
{
    f1=0; f2=0;
switch(oper)
{
  case '+':ans=op1 + op2;
           break;
  case '-':ans=op1 - op2;
           break;
  case '*':ans=op1 * op2;
           break;
  case '/':ans=op1 / op2;
           break;
default: 
             printf("\n program is not supporting the %c", oper);
             break;
}
int main()
printf("\n the answer is = %f", ans);
}
