% Завдання 7

function functionsDiff7
t0 = [0 2];
var0 = [2, 10, 1, 3];
[T, var] = ode45(@rig, t0, var0);
plot(T, var)
grid on;
xlim([0, 0.5]);
ylim([0, 80]);
legend('dx', 'dy', 'd2x', 'd2y');
title('Графiк  Завдання 7');
end

function dy = rig(t,y)
dy = [y(3); y(4); 
    y(1).^2 + y(2).^2;
    y(1) - cos(y(2)).^2 + t]
end