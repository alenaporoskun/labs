% Пороскун Олени ПМ-81
% Homework 5
% Problem 5: Volume of Revolution

syms x;
y1 = 5*x + cos(3*x) + 1;
y2 = 10 - 2*x + log(x^2);

x_inter1 = vpasolve(y1-y2);     % vpasolve - чисельно розв’язує алгебраїчні рівняння
x_inter1 = vpa(x_inter1, 4);    % vpa -  задає число значущих цифр
y_inter1 = 10 - 2*x_inter1 + log(x_inter1^2);
y_inter1 = vpa(y_inter1, 4);    
answer1 = sprintf('The point where the two curves intersect: \nx = %g, y = %g.', x_inter1, y_inter1);
disp(answer1);    % друкуємо координати точки перетину функції у1 та у2

x_inter2 = vpasolve(y2);
x_inter2 = vpa(x_inter2, 4);
y_inter2 = 0;
answer2 = sprintf('\nThe second curve intersects the x-axis in the point: \nx = %g, y = %g.\n', x_inter2, y_inter2);
disp(answer2);    % друкуємо координати точки перетину функції у2 та осі Х

xx = linspace(0, 8, 1000);
y11 = 5*xx + cos(3*xx) + 1;
y22 = 10 - 2*xx + log(xx.^2);
figure(5);
plot(xx, y11, 'b', xx, y22, 'g');   % будуємо криві у1 та у2 
hold on
grid on
plot(x_inter1, y_inter1, 'ro', x_inter2, y_inter2, 'rs'); % будуємо точки перетину, якы ми знайшли раніше
ylim([0 40]); 

title('Task 5');
legend('y1 = 5x + cos(3x) + 1', 'y2 = 10 - 2x + ln(x^2)', 'Location', 'northwest');

V = int(pi*(y1^2 - y2^2), x_inter1, x_inter2);  % об'єм фігури обмежена двома кривими y1 та y2
V = vpa(V, 6);

fprintf('Volume of the solid formed from rotating around the x-axis the region between the two curves\n') 
fprintf('from where they intersect until where the second curve intersects the x-axis: %g \n', V)