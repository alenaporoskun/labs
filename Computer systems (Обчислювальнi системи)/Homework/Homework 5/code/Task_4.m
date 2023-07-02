% Пороскун Олени ПМ-81
% Homework 5
% Problem 4: Approximation

x_data = [1.00 2.12 3.09 5.23 7.64 9.14 11.2 14.3 16.1 19.3 22.7 25.0];
y_data = [50.6 44.1 40.3 31.2 28.7 24.8 23.2 18.3 16.2 14.8 12.9 12.6];

% y = 1/(log(a*x^2+b*x+c));
% log(a*x^2+b*x+c) = 1/y;
% a*x^2 + b*x + c = exp(1/y);

figure(4);
plot(x_data, y_data, 'bp')
grid on
hold on 

p = polyfit(x_data, y_data, 2)
f = polyval(p, x_data)
plot(x_data, f, 'r--')

y = 1./(log(f))
plot(x_data, y, 'm--')
ylim([-10 60]);

x1 = 8;
f1 = polyval(p, x1);
disp(['The value of y at x = 8 is equal to ', num2str(f1),'.']);