%{

    
    #include "sintactico.h"
    #include <iostream>

    int columna = 0;

    /*
    

    */
}%

%option noyywrap caseless

mkdist      "MKDISK"
rmdisk      "RMDISK"
fdisk       "FDISK"
mount       "MOUNT"
MKFS        "MKFS"

mkgrp       "MKGRP"
rmgrp       "RMGRP"
mkusr       "MKUSR"
rmusr       "RMUSR"
chmod       "CHMOD"
mkfile      "MKFILE"
cat         "CAT"

login       "LOGIN"
logout      "LOGOUT"

remove  "REMOVE"
rename    "RENAME"
edit    "EDIT"
mkdir      "MKDIR"
copy       "COPY"
move       "MOVE"
find      "FIND"
chown     "CHOWN"
chgrp       "CHGRP"
recovery    "RECOVERY"
loss       "LOSS"
exec      "EXEC"

pause       "PAUSE"

rep         "REP"

fit         "fit"

name        "name"
path        "path"
ruta        "ruta"
size        "size"


id          "id"
usuario     "user"

grp         "grp"
password    "pass"



ugo         "ugo"

filen       "file"[0-9]+

cont        "cont"


unit        "unit"
type        "type"
pwd         "pwd"
    contenido   "contenido"
    destino     "destino"

delete      "delete"

add         "add"

fs          "fs"
r           "r"
p           "p"




flechaParametro [>]
entero              [0-9]+
cadena              [\"][^\"\n]*[\"]
identificador       [0-9]{3}[Aa-zZ]
nombre            [\*\?a-zA-Z0-9._-]+
rutaParametro       ([/][^\n\" ]+?)+ 
asignacion          [=]
comentarioLinea     (#.*\n?)


%%

{flechaParametro} {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_FLECHA_PARAMETRO;}
{entero}       {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_ENTERO;}
{cadena}     {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_CADENA;} 

{rutaParametro} {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_RUTA_PARAMETRO;}

{asignacion}    {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_ASIGNACION;}
{comentarioLinea} {}
{identificador} {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_IDENTIFICADOR;}
{nombre}                {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_NOMBRE;}

{mkdisk}    {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_MKDISK;}
{rmdisk}    {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_RMDISK;}
{fdisk}     {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_FDISK;}
{mount}     {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_MOUNT;}
{pause}     {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_PAUSE;}
{unmount}   {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_UNMOUNT;}
{mkfs}      {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_MKFS;}
{login}     {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_LOGIN;}
{logout}    {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_LOGOUT;}
{mkgrp}     {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_MKGRP;}
{rmgrp}     {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_RMGRP;}
{cat}       {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_CAT;}
{mkusr}     {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_MKUSR;}
{mkdir}     {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_MKDIR;}

{rmusr}     {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_RMUSR;}
{chmod}     {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_CHMOD;}
{mkfile}    {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_MKFILE;}
{remove}    {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_REMOVE;}
{edit}      {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_EDIT;}
{rename}    {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_RENAME;}
{copy}      {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_COPY;}
{move}      {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_MOVE;}
{find}      {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_FIND;}
{chown}     {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_CHOWN;}

{chgrp}     {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_CHGRP;}
{recovery}  {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_RECOVERY;}
{loss}      {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_LOSS;}
{exec}      {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_EXEC;}
{rep}       {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_REP;}

{size}      {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_SIZE;}
{path}      {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_PATH;}
{name}      {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_NAME;}
{id}        {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_ID;}
{usuario}   {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_USUARIO;}
{password}  {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_PASSWORD;}
{pwd}       {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_PWD;}
{grp}       {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_GRP;}
{ugo}       {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_UGO;}
{filen}     {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_FILEN;}
{contenido} {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_CONTENIDO;}
{cont}      {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_CONT;}
{destino}   {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_DESTINO;}
{unit}      {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_UNIT;}
{type}      {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_TYPE;}
{delete}    {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_DELETE;}
{add}       {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_ADD;}
{fs}        {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_FS;}
{fit}       {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_FIT;}
{r}         {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_R;}
{p}         {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_P;}
{ruta}      {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_RUTA;}
"FF"        {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_FIRST;}
"WF"        {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_WORST;}
"BF"        {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_BEST;}
"K"         {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_KB;}
"M"         {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_MB;}
"B"         {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_BYTES;}

"P"         {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_PRIMARIA;}
"E"         {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_EXTENDIDA;}
"L"         {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_LOGICA;}
"FAST"      {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_FAST;}
"FULL"      {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_FULL;}
"2FS"       {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_EXTEN2;}
"3FS"       {columna = columna + strlen(yylval.entrada); strcpy(yylval.entrada, yytext); return TOKEN_EXTEN3;}
"\n"		{ }
[[:blank:]]	{ }


.           {std::cout<<yytext<<"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ERROR LEXICO @@@@@@@@@@@@@@@@@@@@@@"<< std::endl;}

%%





