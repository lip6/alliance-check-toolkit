#
# Makefile for SN/X Assembler
# Gnu C Version
# N. Shimizu 12 Aug 2001
#

CC = cc
YACC = bison -y
LEX = flex

CFLAGS =  -g

CLEANS = y.tab.o lex.yy.o y.tab.c lex.yy.c y.tab.h snxasm
OBJS = y.tab.o lex.yy.o
SRCS = snxasm.y snxasm.l snxasm.h

all: snxasm

snxasm: $(OBJS)
	 $(CC) $(CFLAGS) $(OBJS) -o snxasm

y.tab.o: y.tab.c snxasm.y
	$(CC) $(CFLAGS) -c y.tab.c

lex.yy.o: lex.yy.c y.tab.h
	$(CC) $(CFLAGS) -c lex.yy.c

y.tab.c: snxasm.y snxasm.h
	$(YACC) -d snxasm.y

lex.yy.c: snxasm.l snxasm.h
	$(LEX) snxasm.l

clean:
	-rm $(CLEANS)

tar:
	tar cvf snxasm.tar Makefile $(SRCS)
