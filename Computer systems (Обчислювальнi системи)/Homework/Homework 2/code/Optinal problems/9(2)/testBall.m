% Пороскун Олени ПМ-81                   
% Homework 2                             Optional Problems 
% 9 Functions.

v = 15;
theta = 0:5:90;
for i = 1:length(theta)
    distance(i) = throwBall(v,theta(i));
end

plot(theta, distance, 'k', 'Linewidth', 2);

xlabel('Initial Angle(deg)');
ylabel('Distance thrown(m)');
title('Distance of ball throw as a function of release angle');

function distance = throwBall(v0,theta)

HeightAtRel = 1.5;
Gravit = 9.8;

t = linspace(0, 3, 100000);
x = v0 *(cos(theta*(pi/180)))*t;
y = HeightAtRel + v0*(sin(theta*(pi/180)))*t - 0.5*Gravit*(t.^2);

if (isempty(find(y<0)) == 1)
    disp('The ball does not hit the ground in 10 seconds.')
    distance = NaN;
else
    dis = x(find(y <= 0));
    distance = dis(1);
end  
%answer = sprintf('distance = %g', distance);
%disp(answer);
end