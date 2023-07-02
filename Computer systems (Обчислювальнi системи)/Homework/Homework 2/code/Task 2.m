% Пороскун Олени ПМ-81
% Homework 2

%2.	Subplot and axis modes.
figure;
subplot(2,2,1);
load('mitMap.mat')
image(mit)
colormap(cMap)
axis('square')
title('Square');


subplot(2,2,2);
image(mit)
axis('tight')
title('Tight');

subplot(2,2,3);
image(mit)
axis('equal')
title('Equal');

subplot(2,2,4);
image(mit)
axis('xy')
title('XY');
