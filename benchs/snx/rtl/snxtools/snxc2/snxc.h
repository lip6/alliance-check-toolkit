/******************************************

  Simple 16bit Non-Pipeline Processor (SN/X) V1.2
  Compiler source code.

  (C)Copyright by Naohiko Shimizu, 2001-2005
  All rights are reserved.

  Contact information:
  Dr. Naohiko Shimizu

    IP Architecture Laboratory
    Email: nshimizu@ip-arch.jp
    URL: http://www.ip-arch.jp/
  
  Update informations:

    10-Sep-2005: Language specification extended, SHMZ
    04-Aug-2002: modified for PARTHENON lecture
******************************************/

#ifndef DATAOFFSET
#define DATAOFFSET 0x200
#endif
// #define DATAOFFSET 0x0000

typedef enum { typeCon, typeId, typeOpr } nodeType;
typedef enum { local, argument, global, func, isr } idtype;

struct node {
    char *sym;
    int  id;
    int  array;
    idtype  type;
    struct node *node;
};

/* constants */
typedef struct {
    nodeType type;              /* type of node */
    int value;                  /* value of constant */
} Const;

/* identifiers */
typedef struct {
    nodeType type;              /* type of node */
    struct node *node;          /* subscript to ident array */
} Ident;

/* operators */
typedef struct {
    nodeType type;              /* type of node */
    int oper;                   /* operator */
    int nops;                   /* number of operands */
    union PnodeTag *op[1];   /* operands (expandable) */
} Operator;

typedef union PnodeTag {
    nodeType type;              /* type of node */
    Const con;            /* constants */
    Ident id;              /* identifiers */
    Operator opr;            /* operators */
} Pnode;

void flushlocal();
void lregist(char *s);
void aregist(char *s);
void yyerror(char *s);
