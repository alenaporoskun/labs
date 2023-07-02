
disp(' ');
disp(' - - - - - - - - - - - - ');
disp(' ');

x_data = [1.00 2.12 3.09 5.23 7.64 9.14 11.2 14.3 16.1 19.3 22.7 25.0];
y_data = [50.6 44.1 40.3 31.2 28.7 24.8 23.2 18.3 16.2 14.8 12.9 12.6];

%xx = linspace(1, 25, 12)

syms  a b c x;
y = 1./ (log(a*x.^2 + b*x + c));
P = taylor (y, x, 'Order', 6)
simplify(P)

%series(Y,5)

%pretty(P);

%F = fourier(y);
%pretty(F)



