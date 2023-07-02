% Пороскун Олени ПМ-81 
% Homework 2
% Task 8.Plot a circle.

center = [0, 0];
r = 1;
[x,y] = getCircle(center,r);

colors = ['b', 'c', 'g', 'y', 'r']; 

for rad = 2:5
    t1 = 0:0.01:2*pi;
    x1 = rad*cos(t1);
    y1 = rad*sin(t1);
    plot(x1, y1, colors(rad), 'LineWidth', 6);
end


function [x,y] = getCircle(center,r)
figure;
t = 0:0.001:2*pi;
x = r*cos(t);
y = r*sin(t);
plot(center(1)+x, center(2)+y, 'LineWidth', 12);
hold on
axis('equal')
end
