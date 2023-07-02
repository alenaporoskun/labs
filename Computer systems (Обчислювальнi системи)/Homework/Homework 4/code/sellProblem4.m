% Пороскун Олени ПМ-81
% Homework 4
% 4. Practice with cells. 

arr_cell = cell(3,3);
arr_cell(:, 1) =  {'Joe', 'Sarah', 'Pat'};
arr_cell(:, 2) = {'Smith', 'Brown', 'Jackson'};
arr_cell(:, 3) = {30000, 150000, 120000};
disp(arr_cell);

arr_cell(2, 2) = {'Meyers'};
disp(arr_cell);

arr_cell{3, 3} = arr_cell{3, 3} + 50000;
disp(arr_cell);