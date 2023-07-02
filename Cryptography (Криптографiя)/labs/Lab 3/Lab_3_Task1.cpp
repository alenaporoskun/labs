#include <iostream>
#include <math.h>

using namespace std;

int main() {

	setlocale (LC_CTYPE, "ukr");

	int Pn[2];

	cout << "����i�� �������� Pn: ";
    cin >> Pn[0] >> Pn[1];
    cout << "�������� Pn = (" << Pn[0] << ", " << Pn[1] << ")"<< endl;
    
    int x = Pn[0], y = Pn[1];
    //cout << "�������� Pn: x = " << x << ", y = " << y << endl;
    
    int a = 1, b = 1, p = 23;
    
    int f1, f2;
    f1 = pow(y, 2);
    f2 = (pow(x,3) + x + 1);

	f2 = f2 % p;
	while (f2 < 0){ 
		f2 = f2 + p;
	}
	
	// y^2 = (x^3 + x + 1) mod p - �i������ ��i������ �����
	cout << "�i��������� �������� Pn � �i������ ��i������ �����, ����:" << endl; 
	cout << f1 << " = " << f2 << endl;
	
	if (f1 == f2){
		cout << "����, ����� Pn = (" << x << ", " << y << ") �������� ��i�����i� ����i�.";
	}
	else{
		cout << "����, ����� Pn = (" << x << ", " << y << ") �� �������� ��i�����i� ����i�.";
	}


	return 0;
}
