%{
    #include<stdio.h>
    #include<stdlib.h>
    extern int ligne;
    extern int colonne;
    extern int tete;
    extern int yylineno;
    extern char* ls[];
    int yyerror(char* s);
    int type;
%}

%union{
  char* chaine;
}

%token PROGRAM BGN END var Let INT FLOAT CHAR STRING CONST GET SHOW IF ELSE END_IF RETURN FOR END_FOR 
%token separ less greater equal diff  
%token <chaine>IDF 
%token entier sentier reel sreel c chaine1 chaine2 
%token '=' plus minus mul '/' ';' ':' '[' ']' '(' ')' '{' '}' '"'
%token '$' '%' '&' 'f' '#' '@'


%start S  


%%

S: PROGRAM IDF partie_dec BGN partie_code END {printf("\n\n<<<<<<<<<<<<<<<<<<<<<<<<--PROGRAMME VALIDE!-->>>>>>>>>>>>>>>>>>>>>>\n\n"); showts();}
;

      /*-------PARTIE DECLARATION-------*/

partie_dec: dec_var partie_dec   
          | dec_cons partie_dec  
          | dec_tab partie_dec   
          |
;

dec_var: var  suit_idf ':' type ';' { 
                                       for(int i=0;i<tete;i++)
                                      {
                                        inserer(ls[i],0,type,recherche(ls[i]));
                                      } 
                                    }
;


dec_cons: Let IDF ':' type '=' value ';' {
                                            if(recherche($2)==-1){
                                            printf("Erreur semantique:(%d:%d) %s a déja eté declaré\n",yylineno,colonne,$2);
                                            exit(1);
                                         }
                                         else
                                            inserer($2,1,type,recherche($2));
                                         }
;

dec_tab: var IDF '[' entier ']' ':' '[' type ']' ';' {
                                                        if(recherche($2)==-1){
                                                        printf("Erreur semantique:(%d:%d) %s a déja eté declaré\n",yylineno,colonne,$2);
                                                        exit(1);
                                                        }
                                                      else
                                                        inserer($2,2,type,recherche($2));
                                                      }
;

suit_idf: IDF separ suit_idf  {
                                if(recherche($1)==-1){
                                  printf("Erreur semantique:(%d:%d) %s a déja eté declaré\n",yylineno,colonne,$1);
                                  exit(1);
                                }
                                else
                                  empiler($1,ls); 
                              }
        | IDF                 {
                                if(recherche($1)==-1){
                                  printf("Erreur semantique:(%d:%d) %s a déja eté declaré\n",yylineno,colonne,$1);
                                  exit(1);
                                }
                                else
                                  tete=0;
                                  empiler($1,ls); 
                              }    
;

type: INT     {type=0;}
    | FLOAT   {type=1;}
    | CHAR    {type=2;}
    | STRING  {type=3;}
;

value: entier | '(' sentier ')' | reel |'(' sreel ')' | c | chaine1
;


        /*-------PARTIE CODE -------*/


partie_code: instuction partie_code
           | ifcondition partie_code
           | boucle partie_code
           |
;

instuction: affect
          | affichage
          | lecture
;

ifcondition: IF '(' condition ')'  '{' partie_code '}'
           | IF '(' condition ')'  '{' partie_code '}' ELSE  '{' partie_code '}'
;

boucle: FOR '(' IDF ':' entier ':' condition ')' partie_code END_FOR  
;

affect: IDF '=' expres ';'
;

affichage: SHOW '(' chaine2 '$' '"' ':' IDF ')' ';'
         | SHOW '(' chaine2 '&' '"' ':' IDF ')' ';'
         | SHOW '(' chaine2 'f' '"' ':' IDF ')' ';'
         | SHOW '(' chaine2 '#' '"' ':' IDF ')' ';'
         | SHOW '(' chaine1 ')' ';'
;

lecture: GET '(' chaine2 '$' '"' ':' '@' IDF ')' ';'
       | GET '(' chaine2 '&' '"' ':' '@' IDF ')' ';'
       | GET '(' chaine2 'f' '"' ':' '@' IDF ')' ';'
       | GET '(' chaine2 '#' '"' ':' '@' IDF ')' ';'
;

condition: expres logoper expres 
;

expres: expres plus expres
      | expres minus expres
      | expres mul expres
      | expres '/' expres
      | '(' expres ')'
      | operand
;

logoper: less | greater | less equal | greater equal | equal | diff
;

operand: IDF | entier | reel | '(' sentier ')' | '(' sreel ')' 
;

%%

int yyerror(char* s){
  printf("Erreur fatale:(%d:%d): %s \n",yylineno,colonne,s);
  return 1;
}
int main(){
  init();
  initlist();
  yyparse();
  return 0;
}