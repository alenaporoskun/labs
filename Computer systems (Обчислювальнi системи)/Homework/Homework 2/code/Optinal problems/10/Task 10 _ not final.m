% Пороскун Олени ПМ-81                   
% Homework 1                               Optional Problems 
% 10. Smoothing nonuniformly sampled data.

load('optionalData.mat');
x
figure;
plot(x(:,1), x(:,2), '.', 'MarkerSize', 11);
hold on 

X = x(:, 1)
Y = x(:, 2)
smoothed(1:length(x), 1) =  X;

x1 = X;
x1(1) = ((X(1)+X(2)))/2;
len = length(x);
x1(length(x)) = ((X(len-1)+X(len)))/2;

for i = 2:length(x)-1
    x1(i) = (x1(i-1)+x1(i))/2;
end

x1
smoothed = interp1(X, Y, x1)
plot(X, smoothed)
