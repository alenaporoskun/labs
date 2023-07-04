% �� �� ��� ��� 9 �������� �. ��-81
% ������ 8

close all
clear all
clc

% �������� 1
% �������� 1.1 ���������� ������ ������� ����� �������.

figure;
x8 = 0:0.01:10;
b8 = 5.5;
f8 = 0.77*x8 + sin(x8) - b8;
plot(x8, f8);
grid on;
title('�������� 1.1');
legend('f = 0.77*x + sin(x) - b');


% ������ 1.2. ���������� ��� ������� ������� (N, N - 1,N + 1 �� N - ����� �������) � ������ ���.

figure;
x7 = 0:0.01:10;
a7 = 5;
f7 = 0.75*abs(x7 - a7) + 10*a7;

x9 = -5:0.01:5;
a9 = 2;
b9 = 3.6;
q9 = a9*b9 + abs(x9) - sqrt(4*a9);
f9 = q9;

plot(x8, f8, x7, f7, x9, f9); % N, N - 1,N + 1 -> 8, 7, 9 ���.
grid on;

title('�������� 1.2');
legend('f = 0.77*x + sin(x) - b', 'f = 0.75*abs(x - a) + 10*a', ...
       'q = a*b + abs(x) - sqrt(4*a)', 'location', 'Best');

% ������ 1.3. ���������� ��� ������� ������� (N, N - 1, N + 1 �� N - ����� �������) 
% �� ������ �������, ��� ����� � �������� ���(� �������� � � �������).

% � ��������
figure;
subplot(3, 1, 1);
plot(x8, f8); grid on;
legend('f = 0.77*x + sin(x) - b');
title('�������� 1.3(� ��������)');

subplot(3, 1, 2);
plot(x7, f7);  grid on;
legend('f = 0.75*abs(x - a) + 10*a');

subplot(3, 1, 3);
plot(x9, f9); grid on;
legend('q = a*b + abs(x) - sqrt(4*a)');

% � �������
figure;
subplot(1, 3, 1);
plot(x8, f8); grid on;
legend('f = 0.77*x + sin(x) - b');

subplot(1, 3, 2);
plot(x7, f7);  grid on;
legend('f = 0.75*abs(x - a) + 10*a');
title('�������� 1.3(� �������)');

subplot(1, 3, 3);
plot(x9, f9); grid on;
legend('q = a*b + abs(x) - sqrt(4*a)');
