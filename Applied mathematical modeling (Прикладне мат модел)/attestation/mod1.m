% Атестація Пороскун О.

figure 
axis([-15  15, -15 15])
dt = 0.01;

for i = -15:15
    for j = 0:5
    t = 0; k = 0;
    q1 = i;  p1 = j;
    for t = 0:dt:100
        k = k+1;
        X(k) = q1;
        Y(k) = p1;
        q2 = q1 + ((-2)*q1-2*p1+12)*dt;
        p2 = p1 + (-q1+2*p1-3)*dt;
        p1 = p2;   
        q1 = q2;
    end 
    hold on, grid on
    plot(Y,X,'k')
    end
end

xx1 = -25:25;
yy1(1:length(xx1)) = 0;
plot(xx1, yy1, 'k--');
yy2 = xx1;
xx2(1:length(yy2)) = 0;
plot(xx2, yy2, 'k--');
xlabel('V');
ylabel('q');
title('Фазовий портрет');