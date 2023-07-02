% Пороскун Олени ПМ-81                   
% Homework 1                             Optional Problems 
% 9 Functions.

%theta = AngleVel;       % задаем несколько углов
%v = VelocityRel;        % скорость одинакова
%distance = throwBall(v,theta)   %считаем через фукнцию расстояение
%plot(theta, distance)    %строим все растояния с разными углами на одном      %графике 


v =4;
theta = 10;
distance = throwBall(v,theta)
plot(theta, distance,'r.', 'MarkerSize', 25);
hold on

theta1 = 20;
distance1 = throwBall(v,theta1)
plot(theta1, distance1,'y.', 'MarkerSize', 25);

theta2 = 30;
distance2 = throwBall(v,theta2)
plot(theta2, distance2,'g.', 'MarkerSize', 25);

theta3 = 45;
distance3 = throwBall(v,theta3)
plot(theta3, distance3, 'b.', 'MarkerSize', 25);

theta4 = 60;
distance4 = throwBall(v,theta4)
plot(theta4, distance4, 'k.', 'MarkerSize', 25);


xlabel('Initial Angle (deg)');
ylabel('Distance thrown (m)');
title('Distance of ball throw as a function of release angle ');


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

answer = sprintf('distance = %g', distance);
disp(answer);
   
   
end

