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

	int lambda, x2, y2;
	// x1 = x2, y1 = y2, 2Pn = Pn + Pn = (x, y) + (x, y) = 2(x, y)
	//lambda = ((y2 - y1) / (x2 - x1)) % p;
	lambda = 0;
	
	// x2 = (lambda^2 - 2*x)mod p або x3 = (lambda^2 - x1 - x2) mod p
	x2 = (pow(lambda, 2) - 2*x);
	x2 = x2 % p; 
	while (x2 < 0){ 
		x2 = x2 + p;
	}
	
	//y2 = (lambda*(x - x2) - y) mod p або y3 = (lambda*(x1 - x3) - y1) mod p
	y2 = (lambda*(x - x2) - y) % p;
	while (y2 < 0){ 
		y2 = y2 + p;
	}	
	
	cout << "Отже, 2Pn = Pn + Pn = (" << x2 << ", " << y2<< ")"<< endl;
    
	return 0;
}
