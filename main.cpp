#include <iostream>
#include <stdio.h>
#include <stdlib.h>



using namespace std;

int main(){

    string comando;

    
    cout<<"__________________________PROYECTO_1__________________________\n";

    while(true) 
    {

        cout << "Ingressar comando: " << endl;
        getline(cin, comando);

        if(comando.compare("salir") == 0 ){

            break;
        }
        else if (comando != "" && comando != "\n" && comando != " ")
        {

            cout << "ejecutar analisis de comandos" << endl;
        }
    }
    
    return 0;
}