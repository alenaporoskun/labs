#include <string.h>
#include <Windows.h>
#include <iostream>

using namespace std;  

int main(){  

 setlocale (LC_CTYPE, "ukr");
 
 int size_mes, size_ABC, size_key1;                                  
 char encrypted_mes[20], decrypted_mes[20];                                  
 
 char message[] = "�����_��������";                   
 cout << message << " - ���i��������\n"; 
 
 char key[] = "��������";         
 cout << "\n" << key << " - ���� \n";
          
 char ABC[] = "���������i���������������������_";         
 cout << "\n" << ABC << " - ��i���� �����i�\n\n"; 
 
 size_mes = sizeof(message)-1;                              
 size_ABC = sizeof(ABC)-1; 
 
 // ------------------------------------------------------------
 
 // ������� ������ �1 
 int M1[size_mes];
 for (int i = 0; i < size_mes; i++) {
  for (int j = 0; j < size_ABC; j++) {
   if (ABC[j] == message[i]) {                            
    M1[i] = j;
   }
  }
 }
 
 for (int i = 0; i < size_mes; i++) {                          
    printf("%d ", M1[i]);
 }
 printf(" - ���i��������(M1)\n");
 
 // ------------------------------------------------------------
 
 // ������� ������ ����� �1 
 char key1[] = "��������������";         
 cout << "\n" << key1 << " - ���� � �������������� \n\n";
 size_key1 = sizeof(key1)-1;
 
 int G1[size_key1]; 
 for (int i = 0; i < size_key1; i++) {
  for (int j = 0; j < size_ABC; j++) {
   if (ABC[j] == key1[i]) {                            
    G1[i] = j;
   }
  }
 }
 
 for (int i = 0; i < size_mes; i++) {                          
    printf("%d ", G1[i]);
 }
 printf(" - ���� � ��������������(G1) \n\n");
 
 // ------------------------------------------------------------
 
 // ������� ����������� �1
 int C1[size_key1]; 
 for (int i = 0; i < size_key1; i++) {                         
    C1[i] = (M1[i] + G1[i]) % size_ABC;
 }
 
 for (int i = 0; i < size_mes; i++) {                          
    printf("%d ", C1[i]);
 }
 printf(" - ����������� ���i�������� (C1) \n\n");
 
  // ����������� ���i��������
  for (int i = 0; i < size_mes; i++) {
  	for (int j = 0; j < size_ABC; j++) {
	  if (C1[i] == j) {
	  	encrypted_mes[i] = ABC[j];
	  }
	}
  }
 
 for (int i = 0; i < size_mes; i++) {                           
    printf("%c", encrypted_mes[i]);
 }
 printf(" - ����������� ���i�������� \n\n\n");

 // ------------------------------------------------------------

 // ������������ ���i�������� M2
 int M2[size_key1]; 
 for (int i = 0; i < size_key1; i++) {                         
    M2[i] = (C1[i] - G1[i]) % size_ABC;
	while (M2[i] < 0){
    	M2[i] = M2[i] + size_ABC;
	}
 }
 
 for (int i = 0; i < size_mes; i++) {                          
    printf("%d ", M2[i]);
 }
 printf(" - ������������ ���i��������(M2) \n\n");
 
  for (int i = 0; i < size_mes; i++) {
  	for (int j = 0; j < size_ABC; j++) {
	  if (M2[i] == j) {
	  	decrypted_mes[i] = ABC[j];
	  }
	}
  }
  
  for (int i = 0; i < size_mes; i++) {                          
    printf("%c", decrypted_mes[i]);
 }
  printf(" - ������������ ���i�������� \n\n");
 
 return 0;
}
