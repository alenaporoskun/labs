% �� �� ��� ��� 9 �������� �. ��-81
% ������ 8

close all
clear all
clc

% �������� 2
% ������ 2.1. ���������� ������ ������� ����� �������.

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
title('�������� 2.1');
legend('s = (x + 1)/(1000 + b) ��� s = 100*x + 5');
 

% ������ 2.2. ���������� (������ ���������) ������� ������� (N, N - 1,N + 1 �� N - ����� �������) 
% � ������ ���. ����������� �������� ���������� �������.

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

plot(x8, s8, 'g', x7, p7, 'c', x9, z9, '--m', 'lineWidth', 2); % N, N - 1,N + 1 -> 8, 7, 9 ���.
grid on;
title('�������� 2.2');
legend('s = (x + 1)/(1000 + b) ��� s = 100*x + 5', ...
       'p = 0.33*(x^2 + x + 1) ��� p = abs(10 - x) + a7', ...
       'z = b^3 ��� z = abs(x) + 0.33*x + (sin(x))^2', 'location', 'Best');


% ������ 2.3. ���������� ��� ������� ������� (N, N - 1, N + 1 �� N - ����� �������) 
% �� ������ �������, ��� ����� � �������� ��� (� �������� � � �������).

% � ��������
figure;
subplot(3, 1, 1);
plot(x8, s8); grid on;
legend('s = (x + 1)/(1000 + b) ��� s = 100*x + 5', 'location', 'Best');
title('�������� 2.3(� ��������)');

subplot(3, 1, 2);
plot(x7, p7);  grid on;
legend('p = 0.33*(x^2 + x + 1) ��� p = abs(10 - x) + a7', 'location', 'Best');

subplot(3, 1, 3);
plot(x9, z9); grid on;
legend('z = b^3 ��� z = abs(x) + 0.33*x + (sin(x))^2', 'location', 'Best');

% � �������
figure;
subplot(1, 3, 1);
plot(x8, s8); grid on;
legend('s = (x + 1)/(1000 + b) ��� s = 100*x + 5', 'location', 'Best');

subplot(1, 3, 2);
plot(x7, p7);  grid on;
legend('p = 0.33*(x^2 + x + 1) ��� p = abs(10 - x) + a7', 'location', 'Best');
title('�������� 2.3(� �������)');

subplot(1, 3, 3);
plot(x9, z9); grid on;
legend('z = b^3 ��� z = abs(x) + 0.33*x + (sin(x))^2', 'location', 'Best');

