#include<stdio.h>
#include<stdlib.h>
#include<string.h>

    typedef struct{
        int stat;
        char name[40];
        int nature;
        int type;
    }element;

    char* ls[20];
    int tete=0;
    element* ts[1000];
    int ligne=1;
    int colonne=1;

    void inserer(char* name,int nature,int type,int i)
    {
        strcpy(ts[i]->name,name);
        ts[i]->nature=nature;
        ts[i]->type=type;
        ts[i]->stat=1;
    }

    int recherche(char* name)
    {
        for(int i=0;i<1000;i++)
        {
            if(ts[i]->stat==0)
                return i;
            if(!strcmp(ts[i]->name,name))
                return -1;
        }
    }

    void init()
    {
        for(int i=0;i<1000;i++)
        {
            ts[i]=(element*)malloc(sizeof(element));
            ts[i]->stat=0;
        }
    }

    void initlist(){
        for(int i=0;i<20;i++){
            ls[i]=malloc(sizeof(char)*8);
        }
    }

    void empiler(char *nom,char* ls[]){
        if(tete<20){
            strcpy(ls[tete],nom);
            tete++;
        }
        else
            printf("trop de variable a declarer d'un seul coup\n");
    }

    void showts(){
        printf("\t\t\tTable De Symbole : \n\t\t\t------------------\t\n");
        printf("------------------------------------------------------------------------\n");
        printf("|         Name         ||         Nature       ||          Type        |\n");
        printf("------------------------------------------------------------------------\n");
        for(int i=0;i<1000;i++){
            if(ts[i]->stat==0)
                break;
            if(ts[i]->type==0){
                centerText(ts[i]->name);
                if(ts[i]->nature==0){
                    centerText("variable");
                }
                if(ts[i]->nature==1){
                    centerText("constante");
                }
                if(ts[i]->nature==2){
                    centerText("tableau");
                }
                centerText("integer");
                printf("\n");
            }
            if(ts[i]->type==1){
                centerText(ts[i]->name);
                if(ts[i]->nature==0){
                    centerText("variable");
                }
                if(ts[i]->nature==1){
                    centerText("constante");
                }
                if(ts[i]->nature==2){
                    centerText("tableau");
                }
                centerText("float");
                printf("\n");
            }
            if(ts[i]->type==2){
                centerText(ts[i]->name);
                if(ts[i]->nature==0){
                    centerText("variable");
                }
                if(ts[i]->nature==1){
                    centerText("constante");
                }
                if(ts[i]->nature==2){
                    centerText("tableau");
                }
                centerText("char");
                printf("\n");
            }
            if(ts[i]->type==3){
                centerText(ts[i]->name);
                if(ts[i]->nature==0){
                    centerText("variable");
                }
                if(ts[i]->nature==1){
                    centerText("constante");
                }
                if(ts[i]->nature==2){
                    centerText("tableau");
                }
                centerText("string");
                printf("\n");
            }
        }
        printf("------------------------------------------------------------------------\n");
    }


void centerText(char *s)
{
        printf("|%*s%*s|",11+strlen(s)/2,s,11-strlen(s)/2,"");
}