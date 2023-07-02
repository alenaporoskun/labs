% Пороскун Олени ПМ-81  
% Homework 1                             Optional Problems 

% 1. Throwing a ball.

HeightAtRel = 1.5;
Gravit = 9.8;
VelocityRel = 4;
AngleVel = 45;

t = linspace(0, 1, 1000);

x = VelocityRel*(cos(AngleVel*(pi/180)))*t;
y = HeightAtRel + VelocityRel*(sin(AngleVel*(pi/180)))*t - 0.5*Gravit*(t.^2)

s = find(y<0);
X = x(s(1));
answer = sprintf('The ball hits the ground at a distance of %g meters.', X);
disp(answer);

figure
plot(x, y);
%grid on;
xlabel('Distance (m)');
ylabel('Ball Height (m)');
title('Ball Trajectory');
hold on

x2 = linspace(0, max(x), 10);
y2(1:length(x2))=0;
plot(x2, y2, 'k--')



