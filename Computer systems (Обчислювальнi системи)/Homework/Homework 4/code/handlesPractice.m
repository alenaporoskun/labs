% Пороскун Олени ПМ-81
% Homework 4
% 6. Handles.

x = 0:pi/100:2*pi;
y = sin(x);
plot(x, y, 'r');
xlim([0, 2*pi])
set(gca, 'XTick', [0 pi 2*pi]);
set(gca, 'XTickLabel', {'0', '1', '2'});
set(gca, 'YTick', -1:.5:1);
grid on;
set(gca, 'XColor', 'g');
set(gca, 'YColor', 'c');
set(gca, 'Color',  'k');
set(gcf, 'Color', [.3 .3 .3]);
title('One sine wave from 0 to 2\pi','FontSize',14,'FontWeight','Bold','Color', 'w');
xlabel ('X values (in terms of \pi)', 'FontSize',12, 'Color','c');
ylabel('Sin(X)', 'FontSize', 12, 'Color', 'g');