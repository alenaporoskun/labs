load('classGrades.mat');

namesAndGrades(1:5,:)
grades = namesAndGrades(:, 2:size(namesAndGrades,2));

meanGrades = mean(grades)
meanGrades = nanmean(grades)
meanMatrix = ones(15,1)* meanGrades(1, :)

curvedGrades = 3.5*(grades./ meanMatrix);
nanmean(curvedGrades)
curvedGrades(curvedGrades > 5) = 5;
totalGrade = nanmean(curvedGrades, 2);
totalGrade = ceil(totalGrade);

letters = 'FDCBA';
letterGrades = letters(totalGrade);
disp(['Grades:  ',   letterGrades])


