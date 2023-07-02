% Пороскун Олени ПМ-81
% Homework 2

% 1.Semilog plot. 
x = 1:6;
y = [15, 25, 55, 115, 144, 242];
semilogy(x, y,  'ms', 'MarkerSize', 10, 'LineWidth',  4);
xlabel('Years');
ylabel('The number of students');
title('1.Semilog plot');
grid on;
xlim([0, 7]);
