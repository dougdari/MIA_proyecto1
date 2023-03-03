run: 
	flex scanner.l
	bison parser.y

bin:
	g++ driver.cpp main.cpp parser.tab.c lex.yy.c -o analizador.out