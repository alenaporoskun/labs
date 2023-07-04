% Екзамен СА та ТПР Пороскун О.

close all
clear all
clc



% Z = 2·x.^2-(y-1).^2
% 
% x,y [-1, 1]


n = 15;
x = -1 : (1-(-1))/(n-1) : 1;
y = x;

Z = zeros(n,n);

for j = 1:n
    Z(j, :) = 2*x.^2 - (y-1).^2;
end

surf(x, y, Z);
xlabel('x');
ylabel('y');
zlabel('Z');
title('Еталонна поверхня');
