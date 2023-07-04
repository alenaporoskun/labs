% СА та ТПР Лаб 9 Пороскун О. ПМ-81
% Варіант 8

close all
clear all
clc

% Завдання 2
% Задача 2.1. Побудувати графік функції згідно варіанту.

figure;
b8 = 1.74;
x8 = -15:0.01:15;

for i = 1:length(x8)
    if x8(i) <= 0
        s8(i) = (x8(i) + 1)/(1000 + b8);
    else 
        s8(i) = 100*x8(i) + 5;
    end
end

plot(x8, s8);
grid on;
title('Завдання 2.1');
legend('s = (x + 1)/(1000 + b) або s = 100*x + 5');
 

% Задача 2.2. Побудувати (різними кольорами) графіки функцій (N, N - 1,N + 1 де N - номер варіанта) 
% в одному вікні. Передбачити необхідні оформлення графіків.

figure;
a7 = 100;
x7 = -6.8:0.01:16.2;

for i = 1:length(x7)
    if x7(i) < 0
        p7(i) = 0.33*((x7(i)).^2 + x7(i) + 1);
    else 
        p7(i) = abs(10 - x7(i)) + a7;
    end
end


b9 = -1.2;
x9 = -25:0.01:15;

for i = 1:length(x9)
    if x9(i) <= -10
        z9(i) = b9^3;
    else 
        z9(i) = abs(x9(i)) + 0.33*x9(i) + (sin(x9(i)))^2;
    end
end

plot(x8, s8, 'g', x7, p7, 'c', x9, z9, '--m', 'lineWidth', 2); % N, N - 1,N + 1 -> 8, 7, 9 вар.
grid on;
title('Завдання 2.2');
legend('s = (x + 1)/(1000 + b) або s = 100*x + 5', ...
       'p = 0.33*(x^2 + x + 1) або p = abs(10 - x) + a7', ...
       'z = b^3 або z = abs(x) + 0.33*x + (sin(x))^2', 'location', 'Best');


% Задача 2.3. Побудувати три графіка функцій (N, N - 1, N + 1 де N - номер варіанта) 
% на одному рисунку, але кожен в окремому вікні (в стовпчик і в рядочок).

% в стовпчик
figure;
subplot(3, 1, 1);
plot(x8, s8); grid on;
legend('s = (x + 1)/(1000 + b) або s = 100*x + 5', 'location', 'Best');
title('Завдання 2.3(в стовпчик)');

subplot(3, 1, 2);
plot(x7, p7);  grid on;
legend('p = 0.33*(x^2 + x + 1) або p = abs(10 - x) + a7', 'location', 'Best');

subplot(3, 1, 3);
plot(x9, z9); grid on;
legend('z = b^3 або z = abs(x) + 0.33*x + (sin(x))^2', 'location', 'Best');

% в рядочок
figure;
subplot(1, 3, 1);
plot(x8, s8); grid on;
legend('s = (x + 1)/(1000 + b) або s = 100*x + 5', 'location', 'Best');

subplot(1, 3, 2);
plot(x7, p7);  grid on;
legend('p = 0.33*(x^2 + x + 1) або p = abs(10 - x) + a7', 'location', 'Best');
title('Завдання 2.3(в рядочок)');

subplot(1, 3, 3);
plot(x9, z9); grid on;
legend('z = b^3 або z = abs(x) + 0.33*x + (sin(x))^2', 'location', 'Best');

