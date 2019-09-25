/******************************************

  Simple 16bit Non-Pipeline Processor (SN/X) V1.1
  Assembler source code.

  (C)Copyright by Naohiko Shimizu, 2001, 2002.
  All rights are reserved.

  Contact information:
  Dr. Naohiko Shimizu

  IP Architecture Laboratory
  Email: nshimizu@ip-arch.jp
  URL: http://www.ip-arch.jp/

  
  Update informations:

    04-Aug-2002: modified for PARTHENON lecture
******************************************/

%{
#include <stdlib.h>
#include "snxasm.h"
#include "y.tab.h"
void yyerror(char *s);
int symbol_lookup(char *s);
extern int Line;
%}

uletter	[A-Z]
lletter	[a-z]
letter	({uletter}|{lletter})
digit	[0-9]
name	{letter}(_?({letter}|{digit}))*_?
integer	{digit}({digit})*

%%


{integer}      {
                yylval.iValue = atoi(yytext);
                return INTEGER;
            }
"-"{integer}      {
                yylval.iValue = atoi(yytext);
                return INTEGER;
            }
"$"[0-3]    {
                yylval.iValue = atoi(yytext+1);
                return REG;
            }


[,():] {
                return *yytext;
             }

[\n] {
                Line++; return *yytext;
             }

"ld"|"LD"            {
                yylval.iValue = 8;
                return ITYPE;
             }
"st"|"ST"            {
                yylval.iValue = 9;
                return ITYPE;
             }
"lda"|"LDA"           {
                yylval.iValue = 10;
                return ITYPE;
             }
"ahi"|"AHI"           {
                yylval.iValue = 11;
                return ITYPE;
             }
"bz"|"BZ"            {
                yylval.iValue = 14;
                return ITYPE;
             }
"bal"|"BAL"           {
                yylval.iValue = 15;
                return ITYPE;
             }
"in"|"IN"            {
                yylval.iValue = 12;
                return ITYPE;
             }
"out"|"OUT"           {
                yylval.iValue = 13;
                return ITYPE;
             }
"add"|"ADD"           {
                yylval.iValue = 0;
                return RTYPE;
             }
"sub"|"SUB"           {
                yylval.iValue = 2;
                return RTYPE;
             }
"and"|"AND"           {
                yylval.iValue = 1;
                return RTYPE;
             }
"slt"|"SLT"           {
                yylval.iValue = 3;
                return RTYPE;
             }
"not"|"NOT"           {
                yylval.iValue = 4;
                return RTYPE1;
             }
"sr"|"SR"            {
                yylval.iValue = 6;
                return RTYPE1;
             }
"iret"|"IRET"            {
                yylval.iValue = 6;
                return CTYPE0;
             }
"hlt"|"HLT"            {
                yylval.iValue = 7;
                return CTYPE0;
             }
{name}  { 
                yylval.iValue = symbol_lookup(yytext);
                return LABEL;
            }


[ \t]+        ;       /* ignore whitespace */
";".*$      ;       /* ignore comments */

.               yyerror("Unknown character");
%%
int yywrap(void) {
    return 1;
}
typedef struct {
	char	*s;
	int	id;
	void	*link;
} sym_entry;

sym_entry *symboltable=NULL;
int symbolid=0;

int symbol_lookup(char *s) {
	sym_entry *p;
	p=symboltable;
	while(p) {
		if(!strcmp(s,p->s)) return p->id;
		p=p->link;
	}
	p=(sym_entry *)malloc(sizeof(sym_entry));
	p->s=(char*)malloc(strlen(s)+1);
	memcpy(p->s,s,strlen(s)+1);
	p->link=symboltable;
	p->id=symbolid++;
	symboltable=p;
	return p->id;
}
