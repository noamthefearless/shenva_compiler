%error-verbose
%{
#include <stdio.h>
int yylineno;  
FILE* errorFile;
%}


%union 
{
    int num;
    char *str;  // Add a string field
}
%token NUM
%token ADD SUB MUL DIV
%token LPAREN RPAREN
%token <str> ERROR
%token PRINT
%token ENDL
%left ADD SUB
%left MUL DIV

%%


program : statements
        ;

statements : statement
           | statements statement
           ;

statement : PRINT LPAREN expression RPAREN  { /* Handle print statement */ }
		  | ENDL
		  | expression 
          | ERROR {fprintf(errorFile, "syntax error, unrecognized \"%s\" in the code (line %d)\n", $1, yylineno);}
          ;

expression : NUM
           | expression ADD expression { /* Handle addition here */ }
           | expression SUB expression { /* Handle subtraction here */ }
           | expression MUL expression { /* Handle multiplication here */ }
           | expression DIV expression { /* Handle division here */ }
           | LPAREN expression RPAREN   { /* Handle parentheses here */ }
		   | error 
           ;


%%

int main(int argc, char *argv[]) 
{
    if (argc != 3) {
        fprintf(stderr, "Usage: %s input_code_file output_file\n", argv[0]);
        return 1;
    }

    FILE* inputFile = fopen(argv[1], "r");
    if (!inputFile) {
        perror("Error opening input file");
        return 1;
    }

    FILE* outputFile = fopen(argv[2], "w");
    if (!outputFile) {
        perror("Error opening output file");
        fclose(inputFile);
        return 1;
    }
	errorFile = fopen("errors.txt", "w");
    if (!errorFile) 
	{
        perror("Error opening error file");
        fclose(inputFile);
		fclose(outputFile);
        return 1;
    }
	yylineno = 1;
    set_input_file(inputFile);
    set_output_file(outputFile);
	
    yyparse();

    fclose(inputFile);
    fclose(outputFile);
	fclose(errorFile);
    return 0;
}

int yyerror(char *msg) 
{
	int i = 0;
	for (i = 0; i < strlen(msg); i++)
	{
    switch (msg[i]) {
        case 'A':
            fprintf(errorFile, "\"+\"");
			i += 2;
            break;
        case 'S':
            fprintf(errorFile, "\"-\"");
			i += 2;
            break;
        case 'M':
            fprintf(errorFile, "\"*\"");
			i += 2;
            break;
        case 'D':
            fprintf(errorFile, "\"//\"");
			i += 2;
            break;
        case 'R':
            fprintf(errorFile, "\")\"");
			i += 5;
            break;
        case 'L':
            fprintf(errorFile, "\"(\"");
			i += 5;
            break;
        case 'P':
            fprintf(errorFile, "print");
			i += 4;
            break;
		case 'E':
			if (msg[i + 1] == 'R')
			{
				fprintf(errorFile, "character");
				i += 4;
			}
			else if (msg[i + 1] == 'N')
			{
				fprintf(errorFile, "newline");
				i += 3;
			}
			break;
		case 'N':
			fprintf(errorFile, "number");
			i += 2;
			break;
        default:
            fputc(msg[i], errorFile);
            break;
		
		}
		
	}
	fprintf(errorFile, " (line %d)", yylineno);
	fputc('\n', errorFile);
    return 0;
}




