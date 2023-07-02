% Пороскун Олени ПМ-81
% Homework 4
% 3. Histogram

figure;
lambda = 5;
X = poissrnd(lambda, 1, 1000);
[X, N] = hist(X,14)
X = X./ sum(X)
bar([0:13], X,'b')
hold on 
N1 = 0:13;
Y = poisspdf(N1,lambda)
plot(N1, Y, 'r-', 'LineWidth', 2);
xlabel('Value');
ylabel('Probability');
title('Poisson distribution and observed histogram');
legend('Experimental histogram', 'Actual Poisson Distribution');