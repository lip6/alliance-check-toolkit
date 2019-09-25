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

typedef enum { typeCon, typeId, typeOpr } nodeEnum;

/* constants */
typedef struct {
    nodeEnum type;              /* type of node */
    int value;                  /* value of constant */
} conNodeType;

/* identifiers */
typedef struct {
    nodeEnum type;              /* type of node */
    int i;                      /* subscript to ident array */
} idNodeType;

/* operators */
typedef struct {
    nodeEnum type;              /* type of node */
    int oper;                   /* operator */
    int nops;                   /* number of operands */
    union nodeTypeTag *op[1];   /* operands (expandable) */
} oprNodeType;

typedef union nodeTypeTag {
    nodeEnum type;              /* type of node */
    conNodeType con;            /* constants */
    idNodeType id;              /* identifiers */
    oprNodeType opr;            /* operators */
} nodeType;

extern int sym[65536];
