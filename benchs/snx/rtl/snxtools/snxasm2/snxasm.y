/******************************************

  Simple 16bit Non-Pipeline Processor (SN/X) V1.1
  Assembler source code.

  (C)Copyright by Naohiko Shimizu, 2001-2005
  All rights are reserved.

  Contact information:
  Dr. Naohiko Shimizu

  IP Architecture Laboratory
  Email: nshimizu@ip-arch.jp
  URL: http://www.ip-arch.jp/
  
  Update informations:

    21-Aug-2011: AHI instruction support / long label with AHI support
    11-Aug-2005: modified for Altera on chip memory(Intel HEX)
    04-Aug-2002: modified for PARTHENON lecture
******************************************/

%{
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "snxasm.h"

#define LABELMAX 1000
#define DATAOFF	0x1000

/* prototypes */
nodeType *opr(int oper, int nops, ...);
nodeType *id(int i);
nodeType *con(int value);
void freeNode(nodeType *p);
void sinit();
void dump();
int ex(nodeType *p, int reg, int pres);

void yyerror(char *s);

typedef   enum {unused, linked, defined} status;
typedef struct {
   status stat;
   unsigned int data;
   void *link;
} labelp;

labelp labeltable[LABELMAX];
static unsigned int pc = 0;
static labelp imem[65536];
static enum {Seconds, Intel, Hex, Binary} fmt;
int Line = 1;
%}

%union {
    int iValue;                 /* integer value */
    nodeType *nPtr;             /* node pointer */
};

%token <iValue> INTEGER REG LABEL RTYPE RTYPE1 RTYPE0 CTYPE0 ITYPE
%token DEFLBL

%type <nPtr> stmt

%%

program:
        init function                { dump(); exit(0); }
        ;

init:
        /* NULL */  	                { sinit();}
        ;

function:
          function stmt                 { ex($2,1,0);  }
        | /* NULL */
        ;

stmt:
          '\n'                           { $$ = opr(';', 2, NULL, NULL); }
        | LABEL ':'                      { $$ = opr(DEFLBL, 1, con($1)); }
        | ITYPE REG ',' INTEGER '(' REG ')' '\n'
               { $$ = opr(ITYPE,4, con($1), con($2), con($4), con($6)); }
        | ITYPE REG ',' LABEL '\n'
               { $$ = opr(ITYPE,3, con($1), con($2), con($4)); }
        | CTYPE0 '\n'
               { $$ = opr(CTYPE0,1, con($1)); }
        | RTYPE0 '\n'
               { $$ = opr(RTYPE0,1, con($1)); }
        | RTYPE1 REG ',' REG '\n'
               { $$ = opr(RTYPE1,3, con($1), con($2), id($4)); }
        | RTYPE REG ',' REG ',' REG '\n'
             { $$ = opr(RTYPE,4, con($1), con($2), con($4), con($6)); }
        ;



%%

nodeType *con(int value) {
    nodeType *p;

    /* allocate node */
    if ((p = malloc(sizeof(conNodeType))) == NULL)
        yyerror("out of memory");

    /* copy information */
    p->type = typeCon;
    p->con.value = value;

    return p;
}

nodeType *id(int i) {
    nodeType *p;

    /* allocate node */
    if ((p = malloc(sizeof(idNodeType))) == NULL)
        yyerror("out of memory");

    /* copy information */
    p->type = typeId;
    p->id.i = i;

    return p;
}

nodeType *opr(int oper, int nops, ...) {
    va_list ap;
    nodeType *p;
    size_t size;
    int i;

    /* allocate node */
    size = sizeof(oprNodeType) + (nops - 1) * sizeof(nodeType*);
    if ((p = malloc(size)) == NULL)
        yyerror("out of memory");

    /* copy information */
    p->type = typeOpr;
    p->opr.oper = oper;
    p->opr.nops = nops;
    va_start(ap, nops);
    for (i = 0; i < nops; i++)
        p->opr.op[i] = va_arg(ap, nodeType*);
    va_end(ap);
    return p;
}

void freeNode(nodeType *p) {
    int i;

    if (!p) return;
    if (p->type == typeOpr) {
        for (i = 0; i < p->opr.nops; i++)
            freeNode(p->opr.op[i]);
    }
    free (p);
}

void yyerror(char *s) {
    extern char * yytext;
    fprintf(stderr, "%s (%s) at %d\n", s, yytext, Line);
}

int main(int argc, char *argv[]) {
    if(argc == 2) {
      switch(argv[1][0]) {
      case 's': fmt=Seconds; break;
      case 'i': fmt=Intel; break;
      case 'b': fmt=Binary; break;
      default:  fmt=Hex; break;
      }
    }
    else fmt=Hex;
    yyparse();
    return 0;
}

void sinit() {
int i;
 for(i=0;i<LABELMAX;i++) {
   labeltable[i].stat = unused;
   labeltable[i].link = NULL;
   }
}

int ex(nodeType *p, int reg, int pres) {
 labelp *link;
 int id;
 if(!p) return 0;
 if(p->type != typeOpr) return 1;
 switch(p->opr.oper) {
  case ITYPE:
       if(p->opr.nops == 4) {
              imem[pc].data =
              (p->opr.op[0]->con.value <<12) + 
              (p->opr.op[1]->con.value <<10) +
              (p->opr.op[2]->con.value & 0xff) +
              (p->opr.op[3]->con.value <<8);
              pc += 1; break;
            }
       else {
              imem[pc].data = 0xb400;
              imem[pc+1].data =
              (p->opr.op[0]->con.value <<12) + 
              (p->opr.op[1]->con.value <<10) + (1<<8);
              id = p->opr.op[2]->con.value;
              if(labeltable[id].stat == defined) {
                imem[pc].data += (labeltable[id].data >> 8) + ((labeltable[id].data&0x80)==0x80);
                imem[pc+1].data += labeltable[id].data&0xff;
		}
              else {
                imem[pc].link = labeltable[id].link;
                labeltable[id].link = &imem[pc];
                labeltable[id].stat = linked;
              }
              pc += 2; break;
            }
  case RTYPE:
              imem[pc].data =
              (p->opr.op[0]->con.value ) + 
              (p->opr.op[2]->con.value <<10) +
              (p->opr.op[3]->con.value <<8)  +
              (p->opr.op[1]->con.value <<6);
              pc += 1; break;
  case RTYPE1:
              imem[pc].data =
              (p->opr.op[0]->con.value ) + 
              (p->opr.op[2]->con.value <<10) +
              (p->opr.op[1]->con.value <<6);
              pc += 1; break;
  case RTYPE0:
              imem[pc].data =
              (p->opr.op[0]->con.value );
              pc += 1; break;
  case CTYPE0:
              imem[pc].data =
              (0x1 <<12) + 
              (p->opr.op[0]->con.value );
              pc += 1; break;
  case DEFLBL:
              id = p->opr.op[0]->con.value;
              labeltable[id].stat = defined;
              labeltable[id].data = pc;
              link = labeltable[id].link;
              while(link != NULL) {
                link->data += (pc>>8) + ((pc&0x80)==0x80);
                (link+1)->data += pc&0xff;
                link = link->link;
              }
              break;
 }
return 0;
}

void dump() {
int i;
 for(i=0;i<LABELMAX;i++) {
	if(labeltable[i].stat==linked)
		yyerror("Label not defined");
	}
for(i=0; i<pc; i++) {
switch(fmt) {
case Intel:
 printf(":02%04X00%04X%02X\n", i, imem[i].data, 
      (-(2 + (i>>8) + ((i) & 0xff) + (imem[i].data&0xff) + (imem[i].data>>8)))&0xff);
/*
 printf(":01%04X00%02X%02X\n", (i<<1)+1, imem[i].data >>8,
      (-(1 + (((i<<1)+1)>>8) + (((i<<1)+1) & 0xff) + (imem[i].data>>8)))&0xff);
*/
 break;
case Seconds:
 printf("memset iram1/cell X%02x X%02x\n", i, imem[i].data >> 8);
 printf("memset iram2/cell X%02x X%02x\n", i, imem[i].data & 0xff);
 break;
case Binary:
 printf("%c", imem[i].data & 0xff);
 printf("%c", imem[i].data >> 8);
 break;
case Hex:
 printf("%04X ", imem[i].data);
 if((i&7)==7) printf("\n");
 break;
 }
 }
if(fmt==Intel) printf(":00000001FF\n");
if(fmt==Binary) for(i=i;i<128;i++) printf("%c%c",'\0','\0');
}
