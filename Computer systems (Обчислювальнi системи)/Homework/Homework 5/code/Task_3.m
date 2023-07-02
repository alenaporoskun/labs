% ѕороскун ќлени ѕћ-81
% Homework 5
% Problem 3: Interpolation

figure(3);
T = 0:5:30;
Oxygen = [11.4, 10.3, 8.96, 8.08, 7.35, 6.73, 6.20];
plot(T, Oxygen, 'ko', 'MarkerSize', 5);
grid on; hold on;

T11 = 30*rand(1,7);
T11 = sort(T11)
O11 = interp1(T, Oxygen, T11)
plot(T11, O11, 'm--', 'LineWidth', 1);

T22 = 10*rand(1,3);
T22 = sort(T22)
O22 = interp1(T, Oxygen, T22, 'PCHIP')  % 'pchip' Ч интерпол€ци€ кубическим эрмитовым сплайном
plot(T22, O22, 'c', 'LineWidth', 1.5);

Temp = 2.5;
O1 = interp1(T, Oxygen, Temp)
O2 = interp1(T(1:3), Oxygen(1:3), Temp, 'PCHIP')
O3 = interp1(T, Oxygen, Temp, 'spline')           % splineТ Ц интерпол€ци€ кубическим сплайном

title('Task 3 Interpolation');
xlabel('T(C)');
ylabel('Dissolved oxygen (mg/L)');
legend('data points','a polynomial (all the data points)','a polynomial (the first 3 data points)');