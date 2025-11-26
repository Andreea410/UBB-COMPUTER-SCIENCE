# Makefile
BISON = bison
FLEX  = flex
CC    = gcc
CFLAGS = -O2 -Wall

all: parser

parser: parser.tab.c lex.yy.c main.c
	$(CC) $(CFLAGS) parser.tab.c lex.yy.c main.c -o parser

parser.tab.c parser.tab.h: parser.y
	$(BISON) -d -v parser.y

lex.yy.c: scanner.l parser.tab.h
	$(FLEX) scanner.l

.PHONY: lexer clean test

lexer:
	python3 lexer.py program.txt

test: all lexer
	@echo "== Running parser on PIF.out (produced by lexer) =="
	./parser < PIF.out
	@echo "== productions.out produced =="
	@ls -l productions.out
	@echo "== symbol table =="
	@cat ST.txt || true

clean:
	-rm -f parser parser.tab.c parser.tab.h y.output lex.yy.c productions.out PIF.out ST.txt errors.txt
