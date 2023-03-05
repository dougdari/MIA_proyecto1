%{

#include "lexico.h"
#include <iostream>
#include <string.h>

extern int yylineno;
extern int columna;
extern char *yytext;

int yyerror(const char* msj){
    if(strcmp(yytext," ") == 1){    
    	std::cout<<":( :( :( :( :( :( :( :( ERROR SINTACTICO EN: "<<msj<<" "<<yytext<< ":( :( :( :( :( :(" << std::endl;
    }
    return 0;
}

%}


%define parse.error verbose

%union{
char entrada [256];
}



%token <entrada> TOKEN_MOUNT
%token <entrada> TOKEN_UNMOUNT
%token <entrada> TOKEN_MKFS
%token <entrada> TOKEN_LOGIN
%token <entrada> TOKEN_MKFILE
%token <entrada> TOKEN_MKDIR
%token <entrada> TOKEN_REMOVE
%token <entrada> TOKEN_EDIT
%token <entrada> TOKEN_RENAME
%token <entrada> TOKEN_FS
%token <entrada> TOKEN_R
%token <entrada> TOKEN_P
%token <entrada> TOKEN_RUTA
%token <entrada> TOKEN_RMGRP
%token <entrada> TOKEN_MKUSR
%token <entrada> TOKEN_LOGOUT
%token <entrada> TOKEN_ADD
%token <entrada> TOKEN_PATH
%token <entrada> TOKEN_CONTENIDO
%token <entrada> TOKEN_CONT
%token <entrada> TOKEN_DESTINO
%token <entrada> TOKEN_FIT
%token <entrada> TOKEN_CHMOD
%token <entrada> TOKEN_ENTERO
%token <entrada> TOKEN_CADENA
%token <entrada> TOKEN_FIRST
%token <entrada> TOKEN_WORST
%token <entrada> TOKEN_BEST
%token <entrada> TOKEN_RUTA_PARAMETRO
%token <entrada> TOKEN_ASIGNACION
%token <entrada> TOKEN_KB
%token <entrada> TOKEN_MB
%token <entrada> TOKEN_BYTES
%token <entrada> TOKEN_IDENTIFICADOR
%token <entrada> TOKEN_MKDISK
%token <entrada> TOKEN_RMDISK
%token <entrada> TOKEN_COPY
%token <entrada> TOKEN_MOVE
%token <entrada> TOKEN_FIND
%token <entrada> TOKEN_NAME
%token <entrada> TOKEN_FLECHA_PARAMETRO
%token <entrada> TOKEN_ID
%token <entrada> TOKEN_CHGRP
%token <entrada> TOKEN_RECOVERY
%token <entrada> TOKEN_LOSS
%token <entrada> TOKEN_USUARIO
%token <entrada> TOKEN_PASSWORD
%token <entrada> TOKEN_PWD
%token <entrada> TOKEN_GRP
%token <entrada> TOKEN_UGO
%token <entrada> TOKEN_MKGRP
%token <entrada> TOKEN_REP
%token <entrada> TOKEN_SIZE
%token <entrada> TOKEN_UNIT
%token <entrada> TOKEN_TYPE
%token <entrada> TOKEN_DELETE
%token <entrada> TOKEN_CAT
%token <entrada> TOKEN_FILEN
%token <entrada> TOKEN_CHOWN
%token <entrada> TOKEN_EXEC
%token <entrada> TOKEN_PAUSE
%token <entrada> TOKEN_PRIMARIA
%token <entrada> TOKEN_LOGICA
%token <entrada> TOKEN_EXTENDIDA
%token <entrada> TOKEN_NOMBRE
%token <entrada> TOKEN_FDISK
%token <entrada> TOKEN_RMUSR
%token <entrada> TOKEN_REPO
%token <entrada> TOKEN_FAST
%token <entrada> TOKEN_FULL
%token <entrada> TOKEN_EXTEN2
%token <entrada> TOKEN_EXTEN3






%start inicio  

%%


inicio:                 comand_list{
                            ListarComando($1, true);
                        }
;

comand_list:            comand_list comando{
                            if($1 != NULL){
                                if($2 != NULL){
                                    Comando *primero = $1;
                                    while(primero->siguiente != NULL){
                                        primero = primero->siguiente;
                                    }
                                    primero->siguiente = $2;
                                }
                                $$ = $1;
                            }else{
                                if($2 != NULL){
                                    $$ = $2;
                                }else{
                                    $$ = NULL;
                                }
                            }
                        }
                        |comando{
                            $$ = $1;
                        }           
;

comando:                comando_estado params_list{
                            Comando *aux_comando = getComando($1, $2);
                            $$ = aux_comando;
                        }
                        |TOKEN_PAUSE{
                            $$ = new C_pause();
                        }
                        |TOKEN_LOGOUT{
                            $$ = new C_logout();
                        }
;

comando_estado:         TOKEN_MKDISK{
                            $$=MKDISK;
                        }
                        |TOKEN_RMDISK{
                            $$=RMDISK;
                        }
                        |TOKEN_FDISK{
                            $$=FDISK;
                        }
                        |TOKEN_MOUNT{
                            $$=MOUNT;
                        }  
                        |TOKEN_UNMOUNT{
                            $$=UNMOUNT;
                        }
                        |TOKEN_MKFS{
                            $$=MKFS;
                        }
                        |TOKEN_LOGIN{
                            $$=LOGIN;
                        }
                        |TOKEN_MKGRP{
                            $$=MKGRP;
                        }
                        |TOKEN_RMGRP{
                            $$=RMGRP;
                        }
                        |TOKEN_MKUSR{
                            $$=MKUSR;
                        }
                        |TOKEN_RMUSR{
                            $$=RMUSR;
                        }
                        |TOKEN_CHMOD{
                            $$=CHMOD;
                        }
                        |TOKEN_MKFILE{
                            $$=MKFILE;
                        }
                        |TOKEN_CAT{
                            $$=CAT;
                        }
                        |TOKEN_MKDIR{
                            $$=MKDIR;
                        }
                        |TOKEN_REMOVE{
                            $$=REMOVE;
                        }
                        |TOKEN_EDIT{
                            $$=EDIT;
                        }
                        |TOKEN_RENAME{
                            $$=RENAME;
                        }
                        |TOKEN_COPY{
                            $$=COPY;
                        }
                        |TOKEN_MOVE{
                            $$=MOVE;
                        }
                        |TOKEN_FIND{
                            $$=FIND;
                        }
                        |TOKEN_CHOWN{
                            $$=CHOWN;
                        }
                        |TOKEN_CHGRP{
                            $$=CHGRP;
                        }
                        |TOKEN_RECOVERY{
                            $$=RECOVERY;
                        }
                        |TOKEN_LOSS{
                            $$=LOSS;
                        }
                        |TOKEN_EXEC{
                            $$=EXEC;
                        }
                        |TOKEN_REP{
                            $$=REP;
                        }
;

params_list:            params_list param{
                            Parametro *aux_param = $1;
                            while(aux_param->siguiente != NULL){
                                aux_param = aux_param->siguiente;
                            }
                            aux_param->siguiente = $2;
                            $$ = $1;
                        }
                        |param{
                            $$ = $1;
                        }
;

param:                  TOKEN_FLECHA_PARAMETRO TOKEN_PATH TOKEN_ASIGNACION TOKEN_RUTA_PARAMETRO{
                            $$ = new Parametro(PATH);
                            strcpy($$->text, $3);
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_PATH TOKEN_ASIGNACION TOKEN_CADENA{
                            $$ = new Parametro(PATH);
                            strcpy($$->text, getCadenaSinComillas($3).c_str());
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_SIZE TOKEN_ASIGNACION TOKEN_ENTERO{
                            $$ = new Parametro(SIZE);
                            $$->num = getNumero($3);
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_UNIT TOKEN_ASIGNACION unidades{
                            $$ = new Parametro(UNIT);    
                            $$->unit = $3;
                            
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_FIT TOKEN_ASIGNACION ajustes{
                            $$ = new Parametro(FIT);
                            $$->fit = $3;
                            
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_NAME TOKEN_ASIGNACION TOKEN_NOMBRE{
                            $$ = new Parametro(NAME);
                            strcpy($$->text, $3);
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_NAME TOKEN_ASIGNACION TOKEN_CADENA{
                            $$ = new Parametro(NAME);
                            strcpy($$->text, getCadenaSinComillas($3).c_str());
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_TYPE TOKEN_ASIGNACION tipos{
                            $$ = new Parametro(TYPE);
                            $$->type = $3;
                            
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_DELETE TOKEN_ASIGNACION capacidades{
                            $$ = new Parametro(DELETE);
                            $$->capacidad = $3;
                            
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_ADD TOKEN_ASIGNACION TOKEN_ENTERO{
                            $$ = new Parametro(ADD);
                            $$->num = getNumero($3);
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_ID TOKEN_ASIGNACION TOKEN_IDENTIFICADOR{
                            $$ = new Parametro(ID);
                            $3[3] = tolower($3[3]);
                            strcpy($$->text, $3);
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_TYPE TOKEN_ASIGNACION capacidades{
                            $$ = new Parametro(FORMATO);
                            $$->capacidad = $3;
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_FS TOKEN_ASIGNACION sistemas{
                            $$ = new Parametro(FS);
                            $$->sistema = FS_EXT_ERROR;
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_USUARIO TOKEN_ASIGNACION TOKEN_NOMBRE{
                            $$ = new Parametro(USUARIO);
                            strcpy($$->text, $3);
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_USUARIO TOKEN_ASIGNACION TOKEN_CADENA{
                            $$ = new Parametro(USUARIO);
                            strcpy($$->text, getCadenaSinComillas($3).c_str());
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_PASSWORD TOKEN_ASIGNACION TOKEN_NOMBRE{
                            $$ = new Parametro(PASSWORD);
                            strcpy($$->text, $3);
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_PASSWORD TOKEN_ASIGNACION TOKEN_ENTERO{
                            $$ = new Parametro(PASSWORD);
                            strcpy($$->text, $3);
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_PWD TOKEN_ASIGNACION TOKEN_NOMBRE{
                            $$ = new Parametro(PWD);
                            strcpy($$->text, $3);
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_PWD TOKEN_ASIGNACION TOKEN_ENTERO{
                            $$ = new Parametro(PWD);
                            strcpy($$->text, $3);
                        }      
                        |TOKEN_FLECHA_PARAMETRO TOKEN_GRP TOKEN_ASIGNACION TOKEN_NOMBRE{
                            $$ = new Parametro(GRP);
                            strcpy($$->text, $3);
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_GRP TOKEN_ASIGNACION TOKEN_CADENA{
                            $$ = new Parametro(GRP);
                            strcpy($$->text, getCadenaSinComillas($3).c_str());
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_UGO TOKEN_ASIGNACION TOKEN_ENTERO{
                            $$ = new Parametro(UGO);
                            $$->num = getNumero($3);
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_R{
                            $$ = new Parametro(R);
                            $$->r_flag = true;
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_P{
                            $$ = new Parametro(PP);
                            $$->p_flag = true;
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_CONT TOKEN_ASIGNACION TOKEN_RUTA_PARAMETRO{
                            $$ = new Parametro(CONT);
                            strcpy($$->text, $3);
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_CONTENIDO TOKEN_ASIGNACION TOKEN_RUTA_PARAMETRO{
                            $$ = new Parametro(CONTENIDO);
                            strcpy($$->text, $3);
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_CONTENIDO TOKEN_ASIGNACION TOKEN_CADENA{
                            $$ = new Parametro(CONTENIDO);
                            strcpy($$->text, getCadenaSinComillas($3).c_str());
                        }
                        |TOKEN_CONT TOKEN_ASIGNACION TOKEN_CADENA{
                            $$ = new Parametro(CONT);
                            strcpy($$->text, getCadenaSinComillas($3).c_str());
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_DESTINO TOKEN_ASIGNACION TOKEN_RUTA_PARAMETRO{
                            $$ = new Parametro(DESTINO);
                            strcpy($$->text, $3);
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_DESTINO TOKEN_ASIGNACION TOKEN_CADENA{
                            $$ = new Parametro(DESTINO);
                            strcpy($$->text, getCadenaSinComillas($3).c_str());
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_FILEN TOKEN_ASIGNACION TOKEN_RUTA_PARAMETRO{
                            $$ = new Parametro(FILEN);
                            strcpy($$->text, $3);
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_FILEN TOKEN_ASIGNACION TOKEN_CADENA{
                            $$ = new Parametro(FILEN);
                            strcpy($$->text, getCadenaSinComillas($3).c_str());
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_RUTA TOKEN_ASIGNACION TOKEN_CADENA{
                            $$ = new Parametro(RUTA);
                            strcpy($$->text, getCadenaSinComillas($3).c_str());
                        }
                        |TOKEN_FLECHA_PARAMETRO TOKEN_RUTA TOKEN_ASIGNACION TOKEN_RUTA_PARAMETRO{
                            $$ = new Parametro(RUTA);
                            strcpy($$->text, $3);
                        }                                           
;

unidades:               TOKEN_KB{
                            $$ = K;
                        }
                        |TOKEN_MB{
                            $$ = M;
                        }
                        |TOKEN_BYTES{
                            $$ = B;
                        }
;

tipos:                  TOKEN_PRIMARIA{
                            $$ = P;
                        }
                        |TOKEN_EXTENDIDA{
                            $$ = E;
                        }
                        |TOKEN_LOGICA{
                            $$ = L;
                        }
;

capacidades:            TOKEN_FAST{
                            $$ = FAST;
                        }
                        |TOKEN_FULL{
                            $$ = FULL;
                        }
;

sistemas:               TOKEN_EXTEN2{
                            $$ = EXT2;
                        }
                        |TOKEN_EXTEN3{
                            $$ = EXT3;
                        }
;

ajustes:                TOKEN_FIRST{
                            $$ = FF;
                        }
                        |TOKEN_WORST{
                            $$ = WF;
                        }
                        |TOKEN_BEST{        
                            $$ = BF;
                        }
;

%%
