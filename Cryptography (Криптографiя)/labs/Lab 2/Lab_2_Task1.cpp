#include <string.h>
#include <Windows.h>
#include <iostream>
#include <math.h>

 #define MAS_SIZE 50

using namespace std;  


int r[MAS_SIZE];
int num[MAS_SIZE];

// ���(��������� ������� ������) ���� �����
int NSD(int a, int b){     
	if (b == 0) {
		return a;
	}
	int r = a % b;
	return NSD(b, r);
}

// �������, �� �������� ���������� ������ �������� ������ �, ��� ������������ � = D�
int recur_A(int a[], int r[], int mu){   
	int ans = 0;
	cout << "\n��������� ���������� �������� �" << mu - 1 << "\n"; 
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
	
	cout << "����i�� P: ";
	cin >> P;
	cout << "����i�� Q: ";
	cin >> Q;
	cout << "P: " << P << "\n";
	cout << "Q: " << Q << "\n";
	
	N = P*Q;
	cout << "������ ������������ N: " << N << "\n";
	
	phi = (P-1)*(Q-1);
	cout << "�����i� ������ phi(N): " << phi << "\n\n";
	
	int key = 0;
	while (key != 1){
		cout << "�����i�� ��������� ���� Ek(��� ��� �i� ��� ������������� � �. ������): ";
		cin >> E;
		nsd = NSD(phi, E);
		cout << "\n�����i��� ��� (phi(N), Ek): " << nsd << "\n\n";
		key = nsd;
		if (nsd == 1){
			cout << "�i�������� �i������: ";
			cout << phi << "x + " << E << "y = "<< nsd << "\n";
			//printf("%dx + %dy = %d\n", phi, E, nsd);
		}
		else{
			cout << "��� (phi(N), Ek) �� ���i���� 1. \n\n";
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
	
	cout << "������ �/b = phi(N)/Ek � ������i ��������� �����:";
	for (int i = 0; i < m; i++){		
		cout << "\n" << r[i] << " - r" << i;
		//cout << "\n" << num[i] <<  " - num " << i;
	}
	cout << "\n����� �����, Mu = " << m << "\n\n";
	cout << "��������� �������� y = Dk\n";        // y = (-1)^m * a_(m-1);
	
	int a[m];
	int A = recur_A(a, r, m);
	cout << "�������� �" << m - 1 << " = " << A;
	
	int y = pow(-1, m)*A; 
	y = y % phi;
	while (y < 0){
		y = y + phi;
	}
	cout << "\n\n" << "y = Dk = y mod(phi(N)) = " << y << "\n\n";
	
	cout << "�����i���\n\n";
	int multEkDk = E*y;
	printf("����� (Ek * Dk) mod(phi(N)) �� ���i������� 1. \n", E, y, phi);
	printf("��� ����� ���i���� (%d) mod(%d) = 1. \n\n", multEkDk, phi);
	if ((multEkDk % phi) == 1){
		printf("����, (Ek, Dk) = (%d, %d) ������ RSA ������� ����.\n\n", E, y);
	}
	else{
		printf("����, (Ek, Dk) = (%d, %d) �� ������ RSA ������� ����.\n\n", E, y); 
	} 
	
    return 0;
}

