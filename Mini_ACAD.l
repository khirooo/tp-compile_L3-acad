%option noyywrap
%option yylineno
%{
    #include<stdio.h>
    #include<stdlib.h>
    #include"Mini_ACAD.tab.h"
    #include"ts.h"

    extern YYSTYPE yylval;
    
%}

idf [A-Z][a-z]{0,7}
entier [0-9]+
sentier -{entier}
reel [0-9]+\.[0-9]+
sreel \(-{reel}\)
ch [a-zA-Z0-9]?
c '{ch}'
chaine1 «({ch}|" ")*»
chaine2 «({ch}|" ")*
comment "//"(.|[ \t])*"//"

%%

"PROGRAM"           { colonne+=yyleng; return PROGRAM; }

"BEGIN"             {colonne+=yyleng; return BGN; }

"END"               {  colonne+=yyleng; return END;}

"var"               {  colonne+=yyleng; return var;}

"Let"               {    colonne+=yyleng; return Let; }

"INT"               { colonne+=yyleng; return INT;}

"FLOAT"             {  colonne+=yyleng; return FLOAT;}

"CHAR"              {  colonne+=yyleng; return CHAR;}

"STRING"            {  colonne+=yyleng; return STRING;}

"CONST"             {  colonne+=yyleng; return CONST;}

"GET"               {  colonne+=yyleng; return GET;}

"SHOW"              {  colonne+=yyleng; return SHOW;}

"IF"                {  colonne+=yyleng; return IF;}

"ELSE"              { colonne+=yyleng; return ELSE;}

"END_IF"            { colonne+=yyleng; return END_IF;}

"RETURN"            {  colonne+=yyleng; return RETURN;}

"FOR"               {  colonne+=yyleng; return FOR;}

"END_FOR"           {  colonne+=yyleng; return END_FOR;}

" "                 { colonne+=yyleng; }

"\n"                { ligne++; colonne=1; }

"||"                { colonne+=yyleng;  return separ;}

"<<""="?            { colonne+=yyleng;  return less;}

">>""="?            { colonne+=yyleng;  return greater;}

"=="                { colonne+=yyleng;  return equal;}

"<<>>"              { colonne+=yyleng;  return diff;}

"="                 { colonne+=yyleng;  return '='; }

"+"                 { colonne+=yyleng;  return plus; }

"-"                 { colonne+=yyleng;  return minus; }

"*"                 { colonne+=yyleng;  return mul; }

"/"                 { colonne+=yyleng;  return '/'; }

"£"                 { colonne+=yyleng;  return ';' ; }

":"                 { colonne+=yyleng;  return ':' ; }

"["                 { colonne+=yyleng;  return '[' ; }

"]"                 { colonne+=yyleng;  return ']' ; }

"("                 { colonne+=yyleng;  return '(' ; }

")"                 { colonne+=yyleng;  return ')' ; }

"{"                 { colonne+=yyleng;  return '{' ; }

"}"                 { colonne+=yyleng;  return '}' ; }

"$"                 { colonne+=yyleng;  return '$' ; }

"%"                 { colonne+=yyleng;  return 'f' ; }

"&"                 { colonne+=yyleng;  return '&' ; }

"#"                 { colonne+=yyleng;  return '#' ; }

"@"                 { colonne+=yyleng;  return '@' ; }

"»"                 { colonne+=yyleng;  return '"' ; }

{idf}               { yylval.chaine=strdup(yytext); colonne+=yyleng;  return IDF;}

{entier}           { 
                        if( 0 > atoi(yytext) || atoi(yytext) > 32767 ){
                            printf("Error lexicale %d:%d \n",ligne,colonne);
                            exit(1);
                        }
                        colonne+=yyleng;
                        return entier;
                    }

{sentier}     {         
                        if( -32768> atoi(yytext) || atoi(yytext) >0  ){
                            printf("Error lexicale %d:%d \n",ligne,colonne);
                            
                            exit(1);
                        }
                        colonne+=yyleng;
                        return sentier;
                    }

{reel}              {  colonne+=yyleng;  return reel;}

{sreel}             {  colonne+=yyleng;   return sreel;}

{c}                 {  colonne+=yyleng;  return c;}

{chaine1}           {  colonne+=yyleng;   return chaine1;}

{chaine2}           {  colonne+=yyleng;   return chaine2;}

{comment}           { colonne+=yyleng; }

%%

