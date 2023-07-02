% Завдання 9

function functionsDiff9
x0 = [0 0.255];
var0 = [4 2];
[X, var] = ode45(@fu, x0, var0);
plot(X, var)
grid on
title('Графiк Завдання 9');
end

function dx = fu(x, y)
dx = [y(1)^2 + y(2) - 3;
     cos(y(1))+x];
end