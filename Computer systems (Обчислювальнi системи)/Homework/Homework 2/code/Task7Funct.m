% Пороскун Олени ПМ-81 
% Homework 2
% 7. Smoothing filter.

load('noisyData.mat')
Width = input('Width is ')
smoothed = rectFilt(x, Width);

function smoothed = rectFilt(X, width)
if (mod(width, 2) == 0)           
    width = width+1;               
    disp ('WARNING! Width is not odd.')
end

lim = floor(width/2);
lim1 = 1 + max(1, lim);
lim2 = length(X) - min(length(X),lim);

for i = 1:length(X)
    if(i < lim1)
        smoothed(i) = mean(X(i:i+1));
    elseif(i > lim2)
        smoothed(i) = mean(X(i-1:i));
    else %(i >= lim1 || i <= lim2)
        smoothed(i) = mean(X(i - lim : i + lim));
    end
end

if (length(smoothed) == length(smoothed))
    disp ('The lengths of x and smoothed are equal.')
else 
    disp ('The lengths of x and smoothed are NOT equal.')
end

X
smoothed

figure;
x0 = 1:length(X);
plot(x0, X, 'b.', 'MarkerSize', 11);
hold on
x1 = 1:length(smoothed);
plot(x1, smoothed, 'r', 'LineWidth', 1);
xlabel('Index');
ylabel('Data value');
legend('Original Data','Smoothed');
title('Smoothing ilolustration'); 
end