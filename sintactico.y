%{

    #include "lexico.h"
    #include <iostream>
    #include <string.h>
    #include "tokensComandosTipos.h"
    #include "clases_comandos.h"
    #include "retorno.h"
    #include "modelos.h"

    extern int yylineno;
    extern int columna;
    extern char *yytext;

    int yyerror( const char* error)
    {

        if( strcmp(yytext," ") == 1)
        {

            std::cout << ":( :( :( :( :( :( :( :( ERROR SINTACTICO EN: " << error << " " << yytext << ":( :( :( :( :( :(" << std::endl;
        }


        return 0;
    }

%}


%define parse.error
%define verbose

%union{


    #include "tokensComandosTipos.h"

    char cadenaComando [300];

    struct Parametro * PARAMETRO;
    class Comando * COMANDO;
    int INT;

    tipo_Ajuste tipo_ajuste;
    tipo_Particion tipo_particion;
    tipo_Unidad tipo_unidad;
    tipo_Capacidad tipo_capacidad;
    tipo_Sistema tipo_sistema;
    tipo_Comando tipo_comando;
    tipo_Reporte tipo_reporte;
    tipo_Parametro parametro;

}



%token <cadenaComando> TOKEN_MOUNT
%token <cadenaComando> TOKEN_UNMOUNT
%token <cadenaComando> TOKEN_MKFS
%token <cadenaComando> TOKEN_LOGIN
%token <cadenaComando> TOKEN_MKFILE
%token <cadenaComando> TOKEN_MKDIR
%token <cadenaComando> TOKEN_REMOVE
%token <cadenaComando> TOKEN_EDIT
%token <cadenaComando> TOKEN_RENAME
%token <cadenaComando> TOKEN_FS
%token <cadenaComando> TOKEN_R
%token <cadenaComando> TOKEN_P
%token <cadenaComando> TOKEN_RUTA
%token <cadenaComando> TOKEN_RMGRP
%token <cadenaComando> TOKEN_MKUSR
%token <cadenaComando> TOKEN_LOGOUT
%token <cadenaComando> TOKEN_ADD
%token <cadenaComando> TOKEN_PATH
%token <cadenaComando> TOKEN_CONTENIDO
%token <cadenaComando> TOKEN_CONT
%token <cadenaComando> TOKEN_DESTINO

%token <cadenaComando> TOKEN_FIT
%token <cadenaComando> TOKEN_CHMOD

%token <cadenaComando> TOKEN_ENTERO
%token <cadenaComando> TOKEN_CADENA
%token <cadenaComando> TOKEN_FIRST

%token <cadenaComando> TOKEN_WORST
%token <cadenaComando> TOKEN_BEST
%token <cadenaComando> TOKEN_RUTA_PARAMETRO
%token <cadenaComando> TOKEN_ASIGNACION
%token <cadenaComando> TOKEN_KB
%token <cadenaComando> TOKEN_MB
%token <cadenaComando> TOKEN_BYTES
%token <cadenaComando> TOKEN_IDENTIFICADOR
%token <cadenaComando> TOKEN_MKDISK
%token <cadenaComando> TOKEN_RMDISK
%token <cadenaComando> TOKEN_COPY
%token <cadenaComando> TOKEN_MOVE
%token <cadenaComando> TOKEN_FIND
%token <cadenaComando> TOKEN_NAME
%token <cadenaComando> TOKEN_FLECHA_PARAMETRO
%token <cadenaComando> TOKEN_ID
%token <cadenaComando> TOKEN_CHGRP
%token <cadenaComando> TOKEN_RECOVERY
%token <cadenaComando> TOKEN_LOSS
%token <cadenaComando> TOKEN_USUARIO
%token <cadenaComando> TOKEN_PASSWORD
%token <cadenaComando> TOKEN_PWD
%token <cadenaComando> TOKEN_GRP
%token <cadenaComando> TOKEN_UGO
%token <cadenaComando> TOKEN_MKGRP
%token <cadenaComando> TOKEN_REP
%token <cadenaComando> TOKEN_SIZE
%token <cadenaComando> TOKEN_UNIT
%token <cadenaComando> TOKEN_TYPE
%token <cadenaComando> TOKEN_DELETE
%token <cadenaComando> TOKEN_CAT
%token <cadenaComando> TOKEN_FILEN
%token <cadenaComando> TOKEN_CHOWN
%token <cadenaComando> TOKEN_EXECUTE
%token <cadenaComando> TOKEN_PAUSE
%token <cadenaComando> TOKEN_PRIMARIA
%token <cadenaComando> TOKEN_LOGICA
%token <cadenaComando> TOKEN_EXTENDIDA
%token <cadenaComando> TOKEN_NOMBRE
%token <cadenaComando> TOKEN_FDISK
%token <cadenaComando> TOKEN_RMUSR
%token <cadenaComando> TOKEN_REPO
%token <cadenaComando> TOKEN_FAST
%token <cadenaComando> TOKEN_FULL
%token <cadenaComando> TOKEN_EXTEN2
%token <cadenaComando> TOKEN_EXTEN3






%type <cadenaComando> inicio
%type <PARAMETRO> comando
%type <PARAMETRO> comandos_lista
%type <COMANDO> parametro
%type <COMANDO> parametros_lista
%type <tipo_comando> comando_estado
%type <tipo_capacidad> capacidad    
%type <tipo_ajuste> ajuste      
%type <tipo_unidad> unidad      
%type <tipo_sistema> sistema  
%type <tipo_particion> particion                                        



%start inicio  


%%


inicio : comandos_lista 
        { if

            ListarComando($1, true);
        };

comandos_lista : comandos_lista comando
            {

                if( $1 != NULL )  {
                    if ( $2 != NULL ) 
                    
                    {
                        Comando *primero = $1;

                        while ( primero -> siguiente != NULL ){
                            primero = primero -> siguiente;
                        }
                        primero -> siguiente = $2;
                    }
                    $$ = $1;

                } else {

                    if ($2 != NULL) {

                        $$ = $2;
                    } else {

                        $$ = NULL;
                    }
                }
            }
            | comando
            {

                $$ = $1;

            };

comando : comando_estado parametros_lista 
        {
                            
            Comando *aux_comando = getComando($1, $2);

            $$ = aux_comando;

        }
        | TOKEN_PAUSE {
                
            $$ = new C_pause();
            
        }
        |TOKEN_LOGOUT
        {
         
            $$ = new C_logout();
        
        };


comando_estado : TOKEN_MKDISK 
                {

                    $$ = MKDISK;
                }
                | TOKEN_RMDISK 
                {

                    $$ = RMDISK;
                }
                | TOKEN_FDISK 
                {
                    
                    $$ = FDISK;
                }
                | TOKEN_MOUNT
                {

                    $$ = MOUNT;
                }  
                | TOKEN_UNMOUNT 
                {

                    $$ = UNMOUNT;
                }
                | TOKEN_MKFS 
                {

                    $$ = MKFS;
                }
                |TOKEN_LOGIN
                {

                    $$ = LOGIN;

                }
                | TOKEN_MKGRP
                {
                    
                    $$ = MKGRP;
                }
                | TOKEN_RMGRP 
                {

                    $$ = RMGRP;
                }
                | TOKEN_MKUSR 
                {
                    
                    $$ = MKUSR;
                }
                | TOKEN_RMUSR 
                {
                    
                    $$  = RMUSR;
                }
                |TOKEN_CHMOD
                {

                    $$ = CHMOD;

                }
                |TOKEN_MKFILE 
                {
                    
                    $$ = MKFILE;

                }
                |TOKEN_CAT
                {

                    $$ = CAT;

                }
                |TOKEN_MKDIR
                {
                    
                    $$ = MKDIR;
                }
                |TOKEN_REMOVE
                {

                    $$=REMOVE;
                }
                |TOKEN_EDIT
                {
                    
                    $$ = EDIT;
                }
                |TOKEN_RENAME
                {

                    $$ = RENAME;
                }
                |TOKEN_COPY
                {

                    $$ = COPY;
                }
                |TOKEN_MOVE
                {

                    $$ = MOVE;
                }
                |TOKEN_FIND
                {

                    $$ = FIND;
                }
                |TOKEN_CHOWN
                {

                    $$ = CHOWN;
                }
                |TOKEN_CHGRP {


                    $$ = CHGRP;
                }
                |TOKEN_RECOVERY 
                {

                    $$ = RECOVERY;
                }
                |TOKEN_LOSS
                {

                    $$ = LOSS;
                }
                |TOKEN_EXECUTE 
                {


                    $$ = EXEC;
                }
                |TOKEN_REP{
                    

                    $$ = REP;
                };



parametros_lista : parametros_lista parametro 
                {
                    Parametro *aux_param = $1;

                    while( aux_param -> siguiente != NULL){

                        aux_param = aux_param -> siguiente;
                    }
                    
                    aux_param -> siguiente = $2;
                    $$ = $1;
                }
                | parametro 
                {

                    $$ = $1;
                };

parametro : TOKEN_FLECHA_PARAMETRO TOKEN_PATH TOKEN_ASIGNACION TOKEN_RUTA_PARAMETRO
            {
                $$ = new Parametro(PATH);

                strcpy($$->text, $3);
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_PATH TOKEN_ASIGNACION TOKEN_CADENA
            {

                $$ = new Parametro(PATH);
                strcpy($$->text, getCadenaSinComillas($3).c_str());
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_SIZE TOKEN_ASIGNACION TOKEN_ENTERO
            {

                $$ = new Parametro(SIZE);
                $$->num = getNumero($3);
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_UNIT TOKEN_ASIGNACION unidad 
            {
                
                $$ = new Parametro(UNIT);    
                $$->unit = $3;
                
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_FIT TOKEN_ASIGNACION ajuste 
            {

                $$ = new Parametro(FIT);
                $$->fit = $3;
                
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_NAME TOKEN_ASIGNACION TOKEN_NOMBRE
            {
                $$ = new Parametro(NAME);
                strcpy($$->text, $3);
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_NAME TOKEN_ASIGNACION TOKEN_CADENA
            {

                $$ = new Parametro(NAME);
                strcpy($$->text, getCadenaSinComillas($3).c_str());
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_TYPE TOKEN_ASIGNACION particion 
            {

                $$ = new Parametro(TYPE);
                $$->type = $3;
                
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_DELETE TOKEN_ASIGNACION capacidad 
            {

                $$ = new Parametro(DELETE);
                $$->capacidad = $3;
                
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_ADD TOKEN_ASIGNACION TOKEN_ENTERO
            {

                $$ = new Parametro(ADD);
                $$->num = getNumero($3);
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_ID TOKEN_ASIGNACION TOKEN_IDENTIFICADOR
            {

                $$ = new Parametro(ID);
                $3[3] = tolower($3[3]);
                strcpy($$->text, $3);
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_TYPE TOKEN_ASIGNACION capacidad
            {

                $$ = new Parametro(FORMATO);
                $$->capacidad = $3;
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_FS TOKEN_ASIGNACION sistema 
            {

                $$ = new Parametro(FS);
                $$->sistema = FS_EXT_ERROR;
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_USUARIO TOKEN_ASIGNACION TOKEN_NOMBRE
            {

                $$ = new Parametro(USUARIO);
                strcpy($$->text, $3);
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_USUARIO TOKEN_ASIGNACION TOKEN_CADENA
            {

                $$ = new Parametro(USUARIO);
                strcpy($$->text, getCadenaSinComillas($3).c_str());
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_PASSWORD TOKEN_ASIGNACION TOKEN_NOMBRE
            {

                $$ = new Parametro(PASSWORD);
                strcpy($$->text, $3);
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_PASSWORD TOKEN_ASIGNACION TOKEN_ENTERO
            {

                $$ = new Parametro(PASSWORD);
                strcpy($$->text, $3);
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_PWD TOKEN_ASIGNACION TOKEN_NOMBRE
            {

                $$ = new Parametro(PWD);
                strcpy($$->text, $3);
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_PWD TOKEN_ASIGNACION TOKEN_ENTERO
            {

                $$ = new Parametro(PWD);
                strcpy($$->text, $3);
            }      
            | TOKEN_FLECHA_PARAMETRO TOKEN_GRP TOKEN_ASIGNACION TOKEN_NOMBRE
            {

                $$ = new Parametro(GRP);
                strcpy($$->text, $3);
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_GRP TOKEN_ASIGNACION TOKEN_CADENA
            {

                $$ = new Parametro(GRP);
                strcpy($$->text, getCadenaSinComillas($3).c_str());
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_UGO TOKEN_ASIGNACION TOKEN_ENTERO
            {

                $$ = new Parametro(UGO);
                $$ -> num = getNumero($3);
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_R
            {

                $$ = new Parametro(R);
                $$ -> r_flag = true;
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_P
            {

                $$ = new Parametro(PP);
                $$->p_flag = true;
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_CONT TOKEN_ASIGNACION TOKEN_RUTA_PARAMETRO
            {

                $$ = new Parametro(CONT);
                strcpy($$->text, $3);
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_CONTENIDO TOKEN_ASIGNACION TOKEN_RUTA_PARAMETRO
            {

                $$ = new Parametro(CONTENIDO);
                strcpy($$->text, $3);
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_CONTENIDO TOKEN_ASIGNACION TOKEN_CADENA
            {

                $$ = new Parametro(CONTENIDO);
                strcpy($$->text, getCadenaSinComillas($3).c_str());
            }
            | TOKEN_CONT TOKEN_ASIGNACION TOKEN_CADENA
            {

                $$ = new Parametro(CONT);
                strcpy($$->text, getCadenaSinComillas($3).c_str());
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_DESTINO TOKEN_ASIGNACION TOKEN_RUTA_PARAMETRO
            {

                $$ = new Parametro(DESTINO);
                strcpy($$->text, $3);
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_DESTINO TOKEN_ASIGNACION TOKEN_CADENA 
            {

                $$ = new Parametro(DESTINO);
                strcpy($$->text, getCadenaSinComillas($3).c_str());
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_FILEN TOKEN_ASIGNACION TOKEN_RUTA_PARAMETRO
            {

                $$ = new Parametro(FILEN);
                strcpy($$->text, $3);
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_FILEN TOKEN_ASIGNACION TOKEN_CADENA
            {

                $$ = new Parametro(FILEN);
                strcpy($$ -> text, getCadenaSinComillas($3).c_str());
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_RUTA TOKEN_ASIGNACION TOKEN_CADENA
            {

                $$ = new Parametro(RUTA);
                strcpy($$ -> text, getCadenaSinComillas($3).c_str());
            }
            | TOKEN_FLECHA_PARAMETRO TOKEN_RUTA TOKEN_ASIGNACION TOKEN_RUTA_PARAMETRO
            {

                $$ = new Parametro(RUTA);
                strcpy($$->text, $3);
            };



unidad : TOKEN_KB
        {

            $$ = K;
        }
        | TOKEN_MB
        {

            $$ = M;
        }
        | TOKEN_BYTES
        {

            $$ = B;
        };


particion : TOKEN_PRIMARIA
        {

            $$ = P;
        }
        |TOKEN_EXTENDIDA
        {

            $$ = E;
        }
        |TOKEN_LOGICA
        {

            $$ = L;
        };


capacidad : TOKEN_FAST
        {
            
            $$ = FAST;
        }
        | TOKEN_FULL
        {
            
            $$ = FULL;
        };


sistema : TOKEN_EXTEN2
        {
        
            $$ = EXT2;
        }
        | TOKEN_EXTEN3
        {

            $$ = EXT3;
        };

ajuste : TOKEN_FIRST 
        {
            
            $$ = FF;
        }
        | TOKEN_WORST
        {

            $$ = WF;
        }
        | TOKEN_BEST
        {

            $$ = BF;
        };



%%
