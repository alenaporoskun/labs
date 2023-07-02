#include <iostream>
#include <math.h>

using namespace std;

int main() {

	setlocale (LC_CTYPE, "ukr");

	int Pn[2];

	cout << "Введiть значення Pn: ";
    cin >> Pn[0] >> Pn[1];
    cout << "Значення Pn = (" << Pn[0] << ", " << Pn[1] << ")"<< endl;
    
    int x = Pn[0], y = Pn[1];
    //cout << "Значення Pn: x = " << x << ", y = " << y << endl;
    
    int a = 1, b = 1, p = 23;
    
    int f1, f2;
    f1 = pow(y, 2);
    f2 = (pow(x,3) + x + 1);

	f2 = f2 % p;
	while (f2 < 0){ 
		f2 = f2 + p;
	}
	
	// y^2 = (x^3 + x + 1) mod p - рiвняння елiптичної кривої
	cout << "Пiдставивши значення Pn у рiвняння елiптичної кривої, маємо:" << endl; 
	cout << f1 << " = " << f2 << endl;
	
	if (f1 == f2){
		cout << "Отже, точка Pn = (" << x << ", " << y << ") належить елiптичнiй кривiй.";
	}
	else{
		cout << "Отже, точка Pn = (" << x << ", " << y << ") не належить елiптичнiй кривiй.";
	}


	return 0;
}
