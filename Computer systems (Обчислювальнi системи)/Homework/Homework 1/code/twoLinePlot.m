% 7. Plotting multiple lines and colors.
f1 = figure
%t = 0:0.1:2*pi;
t = linspace(0, 2*pi, 1000);
plot (t, sin(t))
grid
hold on
plot (t, cos(t), '--', 'color', [1 0 0])
xlabel('Time (s) ')
ylabel('Function value')
title('График 1 Sin and Cos functions ')
legend('y1 = sin(t)', 'y2 = cos(t)')
xlim([0, 2*pi])
ylim([-1.4, 1.4])