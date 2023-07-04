% СА та ТПР Лаб 9 Пороскун О. ПМ-81
% Варіант 8

close all
clear all
clc

% Завдання 3
% Задача 3.1. Побудувати тривимірний графік функції 2-х змінних згідно варіанту.

figure;
[a8, x8] = meshgrid([-25:25]);
u8 = a8.*x8 - 100*cos(x8.^2);
surf(a8, x8, u8);
shading interp
colorbar
xlabel('a'); ylabel('x'); zlabel('u');
legend('u = a*x - 100*cos(x^2)');
title('Завдання 3.1');

% Задача 3.2.Побудувати 4 графіка функцій (N, N - 1, N + 1, N + 2 де N - номер
% варіанта) на одному рисунку, але кожен в окремому вікні (матрицею 2*2).

% N = 8
figure;
subplot(2, 2, 1);
%[a8, x8] = meshgrid([-25:25]);
%u8 = a8.*x8 - 100*cos(x8.^2);
surf(a8, x8, u8);
shading interp
colorbar
xlabel('a'); ylabel('x'); zlabel('u');
legend('u = a*x - 100*cos(x^2)');
title('Завдання 3.2');

% N - 1 = 7
subplot(2, 2, 2);
[a7, x7] = meshgrid([-25:25]);
p7 = cos(x7) + a7.*exp(x7);
surf(a7, x7, p7);
shading interp
colorbar
xlabel('a'); ylabel('x'); zlabel('p');
legend('p = cos(x) + a*exp(x)', 'location', 'best');

% N + 1 = 9
subplot(2, 2, 3);
[a9, x9] = meshgrid([-25:25]);
r9 = x9 - a9.*cos((x9).^2);
surf(a9, x9, r9);
shading interp
colorbar
xlabel('a'); ylabel('x'); zlabel('r');
legend('r = x - a*cos(x^2)');

% N + 2 = 10
subplot(2, 2, 4);
[a10, x10] = meshgrid([-25:25]);
p10 = 0.33*a10.*exp(x10);
surf(a10, x10, p10);
shading interp
colorbar
xlabel('a'); ylabel('x'); zlabel('p');
legend('p = 0.33*a*exp(x)');
