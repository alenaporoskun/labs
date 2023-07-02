%Завдання 8

function solveSystem
x0 = [0 2];
y0 = [4; 2; 1];
[X, Y] = ode45(@sol, x0, y0);
plot(X, Y)
grid on;
hold on;
title('Завдання 8');

gtext('y1');
gtext('y2');
gtext('y3');
end

function dy = sol(x,y)
dy(3,1) = y(1).^2 + 3*x;
dy(1,1) = y(2);
dy(2,1) = y(3);
end

