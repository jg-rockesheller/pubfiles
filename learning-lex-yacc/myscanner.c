#include <stdio.h>
#include "myscanner.h"

extern int yylex();
extern int yylineno;
extern char* yytext;

char *names[] = {NULL, "db_type", "db_name", "db_table_prefix", "db_port"};

int main(void) {
	int nametoken, valtoken;

	nametoken= yylex();
	while (nametoken) {
		printf("%d\n", nametoken);

		if (yylex() != COLON) {
			printf("Syntax error on line %d, expected a ':' but found %s\n", yylineno, yytext);

			return 1;
		}

		valtoken = yylex();
		switch (nametoken) {
		case TYPE:
		case NAME:
		case TABLE_PREFIX:
			if (valtoken != IDENTIFIER) {
				printf("Syntax error on line %d, expected an identifier but found %s\n", yylineno, yytext);
				return 1;
			}

			printf("%s is set to %s\n", names[nametoken], yytext);
			break;
		case PORT:
			if (valtoken != INTEGER) {
				printf("Syntax error on line %d, expected an integer but found %s\n", yylineno, yytext);
				return 1;
			}

			printf("%s is set to %s\n", names[nametoken], yytext);
			break;
		default:
			printf("Syntax error on line %d\n", yylineno);
		}

		nametoken = yylex();
	}

	return 0;
}
