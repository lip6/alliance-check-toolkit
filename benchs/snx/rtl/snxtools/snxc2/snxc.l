/******************************************

  Simple 16bit Non-Pipeline Processor (SN/X) V1.3
  Compiler source code.

  (C)Copyright by Naohiko Shimizu, 2001-2011
  All rights are reserved.

  Contact information:
  Dr. Naohiko Shimizu

    IP Architecture Laboratory
    Email: nshimizu@ip-arch.jp
    URL: http://www.ip-arch.jp/
  
  Update informations:

    15-Sep-2011: array, break, comments, etc. added, SHMZ
    10-Sep-2005: Language specification extended, SHMZ
    04-Aug-2002: modified for PARTHENON lecture
******************************************/

%{
#include <stdlib.h>
#include <string.h>
#include "snxc.h"
#include "y.tab.h"
#define MAXSYMBOL 65536

void yyerror(char *s);
int htoi(char *s);
struct node *slookup(char *s);
int Line = 1;
int LineBak ;
FILE *yyinbak = NULL;
extern FILE *yyin;
YY_BUFFER_STATE bstate;
%}
%start COMM INCLUDE

digit	[0-9]
integer	{digit}({digit})*
hexdigit	[0-9A-Fa-f]
hexdecimal	0[xX]{hexdigit}({hexdigit})*
symbols		[_a-zA-Z][_a-zA-Z0-9]*
%%

"//".*$	; // comments
<INITIAL>"/*"		{ BEGIN COMM;}
<COMM>"*/"	{ BEGIN INITIAL;}
<COMM>.		;
<INITIAL>"#include" {BEGIN INCLUDE;}
<INCLUDE>[ \t\r\n] ;
<INCLUDE>["].*["]	{
	char *filename;
	filename=(char*)calloc(strlen(yytext),sizeof(char));
	memcpy(filename, &yytext[1], strlen(yytext)-2);
	if(yyinbak) yyerror("include nesting");
	yyinbak = yyin;	
	LineBak=Line;
	bstate = YY_CURRENT_BUFFER;
	yyin = fopen(filename,"r");
	if(!yyin) yyerror("file open error");
	Line = 1;
	yy_switch_to_buffer(yy_create_buffer(yyin, YY_BUF_SIZE));
	BEGIN INITIAL;
	}

<INITIAL>{integer} {
                yylval.IntVal = atoi(yytext);
                return INTEGER;
            }

<INITIAL>{hexdecimal}      {
                yylval.IntVal = htoi(&yytext[2]);
                return INTEGER;
            }

<INITIAL>[-()<>=+*&|~/;{},.\[\]] {
                return *yytext;
             }

<INITIAL>"&&"            return LAND;
<INITIAL>"||"            return LOR;
<INITIAL>">>"            return RSHIFT;
<INITIAL>"<<"            return LSHIFT;
<INITIAL>"++"            return PP;
<INITIAL>"--"            return MM;
<INITIAL>">="            return GE;
<INITIAL>"<="            return LE;
<INITIAL>"=="            return EQ;
<INITIAL>"!="            return NE;
<INITIAL>"interrupt"     return INTER;
<INITIAL>"for"           return FOR;
<INITIAL>"while"         return WHILE;
<INITIAL>"if"            return IF;
<INITIAL>"else"          return ELSE;
<INITIAL>"return"        return RETURN;
<INITIAL>"break"         return BREAK;
<INITIAL>"print"         return PRINT;
<INITIAL>"mem"           return MEM;
<INITIAL>"void"          return DEF;
<INITIAL>"int"           return DEF;
<INITIAL>"halt"          return HALT;

<INITIAL>{symbols}       { 
                yylval.Index = slookup(yytext);
		if(yylval.Index->type == func)
			return FUNCNAME;
		else
			return SYMBOL;
            }

[ \t\r]+        ;       /* ignore whitespace */
[\n]		Line++;

<INITIAL>.               yyerror("Unknown character");
%%
int yywrap(void) {
    fclose(yyin);
    if(yyinbak) {
	yy_switch_to_buffer(bstate);
	Line=LineBak;
	yyinbak=NULL;
	return 0;
    }
    else
	    return 1;
}

static struct node *stable=NULL;
static struct node *ltable=NULL;
static struct node *atable=NULL;
static int localid=0;
static int argid=0;

void flushlocal() {
  struct node *p=ltable;
  while(p) {
    ltable=p->node;
    free(p->sym);
    free(p);
    p=ltable;
  }
  localid=0;
  while(p) {
    atable=p->node;
    free(p->sym);
    free(p);
    p=atable;
  }
  argid=0;
}

void lregist(char *s) {
  struct node *p;
  p=(struct node*)malloc(sizeof(struct node));
  p->sym=(char *)malloc(strlen(s)+1);
  strcpy(p->sym,s);
  p->id = localid++;
  p->node = ltable;
  p->type = local;
  p->array = 0;
  ltable=p;
}

void aregist(char *s) {
  struct node *p;
  p=(struct node*)malloc(sizeof(struct node));
  p->sym=(char *)malloc(strlen(s)+1);
  strcpy(p->sym,s);
  p->id = argid++;
  p->node = atable;
  p->type = argument;
  p->array = 0;
  atable=p;
}

int idindex=DATAOFFSET;
struct node *slookup(char *s) {
  struct node *p;
  int i;

  if(!stable) {
     char x[2];
     for(i='a'; i<='z'; i++) {
        x[0]=i;x[1]=0;
	p=(struct node*)malloc(sizeof(struct node));
	p->sym=(char *)malloc(strlen(x)+1);
	strcpy(p->sym,x);
	p->id = idindex++;
	p->node = stable;
        p->type = global;
        p->array = 1;
	stable=p;
        }
     }
  p=ltable;
  while(p) {
    if(!strcmp(s,p->sym)) return(p);
     p=p->node; 
     }
  p=atable;
  while(p) {
    if(!strcmp(s,p->sym)) return(p);
     p=p->node; 
     }
  p=stable;
  while(p) {
    if(!strcmp(s,p->sym)) return(p);
     p=p->node; 
     }
  p=(struct node*)malloc(sizeof(struct node));
  p->sym=(char *)malloc(strlen(s)+1);
  strcpy(p->sym,s);
  p->id = idindex++;
  p->node = stable;
  p->type = global;
  stable=p;
  return(p);
}

int htoi(char *s) {
  int value = 0;
  char c;
  while((c=*s) != 0) {
    value = value<<4;
    c=c-48; 
    if(c<10) value +=c;
    else {
	c=c-7;
	if(c<16) value +=c;
	else value += (c-32);
    }
   s++;
  }
  return value;
}
  
