#include "TokenGetter.h"
#include "llist.h"
#include <stdbool.h>
#include <stdlib.h>


#ifndef LOGMANAGER_H
#include "logManager.h"
#endif



/*
 * extracting tokens from a file.
 * file: FILE*, an opened file
 * ret: llist*, a linked list of tokens
 */
llist* extractToken(FILE* file, FILE* logFile)
{
	llist* tokenList = llist_create(NULL);
	char c;

	while ((c = fgetc(file)) != EOF)
	{
		if (c == 10) // if newline
		{
			continue;
		}

		Token* token = (Token*)malloc(sizeof(Token));
		if( c == NUM)
		{
			int numValue = 0;
			token->type = NUM;
			bool isNegative = false;

			c = fgetc(file); // skip the space
			c = fgetc(file);// get the next number from the file
			if (c == '-')
			{
				isNegative = true;
				c = fgetc(file);
			}
			c -= '0';


			numValue += c;
			while(c = fgetc(file))
			{
				if(c == 10)
				{
					break;
				}

				numValue *= 10;
				numValue += c - '0';
			}

			if(isNegative)
			{
				numValue *= -1;
			}

			token->value = (int*)malloc(sizeof(int));
			*((int*)(token->value)) = numValue;
		}
		else if (c == ADD)
		{
			token->type = ADD;
			token->value = NULL;
		}
		else if (c == SUB)
		{
			token->type = SUB;
			token->value = NULL;
		}
		else if (c == MUL)
		{
			token->type = MUL;
			token->value = NULL;
		}
		else if (c == DIV)
		{
			token->type = DIV;
			token->value = NULL;
		}
		else if (c == LPARN)
		{
			token->type = LPARN;
			token->value = NULL;
		}
		else if (c == RPARN)
		{
			token->type = RPARN;
			token->value = NULL;
		}
		else if (c == PRINT)
		{
			token->type = PRINT;
			token->value = NULL;
		}
		else if (c == ENDL)
		{
			token->type = ENDL;
			token->value = NULL;
		}
		else
		{
			token->type = ERROR;
			token->value = NULL;
		}

		llist_append(tokenList, token);
		
	}
	fclose(file);
	printTokensToLog(tokenList, logFile);
	return tokenList;

}

/* prints Token list that is in memory to log file */
void printTokensToLog(llist list, FILE* file)
{
	
}

/*
 * prints a token to the screen
 * token: Token, a token
 * ret: -
 */
void printToken(Token* token)
{
	if (token->type == NUM)
	{
		printf("%d", *((int*)(token->value)));
	}
	else if (token->type == ADD)
	{
		printf("+");
	}
	else if (token->type == SUB)
	{
		printf("-");
	}
	else if (token->type == MUL)
	{
		printf("*");
	}
	else if (token->type == DIV)
	{
		printf("/");
	}
	else if (token->type == LPARN)
	{
		printf("(");
	}
	else if (token->type == RPARN)
	{
		printf(")");
	}
	else if (token->type == PRINT)
	{
		printf("print");
	}
	else if (token->type == ENDL)
	{
		printf("endl");
	}
	else
	{
		printf("ERROR");
	}
}
