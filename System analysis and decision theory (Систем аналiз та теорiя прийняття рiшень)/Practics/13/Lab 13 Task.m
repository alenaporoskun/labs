% СА та ТПР Лаб 13 Пороскун О. ПМ-81
% Варіант 8

close all
clear all
clc

% Побудова графіка функції Z = y.^2*cos(x)	
% В області x,y є [-2, 2].

n = 15;
x = -2 : (2-(-2))/(n-1) : 2;
y = x;
Z = zeros (n, n);

for j = 1:n
    Z(j, :) = y.^2 * cos(x(j));
end

surf (x, y, Z)
xlabel('x')
ylabel('y')
zlabel('Z')
title('Target');
