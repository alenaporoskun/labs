#include <string.h>
#include <Windows.h>
#include <iostream>
#include <math.h>

 #define MAS_SIZE 50

using namespace std;  


int r[MAS_SIZE];
int num[MAS_SIZE];

// НСД(найбільший спільний дільник) двох чисел
int NSD(int a, int b){     
	if (b == 0) {
		return a;
	}
	int r = a % b;
	return NSD(b, r);
}

// функція, що допомогає рекурентно знайти значення масиву а, для знаходженння у = Dк
int recur_A(int a[], int r[], int mu){   
	int ans = 0;
	cout << "\nЗнаходимо рекурентно значення а" << mu - 1 << "\n"; 
	for (int i = 0; i < mu; i++){
		if (i == 0){
			a[0] = r[0];
		}
		if (i == 1){
			a[i] = r[0]*r[1] + 1;
		}
		if (i > 1){
			a[i] = a[i-1] * r[i] + a[i-2];
		}	
		cout << a[i] << " - a" << i << "\n";
	}
	ans = a[mu-1];
	return ans;
}


int main(){
	
	setlocale (LC_CTYPE, "ukr");
	
	int N, P, Q;
	int phi, E, nsd;
	
	cout << "Введiть P: ";
	cin >> P;
	cout << "Введiть Q: ";
	cin >> Q;
	cout << "P: " << P << "\n";
	cout << "Q: " << Q << "\n";
	
	N = P*Q;
	cout << "Модуль перетворення N: " << N << "\n";
	
	phi = (P-1)*(Q-1);
	cout << "Функцiя Ейлера phi(N): " << phi << "\n\n";
	
	int key = 0;
	while (key != 1){
		cout << "Виберiть випадково ключ Ek(так щоб вiн був взаємнопростий з ф. Ейлера): ";
		cin >> E;
		nsd = NSD(phi, E);
		cout << "\nПеревiрка НСД (phi(N), Ek): " << nsd << "\n\n";
		key = nsd;
		if (nsd == 1){
			cout << "Дiафантове рiвняння: ";
			cout << phi << "x + " << E << "y = "<< nsd << "\n";
			//printf("%dx + %dy = %d\n", phi, E, nsd);
		}
		else{
			cout << "НСД (phi(N), Ek) не дорiвнює 1. \n\n";
		}
	}
	
    int phi1 = phi, E1 = E;
	for(int i = 0; i < MAS_SIZE; i++){
		r[i] = phi1 / E1;
		num[i] = phi1 % E1; 
		
		phi1 = E1;
		E1 = num[i];
		
		if (E1 == 1){
			break;
		}	
	}
	cout << "\n";
	
	int m = 0;
	for (int i = 0; i < MAS_SIZE; i++){
		if (r[i] != 0){
			m++;
		}
	}	
	
	cout << "Подамо а/b = phi(N)/Ek у виглядi ланцювого дробу:";
	for (int i = 0; i < m; i++){		
		cout << "\n" << r[i] << " - r" << i;
		//cout << "\n" << num[i] <<  " - num " << i;
	}
	cout << "\nТаким чином, Mu = " << m << "\n\n";
	cout << "Розрахуємо значення y = Dk\n";        // y = (-1)^m * a_(m-1);
	
	int a[m];
	int A = recur_A(a, r, m);
	cout << "Значення а" << m - 1 << " = " << A;
	
	int y = pow(-1, m)*A; 
	y = y % phi;
	while (y < 0){
		y = y + phi;
	}
	cout << "\n\n" << "y = Dk = y mod(phi(N)) = " << y << "\n\n";
	
	cout << "Перевiрка\n\n";
	int multEkDk = E*y;
	printf("Вираз (Ek * Dk) mod(phi(N)) має дорiвнювати 1. \n", E, y, phi);
	printf("Цей вираз дорiвнює (%d) mod(%d) = 1. \n\n", multEkDk, phi);
	if ((multEkDk % phi) == 1){
		printf("Отже, (Ek, Dk) = (%d, %d) складає RSA ключову пару.\n\n", E, y);
	}
	else{
		printf("Отже, (Ek, Dk) = (%d, %d) не складає RSA ключову пару.\n\n", E, y); 
	} 
	
    return 0;
}

