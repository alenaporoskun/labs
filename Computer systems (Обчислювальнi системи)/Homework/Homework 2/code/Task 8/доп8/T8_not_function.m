% Пороскун Олени ПМ-81 
% Homework 2
% Task 8.Plot a circle.

figure;

t = 0:0.001:2*pi;
x = cos(t);
y = sin(t);
plot(x, y, 'LineWidth', 7)
%colormap(jet)
hold on

colors = ['b', 'c', 'g', 'y', 'r']; 

for i = 1:5
    t1 = 0:0.01:2*pi;
    x1 = i*cos(t1);
    y1 = i*sin(t1);
    plot(x1, y1, colors(i), 'LineWidth', 4)
    %plot(x1, y1, 'Color', [.5 .8 .3], 'LineWidth', 2);
end

axis('equal')