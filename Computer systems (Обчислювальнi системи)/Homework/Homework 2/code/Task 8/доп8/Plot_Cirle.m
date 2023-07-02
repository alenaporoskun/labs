
[x,y] = getCircless([1, 2],1)

function [x,y] = getCircless(center,r)
t=0: pi/100: 2*pi;
center = [1,2];
plot(center(1)+r*sin(t),center(2)+r*cos(t))
end