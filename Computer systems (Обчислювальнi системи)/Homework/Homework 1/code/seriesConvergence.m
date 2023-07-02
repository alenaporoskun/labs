% Пороскун Олени ПМ-81 
% Homework 1          Optional Problems  
                                     % 2. Convergence of infinite series.
p = 0.99; 
k = 0:1000;
geomSeries = p.^k;
G = 1/(1-p);

figure;
x = 0:max(k);
y(1:length(x)) = G;
plot(x, y, 'r');
hold on;

y2 = cumsum(geomSeries);
plot(x, y2, 'b');
xlabel('Index ');
ylabel('Sum');
title('Convergence of geometric series with p=0.99');
legend('Infinite sum', 'Finite Sum');

p = 2;
n = 1:500;
pSeries = 1./(n.^p);
P = (pi^2)/6;
figure;
x3 = 0:max(n);
y3(1:length(x3)) = P;
plot(x3, y3, 'r')
hold on

x4 = 1:max(n);
y4 = cumsum(pSeries);
plot(x4, y4, 'b')
xlabel('Index');
ylabel('Sum');
ylim([1, 1.8]);
title('Convergence of geometric series with p=2');
legend('Infinite sum', 'Finite Sum');