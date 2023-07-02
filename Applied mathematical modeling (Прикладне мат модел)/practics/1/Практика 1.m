%  �������� ����� ��-81                ��������� ������� 1 

% �������� 1
xx = linspace(-3, 3);
yy = linspace(-4, 4);

[x,y] = meshgrid(xx, yy);
f1 = (cos(y.^x))./(exp(y)+100);
plot3(x, y, f1);
title('����i� 1  �������� 1');

% �������� 2 

%solveSystem         % ����� ������ ��������� solveSystem.m �������� run  

% �������� 3
x = linspace(-pi, pi);
y = (sin(x).^2 + cos(2.*x))./(sin(x.^2)+2);
plot(x,y);
title('����i� 2 �������� 3');

% �������� 4

x = 1:10;
a = sum(x.^2./(acos(x.^4)+5));

x = 1:3;
b = sum ((x.^2 + tan(x+1))./(exp(x)-1));

x = 5:10;
c = prod((sin(x)).^2./(1+exp(-x)));

% �������� 5

syms x
y1 = tan(x)+5*x^3;
z1 = diff(y1, 2);

y2 = exp(-x)+cos(2*pi-x^2);
z2 = diff(y2, 10);


% �������� 6  % ����� ������ ��������� functionsDiff.m �������� run  
functionsDiff

% �������� 7                     ���������� 
f2135

% �������� 8                     ���������� 
solvee

% �������� 9                     ���������� 
num9

% �������� 10

x = 0:0.001:100;
f1 = exp(sin(x)) + 1;
f2 = ((cos(x)).^2) - 5;
f3 = 1./(cos(x.^2)+5);
plot(x, f1, x, f2, x, f3)
grid on;
gtext('f1');
gtext('f2');
gtext('f3');





