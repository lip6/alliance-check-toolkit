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

    15-Sep-2011: array, break, etc. added, SHMZ
    10-Sep-2005: Language specification extended, SHMZ
    04-Aug-2002: modified for PARTHENON lecture
******************************************/

%{
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include "snxc.h"
#define YYDEBUG 1
#ifndef STACKTOP
#define STACKTOP 4095
#endif

/* prototypes */
Pnode *opr(int oper, int nops, ...);
Pnode *id(struct node *node);
Pnode *con(int value);
struct node *slookup(char *s);
void freeNode(Pnode *p);
void sinit(int val);
int ex(Pnode *p, int reg, int pres);
extern int Line, idindex;
extern char * yytext;

void yyerror(char *s);
void debug(Pnode *p) {}
%}

%union {
    int IntVal;                 /* integer value */
    char Symbol;                /* symbol table index */
    struct node *Index;                  /* symbol table index */
    Pnode *Node;                /* node pointer */
};

%token <IntVal> INTEGER
%token <Index> SYMBOL FUNCNAME
%token INTER WHILE FOR IF PRINT MRD MWT MEM FDEF RETURN FUNC BREAK
%token DEF FDEFA HALT LOCAL EA NOP
%nonassoc IFX
%nonassoc ELSE

%left LOR
%left LAND
%left GE LE EQ NE '>' '<' '|'
%left '+' '-'
%left '*' '/' '&'
%right UMINUS '~'
%left MM PP RSHIFT LSHIFT
%type <Node> astmt stmt expr stmt_list a_list l_list v_list l_def defun
%type <Index> VARIABLE defundec defisrdec

%%

program:
        init function                { exit(0); }
        ;

init:
        /* NULL */  	                { sinit(STACKTOP);}
        ;

function:
          function stmt                 { debug($2); ex($2,1,0);  }
        | function defun                 { debug($2); ex($2,1,0);   flushlocal();}
        | /* NULL */
        ;

defundec:
	DEF SYMBOL		{ $$ = $2; }
	| DEF FUNCNAME		{ $$ = $2; }
	;
defisrdec:
	INTER SYMBOL	{ $$ = $2; }
	;
defun:
          defundec '(' a_list ')' '{' l_def stmt_list '}'  { 
		$1->type = func;
		$$ = opr(FDEFA,4, id(slookup($1->sym)), $7, $3, $6); }
        | defundec '(' ')' '{' l_def stmt_list '}'         {
		$1->type = func;
		$$ = opr(FDEF, 3, id(slookup($1->sym)), $6, $5); 
		debug($5);
	}
        | defundec '(' ')' ';'          {
		$1->type = func;
		$$ = opr(NOP, 0 ); 
	}
        | defundec '(' a_list ')' ';'          {
		$1->type = func;
		$$ = opr(NOP, 0 ); 
	}
        | defisrdec '(' ')' '{' l_def stmt_list '}'         {
		$1->type = isr;
		$$ = opr(INTER, 3, id(slookup($1->sym)), $6, $5); 
		debug($5);
	}
	;

stmt:
          ';'                            { $$ = opr(';', 2, NULL, NULL); }
        | astmt ';'                       { $$ = $1; }
        | DEF VARIABLE '[' INTEGER ']' ';'                       { $$ = opr(';',2,NULL,NULL); slookup($2->sym)->array=1; idindex += $4; }
        | PRINT expr ';'                 { $$ = opr(PRINT, 1, $2); }
        | FOR '(' astmt ';' expr ';' astmt ')' stmt  
               { $$ = opr(FOR, 4, $3, $5, $7, $9); }
        | WHILE '(' expr ')' stmt        { $$ = opr(WHILE, 2, $3, $5); }
        | RETURN expr ';'                { $$ = opr(RETURN, 1, $2); }
        | RETURN ';'                     { $$ = opr(RETURN, 0); }
        | BREAK ';'                     { $$ = opr(BREAK, 0); }
        | IF '(' expr ')' stmt %prec IFX { $$ = opr(IF, 2, $3, $5); }
        | IF '(' expr ')' stmt ELSE stmt { $$ = opr(IF, 3, $3, $5, $7); }
        | '{' stmt_list '}'              { $$ = $2; }
        | HALT ';'                       { $$ = opr(HALT, 0); }
        ;

l_def:
	{ $$ = NULL; }
	| l_def DEF l_list ';' { Pnode *x=$3;
		while(x->opr.op[1]) x=x->opr.op[1];
		x->opr.op[1]=$1;
		$$ = $3; }
	;

l_list:
	  VARIABLE { lregist($1->sym); $$=opr(',', 2, id(slookup($1->sym)), NULL); }
	| l_list ',' VARIABLE { lregist($3->sym); $$=opr(',',2,id(slookup($3->sym)), $1); }
	;

a_list:
	  DEF VARIABLE { aregist($2->sym); $$=opr(',', 2, id(slookup($2->sym)), NULL); }
	| VARIABLE { aregist($1->sym); $$=opr(',', 2, id(slookup($1->sym)), NULL); }
	| a_list ',' VARIABLE { Pnode *x=$1;
		aregist($3->sym); 
		while(x->opr.op[1]) x=x->opr.op[1];
		x->opr.op[1]=opr(',',2,id(slookup($3->sym)), NULL);
		$$= $1; }
	| a_list ',' DEF VARIABLE { Pnode *x=$1;
		aregist($4->sym); 
		while(x->opr.op[1]) x=x->opr.op[1];
		x->opr.op[1]=opr(',',2,id(slookup($4->sym)), NULL);
		$$= $1; }
	;

astmt:
          expr                        { $$ = $1; }
        | MEM '[' expr ']' '=' expr   { $$ = opr(MWT, 2, $3, $6); }
        | MEM '[' expr ']' PP   { $$ = opr(MWT, 2, $3, opr('+',2,con(1),opr(MRD,1,$3))); }
        | MEM '[' expr ']' MM   { $$ = opr(MWT, 2, $3, opr('-',2,opr(MRD,1,$3),con(1))); }
        | VARIABLE '=' expr           { $$ = opr('=', 2, id(slookup($1->sym)), $3); }
        | '*' expr %prec UMINUS '=' expr           { $$ = opr(MWT, 2, $2, $4); }
        | VARIABLE  PP   { $$ = opr('=',2,id(slookup($1->sym)),opr('+',2,id(slookup($1->sym)),con(1))); }
        | VARIABLE  MM   { $$ = opr('=',2,id(slookup($1->sym)),opr('-',2,id(slookup($1->sym)),con(1))); }
        | VARIABLE '[' expr ']' PP   { $$ = opr(MWT,3,$3,opr('+',2,opr(MRD, 2, $3, id(slookup($1->sym))),con(1)),id(slookup($1->sym))); 
		if(!slookup($1->sym)->array) yyerror("not defined as array\n");
	}
        | VARIABLE '[' expr ']' MM   { $$ = opr(MWT,3,$3,opr('-',2,opr(MRD, 2, $3, id(slookup($1->sym))),con(1)),id(slookup($1->sym))); 
		if(!slookup($1->sym)->array) yyerror("not defined as array\n");
}
        | VARIABLE '[' expr ']' '=' expr   { $$ = opr(MWT, 3, $3, $6, id(slookup($1->sym))); 
		if(!slookup($1->sym)->array) yyerror("not defined as array\n");
}
        ;

stmt_list:
          stmt                  { $$ = $1; }
        | stmt_list stmt        { $$ = opr(';', 2, $1, $2); }
        ;

v_list:
	  expr { $$=opr(',', 2, NULL, $1); }
	| v_list ',' expr { $$=opr(',', 2, $1, $3); }
	;

expr:
          INTEGER               { $$ = con($1); }
        | VARIABLE              { $$ = id(slookup($1->sym)); }
        | FUNCNAME              { $$ = opr(EA, 1, id(slookup($1->sym))); }
        | '-' expr %prec UMINUS { $$ = opr(UMINUS, 1, $2); }
        | '~' expr %prec UMINUS { $$ = opr('~', 1, $2); }
        | '&' VARIABLE %prec UMINUS { $$ = opr(EA, 1, id(slookup($2->sym))); }
        | '*' expr %prec UMINUS { $$ = opr(MRD, 1, $2); }
        | MEM '[' expr ']'      { $$ = opr(MRD, 1, $3); }
        | VARIABLE '[' expr ']' { $$ = opr(MRD, 2, $3, id(slookup($1->sym))); 
		if(!slookup($1->sym)->array) yyerror("not defined as array\n");
}
        | FUNCNAME '(' v_list ')' { $$ = opr(FUNC, 2, id(slookup($1->sym)), $3); }
        | FUNCNAME '(' ')'      { $$ = opr(FUNC, 1, id(slookup($1->sym))); }
        | VARIABLE '(' v_list ')' { $$ = opr(FUNC, 2, id(slookup($1->sym)), $3); }
        | VARIABLE '(' ')'      { $$ = opr(FUNC, 1, id(slookup($1->sym))); }
        | expr '&' expr         { $$ = opr('&', 2, $1, $3); }
        | expr '|' expr         { $$ = opr('|', 2, $1, $3); }
        | expr '*' expr         { $$ = opr('*', 2, $1, $3); }
        | expr '+' expr         { $$ = opr('+', 2, $1, $3); }
        | expr '-' expr         { $$ = opr('-', 2, $1, $3); }
        | expr '<' expr         { $$ = opr('<', 2, $1, $3); }
        | expr '>' expr         { $$ = opr('>', 2, $1, $3); }
        | expr LAND expr        { $$ = opr(LAND, 2, $1, $3); }
        | expr LOR expr         { $$ = opr(LOR, 2, $1, $3); }
        | expr GE expr          { $$ = opr(GE, 2, $1, $3); }
        | expr LE expr          { $$ = opr(LE, 2, $1, $3); }
        | expr NE expr          { $$ = opr(NE, 2, $1, $3); }
        | expr EQ expr          { $$ = opr(EQ, 2, $1, $3); }
        | expr RSHIFT expr          { $$ = opr(RSHIFT, 2, $1, $3); }
        | expr LSHIFT expr          { $$ = opr(LSHIFT, 2, $1, $3); }
        | '(' expr ')'          { $$ = $2; }
        ;

VARIABLE:
	SYMBOL		{ $$ = $1; }
	;

%%

Pnode *con(int value) {
    Pnode *p;

    /* allocate node */
    if ((p = malloc(sizeof(Const))) == NULL)
        yyerror("out of memory");

    /* copy information */
    p->type = typeCon;
    p->con.value = value;

    return p;
}

Pnode *id(struct node *node) {
    Pnode *p;

    /* allocate node */
    if ((p = malloc(sizeof(Ident))) == NULL)
        yyerror("out of memory");

    /* copy information */
    p->type = typeId;
    p->id.node = node;
    return p;
}

Pnode *opr(int oper, int nops, ...) {
    va_list ap;
    Pnode *p;
    size_t size;
    int i;

    /* allocate node */
    size = sizeof(Operator) + (nops - 1) * sizeof(Pnode*);
    if ((p = malloc(size)) == NULL)
        yyerror("out of memory");

    /* copy information */
    p->type = typeOpr;
    p->opr.oper = oper;
    p->opr.nops = nops;
    va_start(ap, nops);
    for (i = 0; i < nops; i++)
        p->opr.op[i] = va_arg(ap, Pnode*);
    va_end(ap);
    return p;
}

void freeNode(Pnode *p) {
    int i;

    if (!p) return;
    if (p->type == typeOpr) {
        for (i = 0; i < p->opr.nops; i++)
            freeNode(p->opr.op[i]);
    }
    free (p);
}

void yyerror(char *s) {
    fprintf(stdout, "%s(%s) at %d\n", s, yytext, Line);
    exit(1);
}

extern int yydebug;
extern FILE *yyin;
int main(int argc, char *argv[]) {
    int i=1;
    if(argc>i && !strcmp(argv[1],"-d")) {
	 yydebug=1;
	 i++;
    }
    if(argc>i) yyin=fopen(argv[i],"r");
    yyparse();
    return 0;
}
