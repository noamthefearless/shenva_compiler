#pragma once
#ifndef TOKENGETTER_H  
#define TOKENGETTER_H
#include <stdio.h>
struct node;
typedef struct node* llist;

#ifdef DEBUG
# define DEBUG_PRINT(x) printf x
#else
# define DEBUG_PRINT(x) do {} while (0)
#endif



enum TokenTypes {ERROR = '0', NUM = '1', ADD = '2',SUB = '3', 
				 MUL = '4', DIV = '5', LPARN = '6', RPARN = '7', 
				 PRINT = '8', ENDL = '9'};

#endif 

struct Token
{
	enum TokenTypes type;
	void* value;
} typedef Token;




llist* extractToken(FILE* file, FILE* logFile);
void printTokensToLog(llist list, FILE* file);
void printToken(Token* token);



