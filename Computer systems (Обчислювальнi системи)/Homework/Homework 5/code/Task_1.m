% Пороскун Олени ПМ-81
% Homework 5
% Problem 1: Component Analysis

% Components: 1, 2, 3.

Material = [15,   17,   19;    % Metal (g/component)
           0.3,  0.4, 0.55;    % Plastic (g/component)
           1.0,  1.2,  1.5]    % Rubber (g/component)
Total_component = [3.89;
                   0.095;
                   0.282];
Total_component = Total_component*10^3  % переводимо з кілограмів в грами 

answer = Material \ Total_component;  
answer = sprintf('Component 1 = %g \nComponent 2 = %g \nComponent 3 = %g',+...
+ answer(1), answer(2), answer(3));
disp(answer)
