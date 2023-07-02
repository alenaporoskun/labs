% Пороскун Олени ПМ-81                   
% Homework 2                               Optional Problems 
% 10. Smoothing nonuniformly sampled data.

load('optionalData.mat');
x
Width = input('Width is ')
smoothed = rectFilt(x, Width);

function smoothed = rectFilt(x, width)

figure;
plot(x(:,1), x(:,2), '.', 'MarkerSize', 11);
hold on 

X = x(:, 1);
Y = x(:, 2);
smoothed(1:length(x), 1) =  X;

mx = max(X);
mn = min(X);
x1 = X;

if (width > mn && width < mx)
    x1(1) = ((X(1)+X(2)))/width;
    len = length(X);
    x1(len) = ((X(len-1)+X(len)))/width;
    for i = 2:length(x)-1
        x1(i) = (x1(i-1)+x1(i))/width;
    end
end

x1
smoothed = interp1(X, Y, x1)
plot(X, smoothed)
xlabel('X Value');
ylabel('Y Value');
legend('Original Data','Smoothed', 'Location','northwest');
title('Smoothing Illustration, nonuniform spacing');
end 