% Пороскун Олени ПМ-81                   
% Homework 1                               Optional Problems 
% 10. Smoothing nonuniformly sampled data.

disp('---------------')
disp(' ')

load('optionalData.mat');
x
figure;
plot(x(:,1), x(:,2), '.', 'MarkerSize', 11);
hold on 

X = x(:, 1)
smoothed(1:length(x), 1) =  X;

x1(1) = X(1, 1)
x1(length(X)) = X(length(X))
for i = 2:length(x)
    x1(i) = (X(i-1)+X(i))/2;
end

x1
smoothed(1:length(x1), 2) = interp1(x(:,1),x(:,2), x1)
y1 = smoothed(1:length(x1), 2)
plot(X, y1)



