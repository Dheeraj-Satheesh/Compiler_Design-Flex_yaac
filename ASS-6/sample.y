%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<math.h>
int yylex(void);
int yyerror(const char *s);
int success = 1;
int current_data_type;
int expn_type = -1;
int temp;
struct symbol_table {
    char var_name[30];
    int type;
} var_list[20];
int var_count = -1;
extern int lookup_in_table(char var[30]);
extern void insert_to_table(char var[30], int type);
extern void print_symbol_table();
%}
%union {
    int data_type;
    char var_name[30];
}
%token HEADER MAIN LB RB LCB RCB SC VAR EQ INT FOR IF WHILE NOT GT LT EQUAL TERNARY_IF TERNARY_ELSE MOD POW INCREMENT
%type<data_type> DATA_TYPE
%type<var_name> VAR
%start prm
%%
prm : HEADER MAIN_TYPE MAIN LB RB LCB BODY RCB {
    printf("\nParsing successful\n");
    print_symbol_table();
}
MAIN_TYPE : DATA_TYPE
DATA_TYPE : INT {
    $$ = $1;
    current_data_type = $1;
}
BODY : DECLARATION_STATEMENTS PROGRAM_STATEMENTS
DECLARATION_STATEMENTS : DECLARATION_STATEMENT DECLARATION_STATEMENTS
| DECLARATION_STATEMENT {
    printf("\nDeclaration section successfully parsed\n");
}
DECLARATION_STATEMENT : DATA_TYPE VAR SC {
    insert_to_table($2, $1);
}
PROGRAM_STATEMENTS : PROGRAM_STATEMENT PROGRAM_STATEMENTS
| PROGRAM_STATEMENT {
    printf("\nProgram statement successfully parsed\n");
}
PROGRAM_STATEMENT : FOR LB A_EXPN SC A_EXPN SC A_EXPN RB LCB BODY RCB {
    printf("\nFor loop successfully parsed\n");
}
| IF LB LOGICAL_EXPRESSION RB LCB BODY RCB {
    printf("\nIf statement successfully parsed\n");
}
| WHILE LB LOGICAL_EXPRESSION RB LCB BODY RCB {
    printf("\nWhile loop successfully parsed\n");
}
| VAR EQ TERNARY_EXPRESSION SC {
    printf("\nTernary expression successfully parsed\n");
}
| VAR INCREMENT SC {
    printf("\nIncrement statement successfully parsed\n");
}
TERNARY_EXPRESSION : VAR EQ A_EXPN TERNARY_IF A_EXPN TERNARY_ELSE A_EXPN
A_EXPN : VAR EQ VAR
LOGICAL_EXPRESSION : VAR EQ VAR
| NOT VAR GT VAR
| NOT VAR LT VAR
| NOT VAR EQUAL VAR
%%
int lookup_in_table(char var[30])
{
    for (int i = 0; i <= var_count; i++) {
        if (strcmp(var, var_list[i].var_name) == 0) {
            return var_list[i].type;
        }
    }
    return -1;
}
void insert_to_table(char var[30], int type)
{
    var_count++;
    strcpy(var_list[var_count].var_name, var);
    var_list[var_count].type = type;
}
void print_symbol_table() {
    printf("\nSymbol Table:\n");
    printf("-------------\n");
    printf("Variable\tType\n");
    printf("-------------\n");
    for (int i = 0; i <= var_count; i++) {
        printf("%s\t\t%d\n", var_list[i].var_name, var_list[i].type);
    }
    printf("-------------\n");
}
int main()
{
    yyparse();
    return 0;
}
int yyerror(const char *msg)
{
    extern int yylineno;
    printf("Parsing Failed\nLine Number: %d %s\n", yylineno, msg);
    success = 0;
    return 0;
}
