% Пороскун Олени ПМ-81
% Homework 2
% 8.Plot a circle.

c = [0, 0];
rad = 1;
[x, y] = getCircle(c, rad)

function [x, y] = getCircle(center, r)
x0 = center(1);
y0 = center(2);
t = linspace(0, 2*pi, 1000);
x = x0 + cos(t);
y = y0 + sin(t);
plot(x, y, 'LineWidth', 4, 'Color', [0 0 1]);
colormap(jet)
end
