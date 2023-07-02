% Пороскун Олени ПМ-81 
% Homework 2
% Task 8.Plot a circle.

r = 0.45;
center_x = [-1, 0, 1, -0.5, 0.5];
center_y = [0, 0, 0, -0.5, -0.5];
colours = ['b', 'k', 'r', 'y', 'g'];

figure;

for i = 1:5
    [x,y] = getCircles([center_x(i), center_y(i)], r, colours(i));
end

function [x,y] = getCircles(center, r, color)
t = 0:0.001:2*pi;
x = r*cos(t);
y = r*sin(t);
plot(center(1)+x, center(2)+y, color, 'LineWidth', 5);
hold on
axis('equal')
end