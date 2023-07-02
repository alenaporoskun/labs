% Завдання 6  

function  functionsDiff
x0 = [0 15];
var0 = [2 5];
[X, var] = ode45(@rig, x0, var0);
plot (X, var)
title('Графiк  Завдання 6');
grid on;
end 

function dy = rig(x, y)
dy = [sin(y(2))^2 - y(1)+3*x;
    y(2)^(2/3)+(1/y(1)) - x];
end


