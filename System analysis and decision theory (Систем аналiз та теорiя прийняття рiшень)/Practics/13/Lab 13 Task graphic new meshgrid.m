
figure;
[x1, y1] = meshgrid([-2: (2-(-2))/(n-1) :2]);
Z1 = y1.^2 * cos(x1);
surf(x1, y1, Z1);
%shading interp
colorbar
xlabel('x1'); ylabel('y1'); zlabel('Z1');
legend('Z1 = y1.^2 * cos(x1);');

