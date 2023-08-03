%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char* s);
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
%}

%union {
    int data_type;
    char var_name[30];
}

%token HEADER MAIN LB RB LCB RCB SC COMA VAR EQ OP
%token<data_type> INT CHAR FLOAT DOUBLE
%type<data_type> DATA_TYPE
%type<var_name> VAR
%start prm

%%

prm: HEADER MAIN_TYPE MAIN LB RB LCB BODY RCB {
    printf("\nParsing successful\n");
}

BODY: DECLARATION_STATEMENTS PROGRAM_STATEMENTS

DECLARATION_STATEMENTS: DECLARATION_STATEMENT DECLARATION_STATEMENTS {
    printf("\nDeclaration section successfully parsed\n");
}
    | DECLARATION_STATEMENT

PROGRAM_STATEMENTS: PROGRAM_STATEMENT PROGRAM_STATEMENTS {
    printf("\nProgram statements successfully parsed\n");
}
    | PROGRAM_STATEMENT

DECLARATION_STATEMENT: DATA_TYPE VAR_LIST SC {
}

VAR_LIST: VAR COMA VAR_LIST {
    insert_to_table($1, current_data_type);
}
    | VAR {
    insert_to_table($1, current_data_type);
}

PROGRAM_STATEMENT: VAR EQ A_EXPN SC {
    expn_type = -1;
}

A_EXPN: A_EXPN OP A_EXPN
    | LB A_EXPN RB
    | VAR {
    if ((temp = lookup_in_table($1)) != -1) {
        if (expn_type == -1) {
            expn_type = temp;
        } else if (expn_type != temp) {
            printf("\nType mismatch in the expression\n");
            exit(0);
        }
    } else {
        printf("\nVariable \"%s\" undeclared\n", $1);
        exit(0);
    }
}

MAIN_TYPE: INT

DATA_TYPE: INT {
    $$ = $1;
    current_data_type = $1;
}
    | CHAR {
    $$ = $1;
    current_data_type = $1;
}
    | FLOAT
    | DOUBLE

%%

int lookup_in_table(char var[30]) {
    int i;
    for (i = 0; i <= var_count; i++) {
        if (strcmp(var_list[i].var_name, var) == 0) {
            return var_list[i].type;
        }
    }
    return -1;
}

void insert_to_table(char var[30], int type) {
    int i;
    for (i = 0; i <= var_count; i++) {
        if (strcmp(var_list[i].var_name, var) == 0) {
            printf("Multiple declaration of variable %s\n", var);
            exit(0);
        }
    }

    var_count++;
    strcpy(var_list[var_count].var_name, var);
    var_list[var_count].type = type;
}

int main() {
    yyparse();
    /* if(success)
    printf("Parsing Successful\n"); */
    return 0;
}

void yyerror(const char* msg) {
    extern int yylineno;
    printf("Parsing Failed\nLine Number: %d %s\n", yylineno, msg);
    success = 0;
    exit(0);
}
