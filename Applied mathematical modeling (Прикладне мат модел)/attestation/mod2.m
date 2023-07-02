% Пороскун Олена ПМ-81 
% ПММ Атестація 2

figure;
axis([-20  20, -20 20])
dt = 0.01;

for i = -15:15
    for j = 0:5
    t = 0; k = 0;
    x1 = i;  y1 = j;
    for t = 0:dt:100
        k = k+1;
        X(k) = x1;
        Y(k) = y1;
        x2 = x1 + (x1)*dt;
        y2 = y1 + (2*x1-4*y1)*dt;
        y1 = y2;   
        x1 = x2;
    end 
    hold on; grid on;
    plot(Y, X, 'k')
    end
end

xx1 = -25:25;
yy1(1:length(xx1)) = 0;
plot(xx1, yy1, 'k--');
yy2 = xx1;
xx2(1:length(yy2)) = 0;
plot(xx2, yy2, 'k--');
title('Фазовий портрет');