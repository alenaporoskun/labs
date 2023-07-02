%  Пороскун Олена ПМ-81                Практичне заняття 1 

% Завдання 1
xx = linspace(-3, 3);
yy = linspace(-4, 4);

[x,y] = meshgrid(xx, yy);
f1 = (cos(y.^x))./(exp(y)+100);
plot3(x, y, f1);
title('Графiк 1  Завдання 1');

% Завдання 2 

%solveSystem         % можно просто запустить solveSystem.m командой run  

% Завдання 3
x = linspace(-pi, pi);
y = (sin(x).^2 + cos(2.*x))./(sin(x.^2)+2);
plot(x,y);
title('Графiк 2 Завдання 3');

% Завдання 4

x = 1:10;
a = sum(x.^2./(acos(x.^4)+5));

x = 1:3;
b = sum ((x.^2 + tan(x+1))./(exp(x)-1));

x = 5:10;
c = prod((sin(x)).^2./(1+exp(-x)));

% Завдання 5

syms x
y1 = tan(x)+5*x^3;
z1 = diff(y1, 2);

y2 = exp(-x)+cos(2*pi-x^2);
z2 = diff(y2, 10);


% Завдання 6  % можно просто запустить functionsDiff.m командой run  
functionsDiff

% Завдання 7                     аналогично 
f2135

% Завдання 8                     аналогично 
solvee

% Завдання 9                     аналогично 
num9

% Завдання 10

x = 0:0.001:100;
f1 = exp(sin(x)) + 1;
f2 = ((cos(x)).^2) - 5;
f3 = 1./(cos(x.^2)+5);
plot(x, f1, x, f2, x, f3)
grid on;
gtext('f1');
gtext('f2');
gtext('f3');





