% Пороскун Олени ПМ-81
% Homework 4
% 2. Flipping a coin. 

figure;
mas = rand(1,5000);
mas_r = round(mas);
suma = cumsum(mas_r);
i = 1:5000;
p = suma./i;
x1 = [0, 5000];
y1 = [0.5, 0.5];
plot(i, p,'k', x1, y1, 'r')
xlabel('Number of coin flips');
ylabel('Probability of heads');
legend('Sample Probability', 'Fair coin');
title('Sample Probability of Heads in n flips of a simulated coin');