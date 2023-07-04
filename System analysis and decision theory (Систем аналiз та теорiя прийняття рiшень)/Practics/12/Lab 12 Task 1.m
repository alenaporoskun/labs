% СА та ТПР Лаб 12 Пороскун О. ПМ-81
% Варіант 8

close all
clear all
clc

a = 8;
x = -2:2;
u = a*x - 100*cos(x.^2);

fprintf('Функція u(x) = a*x - 100*cos(x^2)\n');
fprintf('a = %s\n', num2str(a));
fprintf('x\tu(x)\n');
for k = 1:length(u)
    fprintf('%s\t',num2str(x(k)));
    fprintf('%s\n',num2str(u(k)));
end 
fprintf('\n');