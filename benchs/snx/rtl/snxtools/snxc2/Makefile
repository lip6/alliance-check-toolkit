#
# Makefile for SNX Compiler
# Gnu C Version
# N. Shimizu 11 Jul 2001
#

STACKTOP=0x400
CC = gcc
YACC = bison -y
LEX = flex

CFLAGS = -Wall -g -DSTACKTOP=$(STACKTOP)

CLEANS = snxc snxb1.o y.tab.o lex.yy.o y.tab.c lex.yy.c y.tab.h snxc.tab.c snxc.tab.h
OBJS = snxb1.o y.tab.o lex.yy.o
SRCS = snxb1.c snxc.y snxc.l snxc.h 

all: snxc

snxc: $(OBJS) $(SRCS)
	$(CC) $(CFLAGS) $(OBJS) -o snxc

snxb1.o: snxb1.c snxc.h y.tab.c
	$(CC) $(CFLAGS) -c snxb1.c

y.tab.o: y.tab.c snxc.y
	$(CC) $(CFLAGS) -c y.tab.c

lex.yy.o: lex.yy.c y.tab.h
	$(CC) $(CFLAGS) -c lex.yy.c

y.tab.c: snxc.y snxc.h
	$(YACC) -d snxc.y

lex.yy.c: snxc.l snxc.h
	$(LEX) snxc.l

clean:
	-rm $(CLEANS)

tar:
	tar cvf snxc.tar Makefile Readme.html $(SRCS)
