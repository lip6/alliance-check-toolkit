/***********************************
  -- snxb1.c --
  Compiler source code for
  Simple 16bit Processor SN/X V1.3

  (C)Copyright by Naohiko Shimizu, 2001-2011
    All rights are reserved.

  Contact information: Dr. Naohiko Shimizu

    IP Architecture Laboratory
    Email: nshimizu@ip-arch.jp
    URL: http://www.ip-arch.jp/

    15-Sep-2011: array, break, etc. added, SHMZ
    21-Aug-2011: long label with AHI instruction support, SHMZ
    10-Sep-2005: Language specification extended, SHMZ
***********************************/
#include <stdio.h>
#include "snxc.h"
#include "y.tab.h"

static int lbl;
static int frametop = 0;
static int localoff = 0;

static int idadr(Pnode *p) {
//printf("idadr=%04x\n", p->id.node->id+1);
	return (p->id.node->id+1);
}

int BreakBuffer[10], BreakIndex=0, BreakFrame[10];

void rinst (char *op,int r1,
		int r2,int r3) {
  printf("\t%s\t$%d,\t$%d,\t$%d\n",
         op,r1,r2,r3);
}
void rinst2 (char *op,int r1,
		int r2) {
  printf("\t%s\t$%d,\t$%d\n",
         op,r1,r2);
}
void iinst (char *op, int r1,
		int i,int r2) {
  printf("\t%s\t$%d,\t%d($%d)\n",
           op,r1,i,r2);
}
void sinit(int value) {
  if(!(value>>7))
     iinst("lda", 3, value, 0); 
  else {
     if(value&128) {
	     iinst("lda", 3, value&255, 0); 
	     iinst("ahi", 3, (value>>8) + 1, 3); 
	}
	else {
	     iinst("lda", 3, value&255, 0); 
	     iinst("ahi", 3, value>>8, 3); 
	}
	
   }
  return;
  }

int localnum(Pnode *p) {
   int i=0;
   while(p) {
     i++;
     p=p->opr.op[1];
    }
   return i;
  }

int ex(Pnode *p,int reg,int pres) {
    int lbl1, lbl2, lbl3, lbl4, regx,
        i, value, workcount;
    static int funcend;
    Pnode *r;
 regx = 3 - reg;
 if (!p) return 0;
 switch(p->type) {
  case typeCon:       
  value = p->con.value;
  if(!(value>>7))
     iinst("lda", reg, value, 0); 
  else {
     if(value&128) {
	     iinst("lda", reg, value&255, 0); 
	     iinst("ahi", reg, (value>>8) + 1, reg); 
	}
	else {
	     iinst("lda", reg, value&255, 0); 
	     iinst("ahi", reg, value>>8, reg); 
	}
	
   }
   break;
  case typeId:        
   if(p->id.node->type==argument) {
	printf(";\targ:%s:%d\n",p->id.node->sym, p->id.node->id);
      iinst("ld", reg, p->id.node->id+1+frametop+localoff,3);
   }
   else if(p->id.node->type==local) {
	printf(";\tlocal:%s:%d\n",p->id.node->sym, p->id.node->id);
      iinst("ld", reg, p->id.node->id+1+frametop,3);
   }
   else if(p->id.node->type==isr) {
	   if(reg!=1) {
	    printf("; preserve to stack \n");
	    iinst("lda",3,-1,3);
	    iinst("st",regx,0,3);
	    frametop += 1;
	    }
		printf("\tlda\t$%d,\t%s\n", reg, p->id.node->sym);
	   if(reg!=1) {
	    printf("; relax stack \n");
	    iinst("ld",regx,0,3);
	    iinst("lda",3,1,3);
	    frametop -= 1;
	    }
   }
   else   {
	if(!(idadr(p)>>7))
		iinst("ld", reg, idadr(p),0);
	else
	if((idadr(p))&128) {
		iinst("lda", reg, idadr(p)&255, 0); 
		iinst("ahi", reg, (idadr(p)>>8) + 1, reg); 
		iinst("ld", reg, 0,reg);
	}
	else {
		iinst("lda", reg, idadr(p)&255, 0); 
		iinst("ahi", reg, idadr(p)>>8, reg); 
		iinst("ld", reg, 0,reg);
	}
   }
  break;
  case typeOpr:
  switch(p->opr.oper) {
   case NOP:
	break;
   case FDEFA:
   localoff=localnum(p->opr.op[3]);
   printf("\tbal\t$0,\tL%03d\n",
           lbl1=lbl++);
   funcend=lbl++;
   printf("%s:\n",p->opr.op[0]->id.node->sym);
   iinst("lda",3,-1-localoff,3);
   iinst("st",2,0,3);
   ex(p->opr.op[1], 1, 0);
   printf("L%03d:\n",funcend);
   iinst("ld",2,0,3);
   iinst("lda",3,1+localoff,3);
   iinst("bal",2,0,2);
   printf("L%03d:\n", lbl1);
   flushlocal();
   break;
   case FDEF:
   localoff=localnum(p->opr.op[2]);
   printf("\tbal\t$0,\tL%03d\n",
          lbl1=lbl++);
   funcend=lbl++;
   printf("%s:\n",p->opr.op[0]->id.node->sym);
   iinst("lda",3,-1-localoff,3);
   iinst("st",2,0,3);
   ex(p->opr.op[1], 1, 0);
   printf("L%03d:\n",funcend);
   iinst("ld",2,0,3);
   iinst("lda",3,1+localoff,3);
   iinst("bal",2,0,2);
   printf("L%03d:\n", lbl1);
   break;
   case INTER:
   localoff=localnum(p->opr.op[2]);
   printf("\tbal\t$0,\tL%03d\n",
          lbl1=lbl++);
   funcend=lbl++;
   printf("%s:\n",p->opr.op[0]->id.node->sym);
   iinst("lda",3,-3-localoff,3);
   iinst("st",2,0,3);
   iinst("st",1,1,3);
   iinst("st",0,2,3);
   ex(p->opr.op[1], 1, 0);
   printf("L%03d:\n",funcend);
   iinst("ld",0,2,3);
   iinst("ld",1,1,3);
   iinst("ld",2,0,3);
   iinst("lda",3,1+localoff,3);
   printf("\tiret\n");
   printf("L%03d:\n", lbl1);
   break;
   case RETURN:
   if (p->opr.nops > 0) {
    ex(p->opr.op[0], 1, 0);
   iinst("lda",0,0,1);
    }
   printf("\tbal\t$2,\tL%03d\n",funcend);
   BreakIndex=0;
   break;
   case FOR:
   ex(p->opr.op[0], reg,pres);
   printf("L%03d:\n", lbl1 = lbl++);
   ex(p->opr.op[1], reg,pres);
   iinst("lda",0,0,reg);
   printf("\tbz\t$%d,\tL%03d\n",
           0, lbl2 = lbl++);
   BreakBuffer[BreakIndex]=lbl2;
   BreakFrame[BreakIndex]=frametop;
   BreakIndex++;
   ex(p->opr.op[3], reg,pres);
   ex(p->opr.op[2], reg,pres);
   printf("\tbal\t$0,\tL%03d\n",
          lbl1);
   printf("L%03d:\n", lbl2);
   BreakIndex--;
   break;
   case WHILE:
   printf("L%03d:\n", lbl1 = lbl++);
   ex(p->opr.op[0], reg, pres);
   iinst("lda",0,0,reg);
   printf("\tbz\t$%d,\tL%03d\n",
           0, lbl2 = lbl++);
   BreakBuffer[BreakIndex]=lbl2;
   BreakFrame[BreakIndex]=frametop;
   BreakIndex++;
   ex(p->opr.op[1], reg, pres);
   printf("\tbal\t$0,\tL%03d\n",
           lbl1);
   printf("L%03d:\n", lbl2);
   BreakIndex--;
   break;
   case BREAK:
   if(BreakIndex==0) fprintf(stderr,"break is not inside a loop\n");
   if(BreakFrame[BreakIndex-1]!=frametop) {
	   iinst("lda",3,frametop-BreakFrame[BreakIndex-1],3);
	}
   printf("\tbal\t$0,\tL%03d\n",BreakBuffer[BreakIndex-1]);
   break;
   case HALT:
   printf("\thlt\n");
   break;
   case IF:
   reg=2;
   ex(p->opr.op[0], reg, pres);
   if (p->opr.nops > 2) {
                /* if else */
   iinst("lda",0,0,reg);
    printf("\tbz\t$%d,\tL%03d\n",
           0, lbl1 = lbl++);
    ex(p->opr.op[1], reg, pres);
    printf("\tbal\t$0,\tL%03d\n",
           lbl2 = lbl++);
    printf("L%03d:\n", lbl1);
    ex(p->opr.op[2], reg, pres);
    printf("L%03d:\n", lbl2);
    } else {
    /* if */
   iinst("lda",0,0,reg);
    printf("\tbz\t$%d,\tL%03d\n",
           0, lbl1 = lbl++);
    ex(p->opr.op[1],reg, pres);
    printf("L%03d:\n", lbl1);
    }
   break;
   case PRINT:     
   ex(p->opr.op[0],reg, pres);
	iinst("lda", regx, (DATAOFFSET)&255, 0); 
	iinst("ahi", regx, (DATAOFFSET)>>8, regx); 
	iinst("st", reg, 0,regx);
   //iinst("st",reg,0,0);
   break;
   case MWT:     
   ex(p->opr.op[0],reg, pres);
   ex(p->opr.op[1],regx, 1);
   if(p->opr.nops>2 && p->opr.op[2]->id.node->type!=global)
            yyerror("MWT:local array prohibited");
   if(p->opr.nops>2) {
   if(!(idadr(p->opr.op[2])>>7))
		iinst("st", regx, idadr(p->opr.op[2]),reg);
   else
	if((idadr(p->opr.op[2]))&128) {
		iinst("lda", reg, (idadr(p->opr.op[2]))&255, reg); 
		iinst("ahi", reg, ((idadr(p->opr.op[2]))>>8) + 1, reg); 
		iinst("st", regx, 0,reg);
	}
   else {
		iinst("lda", reg, (idadr(p->opr.op[2]))&255, reg); 
		iinst("ahi", reg, (idadr(p->opr.op[2]))>>8, reg); 
		iinst("st", regx, 0,reg);
	}
   }
   else
	   iinst("st", regx,  0, reg);
   break;
   case '=':       
   ex(p->opr.op[1],reg, pres);
   if(p->opr.op[0]->id.node->type==argument) {
	printf(";\targ:%s:%d\n",p->opr.op[0]->id.node->sym,p->opr.op[0]->id.node->id);
      iinst("st", reg, p->opr.op[0]->id.node->id+1+frametop+localoff,3);
   }
   else if(p->opr.op[0]->id.node->type==local) {
	printf(";\tlocal:%s:%d\n",p->opr.op[0]->id.node->sym,p->opr.op[0]->id.node->id);
      iinst("st", reg, p->opr.op[0]->id.node->id+1+frametop,3);
   }
   else  {
	if(!((idadr(p->opr.op[0]))>>7))
		iinst("st", reg, idadr(p->opr.op[0]),0);
	else
	if((idadr(p->opr.op[0]))&128) {
		iinst("lda", regx, (idadr(p->opr.op[0]))&255, 0); 
		iinst("ahi", regx, ((idadr(p->opr.op[0]))>>8) + 1, regx); 
		iinst("st", reg, 0,regx);
	}
	else {
		iinst("lda", regx, (idadr(p->opr.op[0]))&255, 0); 
		iinst("ahi", regx, (idadr(p->opr.op[0]))>>8, regx); 
		iinst("st", reg, 0,regx);
	}
   }
   break;
   case '~':    
   ex(p->opr.op[0],reg, pres);
   rinst2("not", reg,reg);
   break;
   case UMINUS:    
   ex(p->opr.op[0],reg, pres);
   rinst2("not", reg,reg);
   iinst("lda",reg,1,reg);
   break;
   case EA:    
	if((p->opr.op[0]->id.node->type==isr) ||
	(p->opr.op[0]->id.node->type==func)) {
	   if(pres) {
	    printf("; preserve to stack \n");
	    iinst("lda",3,-1,3);
	    iinst("st",regx,0,3);
	    frametop += 1;
	    }
	   if(reg!=1) {
	    printf("; preserve to stack \n");
	    iinst("lda",3,-1,3);
	    iinst("st",reg,0,3);
	    frametop += 1;
	    }
	    printf("\tlda\t$%d,\t%s\n", reg, p->opr.op[0]->id.node->sym);
	   if(reg!=1) {
	    printf("; relax stack \n");
	    iinst("ld",reg,0,3);
	    iinst("lda",3,1,3);
	    frametop -= 1;
	    }
	   if(pres) {
	    printf("; relax stack \n");
	    iinst("ld",regx,0,3);
	    iinst("lda",3,1,3);
	    frametop -= 1;
	    }
	}
	else {
		iinst("lda", reg, (idadr(p->opr.op[0]))&255, 0); 
		iinst("ahi", reg, (idadr(p->opr.op[0]))>>8, reg); 
	}
   break;
   case MRD:    
   ex(p->opr.op[0],reg, pres);
   if(p->opr.nops>1 && p->opr.op[1]->id.node->type!=global)
            yyerror("MRD:local array prohibited");
   if(p->opr.nops>1) {
	if(!((idadr(p->opr.op[1]))>>7))
		iinst("ld", reg, idadr(p->opr.op[1]),reg);
	else {
	   if(pres) {
	    printf("; preserve to stack \n");
	    iinst("lda",3,-1,3);
	    iinst("st",regx,0,3);
	    frametop += 1;
	    }
	if((idadr(p->opr.op[1]))&128) {
		iinst("lda", regx, (idadr(p->opr.op[1]))&255, reg); 
		iinst("ahi", regx, ((idadr(p->opr.op[1]))>>8) + 1, regx); 
		iinst("ld", reg, 0,regx);
	}
	else {
		iinst("lda", regx, (idadr(p->opr.op[1]))&255, reg); 
		iinst("ahi", regx, (idadr(p->opr.op[1]))>>8, regx); 
		iinst("ld", reg, 0,regx);
	}
	   if(pres) {
	    printf("; relax stack \n");
	    iinst("ld",regx,0,3);
	    iinst("lda",3,1,3);
	    frametop -= 1;
	    }
	}
    }
   else
   	iinst("ld", reg, 0,reg);
   break;
   case FUNC:    
   if(p->opr.op[0]->id.node->type != func) ex(p->opr.op[0], reg, pres);
   if(pres) {
    printf("; preserve to stack func\n");
    iinst("lda",3,-1,3);
    iinst("st",regx,0,3);
    frametop += 1;
    }
   workcount=0;
   if(p->opr.nops>1)  {
     r=p->opr.op[1];
     do {
    printf("; func arg to stack\n");
        ex(r->opr.op[1],1, 0);
        iinst("lda",3,-1,3);
        iinst("st",1,0,3);
        frametop += 1;
        workcount++;
        r=r->opr.op[0];
     } while(r);
     }
   if(p->opr.op[0]->id.node->type==func) {
	printf("; function call to symbol\n");
	   printf("\tbal\t$2,\t%s\n",p->opr.op[0]->id.node->sym);
   }
   else {
	printf("; function call to register\n");
	   printf("\tbal\t$2,\t0($%d)\n",reg);
   }
    rinst2("not",reg,0);
    rinst2("not",reg,reg);
   if(workcount) {
    printf("; func arg stack recover\n");
    iinst("lda",3,workcount,3);
    frametop -= workcount;
    }
   if(pres) {
    printf("; relax stack func\n");
    iinst("ld",regx,0,3);
    iinst("lda",3,1,3);
    frametop -= 1;
    }
   break;
   default:
   ex(p->opr.op[0], reg, pres);
   if(pres) {
    printf("; preserve to stack operators\n");
    iinst("lda",3,-1,3);
    iinst("st",regx,0,3);
    frametop += 1;
    }
   ex(p->opr.op[1], regx, 1);
   switch(p->opr.oper) {
   case '*':
	iinst("lda",3,-5,3);
	iinst("st",regx,0,3);
	iinst("st",reg,1,3);
	iinst("st",regx,2,3);
	iinst("st",reg,3,3);
	iinst("lda",0,0,0);
	iinst("st",0,4,3); /* pp = 0 */
	iinst("ahi",0,128,0);
	rinst("and",2,0,reg);
	printf("\tbz\t$%d,\tL%03d\n", 2, lbl1 = lbl++);
	iinst("ld",reg,1,3);
	rinst2("not",reg,reg);
	iinst("lda",reg,1,reg);
	iinst("st",reg,3,3);
	printf("L%03d:\n", lbl1);
	iinst("ld",regx,0,3);
	rinst("and",2,0,regx);
	printf("\tbz\t$%d,\tL%03d\n", 2, lbl2 = lbl++);
	iinst("ld",regx,0,3);
	rinst2("not",regx,regx);
	iinst("lda",regx,1,regx);
	iinst("st",regx,2,3);
	printf("L%03d:\n", lbl2);
	iinst("ld",2,2,3); /* regx */
	printf("\tbz\t$%d,\tL%03d\n", 2, lbl3 = lbl++);
	iinst("ld",1,4,3); /* pp */
	iinst("ld",2,3,3); /* reg */
	rinst("add",1,2,1);
	iinst("st",1,4,3);
	iinst("ld",1,2,3);
	iinst("lda",1,-1,1);
	iinst("st",1,2,3);
	printf("\tbal\t$1,\tL%03d\n", lbl2);
	printf("L%03d:\n", lbl3);
	iinst("ld",1,0,3);
	rinst2("not",1,1);
	iinst("ld",2,1,3);
	rinst("and",1,2,1);
	rinst2("not",1,1);
	iinst("ld",2,1,3);
	rinst2("not",2,2);
	iinst("st",1,1,3);
	iinst("ld",1,0,3);
	rinst("and",1,2,1);
	rinst2("not",1,1);
	iinst("ld",2,1,3);
	rinst("and",1,2,1);
	rinst2("not",1,1);
	rinst("and",2,0,1);
	printf("\tbz\t$%d,\tL%03d\n", 2, lbl4 = lbl++);
	iinst("ld",1,4,3); /* pp */
	rinst2("not",1,1);
	iinst("lda",1,1,1);
	iinst("st",1,4,3);
	printf("L%03d:\n", lbl4);
	iinst("ld",reg,4,3); /* pp */
	iinst("lda",3,5,3);
   break;
   case RSHIFT:
	if(p->opr.op[1]->type==typeCon) {
		for(i=0;i<p->opr.op[1]->con.value;i++) {
			rinst2("sr", reg,reg);
		}
	}
	else {
		iinst("lda",0,0,reg);
		iinst("lda",2,0,regx);
	    printf("L%03d:\n", lbl1 = lbl++);
	    printf("\tbz\t$%d,\tL%03d\n", 2, lbl2 = lbl++);
		rinst2("sr", 0,0);
		iinst("lda",2,-1,2);
		printf("\tbal\t$1,\tL%03d\n", lbl1);
	    printf("L%03d:\n", lbl2);
		rinst2("not", reg,0);
		rinst2("not", reg,reg);
	}
   break;
   case LSHIFT:
	if(p->opr.op[1]->type==typeCon) {
		for(i=0;i<p->opr.op[1]->con.value;i++) {
			rinst("add", reg,reg,reg);
		}
	}
	else {
		iinst("lda",0,0,reg);
		iinst("lda",2,0,regx);
	    printf("L%03d:\n", lbl1 = lbl++);
	    printf("\tbz\t$%d,\tL%03d\n", 2, lbl2 = lbl++);
		rinst("add", 0,0,0);
		iinst("lda",2,-1,2);
		printf("\tbal\t$1,\tL%03d\n", lbl1);
	    printf("L%03d:\n", lbl2);
		rinst2("not", reg,0);
		rinst2("not", reg,reg);
	}
   break;
    case '&':
    rinst("and",reg,reg,regx);
    break;
    case '|':
    rinst2("not", regx,regx);
    rinst2("not", reg,reg);
    rinst("and",reg,reg,regx);
    rinst2("not", reg,reg);
    break;
    case '+':
    rinst("add",reg,reg,regx);
    break;
    case '-':
    rinst2("not", regx,regx);
    iinst("lda",regx,1,regx);
    rinst("add",reg,reg,regx);
    break;
    case '<':
    rinst("slt",reg,reg,regx);
    break;
    case '>':
    rinst("slt",reg,regx,reg);
    break;
    case LE:
    rinst("slt",reg,regx,reg);
    rinst2("not", reg,reg);
    iinst("lda",reg,1,reg);
    iinst("lda",regx,1,0);
    rinst("add",reg,reg,regx);
    break;
    case GE:
    rinst("slt",reg,reg,regx);
    rinst2("not", reg,reg);
    iinst("lda",reg,1,reg);
    iinst("lda",regx,1,0);
    rinst("add",reg,reg,regx);
    break;
    case LAND:    
    iinst("lda",0,0,reg);
    iinst("lda",2,0,regx);
    printf("\tbz\t$%d,\tL%03d\n", 0, lbl1 = lbl++);
    printf("\tbz\t$%d,\tL%03d\n", 2, lbl1);
    iinst("lda",reg,1,0);
    if(reg==1) {
	    printf("; preserve to stack\n");
	    iinst("lda",3,-1,3);
	    iinst("st",reg,0,3);
	    frametop += 1;
    }
    printf("\tbal\t$0,\tL%03d\n", lbl2 = lbl++);
    printf("L%03d:\n", lbl1);
    iinst("lda",reg,0,0);
    if(reg==1) {
	    printf("; preserve to stack\n");
	    iinst("lda",3,-1,3);
	    iinst("st",reg,0,3);
	    frametop += 1;
    }
    printf("L%03d:\n", lbl2);
   if(reg==1) {
	    printf("; relax stack\n");
	    iinst("ld",reg,0,3);
	    iinst("lda",3,1,3);
	    frametop -= 1;
    }
    break;

    case LOR:    
    iinst("lda",0,0,reg);
    if(regx==1) {
	    printf("; preserve to stack\n");
	    iinst("lda",3,-1,3);
	    iinst("st",regx,0,3);
	    frametop += 1;
    }
    printf("\tbz\t$%d,\tL%03d\n", 0, lbl1 = lbl++);
    iinst("lda",2,1,0);
   if(regx==1) 
	    iinst("lda",3,1,3);
    printf("\tbal\t$0,\tL%03d\n", lbl2 = lbl++);
    printf("L%03d:\n", lbl1);
   if(regx==1) {
	    printf("; relax stack\n");
	    iinst("ld",regx,0,3);
	    iinst("lda",3,1,3);
	    frametop -= 1;
    }
    iinst("lda",2,0,regx);
    printf("\tbz\t$%d,\tL%03d\n", 2, lbl3 = lbl++);
    iinst("lda",2,1,0);
    printf("\tbal\t$0,\tL%03d\n", lbl2);
    printf("L%03d:\n", lbl3);
    iinst("lda",2,0,0);
    printf("L%03d:\n", lbl2);
    if(reg!=2)
	    iinst("lda",reg,0,2);
    break;
    case NE:    {
    rinst2("not", reg,reg);
    iinst("lda",reg,1,reg);
    rinst("add",reg,reg,regx);
   iinst("lda",0,0,reg);
    printf("\tbz\t$%d,\tL%03d\n",
            0, lbl1 = lbl++);
    iinst("lda",2,1,0);
    printf("\tbal\t$0,\tL%03d\n",
           lbl2 = lbl++);
    printf("L%03d:\n", lbl1);
    iinst("lda",2,0,0);
    printf("L%03d:\n", lbl2);
    if(reg!=2) iinst("lda",reg,0,2);
    break;}
    case EQ:    {
    rinst2("not", reg,reg);
    iinst("lda",reg,1,reg);
    rinst("add",reg,reg,regx);
   iinst("lda",0,0,reg);
    printf("\tbz\t$%d,\tL%03d\n",
           0,  lbl1 = lbl++);
    iinst("lda",2,0,0);
    printf("\tbal\t$0,\tL%03d\n",
           lbl2 = lbl++);
    printf("L%03d:\n", lbl1);
    iinst("lda",2,1,0);
    printf("L%03d:\n", lbl2);
    if(reg!=2) iinst("lda",reg,0,2);
    break;}
    }
   if(pres) {
    printf("; relax stack operatores\n");
    iinst("ld",regx,0,3);
    iinst("lda",3,1,3);
    frametop -= 1;
    }
   }
  }
 return 0;
}
