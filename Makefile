all:
	flex Mini_ACAD.l
	bison -d Mini_ACAD.y
	gcc lex.yy.c Mini_ACAD.tab.c -o Mini_ACAD

clean:
	rm lex.yy.c Mini_ACAD.tab* Mini_ACAD
