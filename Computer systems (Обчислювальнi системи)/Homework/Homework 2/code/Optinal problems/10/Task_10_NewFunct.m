% Пороскун Олени ПМ-81                   
% Homework 2                               Optional Problems 
% 10. Smoothing nonuniformly sampled data.

load('optionalData.mat');
x
Width = input('Width is ')
smoothed = rectFilt(x, Width);

function smoothed = rectFilt(x, width)

figure;
plot(x(:,1), x(:,2), 'b.', 'MarkerSize', 11);
hold on 

X = x(:, 1);
Y = x(:, 2);

lim = floor(width/2);
lim1 = 1 + max(1, lim);
lim2 = length(x) - min(length(x),lim);

for i = 1:length(x)
    smoothed(i, 1) =  X(i);
    if(i < lim1)
        smoothed(i,2) = mean(Y(i:i+1));
    elseif(i > lim2)
        smoothed(i,2) = mean(Y(i-1:i));
    else %(i >= lim1 || i <= lim2)
        smoothed(i,2) = mean(Y(i - lim : i + lim));
    end
end
sm_2 = smoothed(:,2)
plot(smoothed(:, 1), smoothed(:, 2), 'r')
xlabel('X Value');
ylabel('Y Value');
legend('Original Data','Smoothed', 'Location','northwest');
title('Smoothing Illustration, nonuniform spacing');
end 