function f
r = 3;
figure; 
hold all;
getCircles([0 0], r, 'b');
getCircles([2*r+1 0], r, 'k');
getCircles([4*r+2 0], r, 'r');
getCircles([1*r+1 -r], r, 'y');
getCircles([3*r+2 -r], r, 'g');
axis('equal') 
end
 
function f1 = getCircles(center, r, color)
t=0: pi/100: 2*pi;
plot(center(1)+r*sin(t),center(2)+r*cos(t), color, 'LineWidth', 5)
end