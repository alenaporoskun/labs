#include <string.h>
#include <Windows.h>
#include <iostream>

using namespace std;

int main(){ 

setlocale (LC_CTYPE, "ukr");
 
 int size_mes, size_ABC;                                  
 char encrypted_mes[20];                                  
 char decrypted_mes[20];                                  
 
 char message[] = "�����_��������";                   
 cout << message << " - ���i��������\n\n";  
          
 char ABC[] = "���������i���������������������_";         
 cout << ABC << " - ��i���� �����i�\n";                   
         
 char ABC1[] ="���_���������i������������������";         
 cout << ABC1 << " - ���i���� �����i�\n\n";                 
 
 size_mes = sizeof(message);                              
 size_ABC = sizeof(ABC);                                  
 
 for (int i = 0; i < size_mes; i++) {
  for (int j = 0; j < size_ABC; j++) {
   if (ABC[j] == message[i]) {                            
    encrypted_mes[i] = ABC1[j];
   }
  }
 }
cout << encrypted_mes << " - ����������� ���i��������\n";
  
 for (int i = 0; i < size_mes; i++) {
  for (int j = 0; j < size_ABC; j++) {
   if (ABC1[j] == encrypted_mes[i]) {
    decrypted_mes[i] = ABC[j];
   }
  }
 }
 cout << decrypted_mes << " - ������������ ���i��������\n";
 return 0;
}
