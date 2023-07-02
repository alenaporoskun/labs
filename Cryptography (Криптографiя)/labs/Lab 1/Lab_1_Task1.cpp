#include <string.h>
#include <Windows.h>
#include <iostream>

using namespace std;

int main(){ 

setlocale (LC_CTYPE, "ukr");
 
 int size_mes, size_ABC;                                  
 char encrypted_mes[20];                                  
 char decrypted_mes[20];                                  
 
 char message[] = "олена_пороскун";                   
 cout << message << " - повiдомлення\n\n";  
          
 char ABC[] = "абвгдеєжзиiїйклмнопрстуфхцчшщьюя_";         
 cout << ABC << " - вхiдний алфавiт\n";                   
         
 char ABC1[] ="ьюя_абвгдеєжзиiїйклмнопрстуфхцчшщ";         
 cout << ABC1 << " - вихiдний алфавiт\n\n";                 
 
 size_mes = sizeof(message);                              
 size_ABC = sizeof(ABC);                                  
 
 for (int i = 0; i < size_mes; i++) {
  for (int j = 0; j < size_ABC; j++) {
   if (ABC[j] == message[i]) {                            
    encrypted_mes[i] = ABC1[j];
   }
  }
 }
cout << encrypted_mes << " - зашифроване повiдомлення\n";
  
 for (int i = 0; i < size_mes; i++) {
  for (int j = 0; j < size_ABC; j++) {
   if (ABC1[j] == encrypted_mes[i]) {
    decrypted_mes[i] = ABC[j];
   }
  }
 }
 cout << decrypted_mes << " - розшифроване повiдомлення\n";
 return 0;
}
