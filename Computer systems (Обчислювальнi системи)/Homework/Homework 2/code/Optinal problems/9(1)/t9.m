% Пороскун Олени ПМ-81                   
% Homework 1                             Optional Problems 
% 9 Functions.

v = 4;
theta = 0:5:60;
for i = 1:length(theta)
    distance(i) = throwBall(v,theta(i));
end

plot(theta, distance, 'k', 'Linewidth', 2);

xlabel('Initial Angle(deg)');
ylabel('Distance thrown(m)');
title('Distance of ball throw as a function of release angle');

function distance = throwBall(v,theta)

HeightAtRel = 1.5;
Gravit = 9.8;

t = linspace(0, 10, 1000);
x = v *(cos(theta*(pi/180)))*t;
y = HeightAtRel + v*(sin(theta*(pi/180)))*t - 0.5*Gravit*(t.^2);

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

