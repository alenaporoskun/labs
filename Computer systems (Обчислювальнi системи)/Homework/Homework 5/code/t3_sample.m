
disp(' - - - - - - - - - - - - ');
disp(' ');
disp(' ');

x = 0:10;
y = cos(x);
x1 = 0:0.1:10;
y1 = interp1(x,y,x1);
plot(x,y,'x',x1,y1,'g');
hold on

y2 = interp1(x,y,x1,'spline'); 
plot(x,y,'o ',x1,y2,'m')
grid
hold off