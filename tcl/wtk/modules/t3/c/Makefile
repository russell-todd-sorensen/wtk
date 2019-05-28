# Basic Makefile -- relies on implicit rules
# Creates "myprogram" from "scan.l" and "myprogram.c"
#

LEX=flex
YACC=bison -y
YFLAGS = -d --debug --verbose

objects = t3-lex.o t3-bison.o t3.o

t3:	t3-lex.o t3-bison.o t3.o
#t3.o:	t3.l t3-bison.c
t3-bison.o:	t3-bison.y
t3.o:	t3-lex.c t3-bison.c t3.c

clean:
	rm t3-bison.c t3-lex.c y.tab.h t3-lex.h *.o