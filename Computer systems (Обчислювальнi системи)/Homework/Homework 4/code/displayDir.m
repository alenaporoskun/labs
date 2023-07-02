% Пороскун Олени ПМ-81
% Homework 4
% 5. Using Structs. 

a = dir
size_a = num2str(size(a));
disp(['Size of a: ' size_a]);

for i = 1:length(a) 
    if (a(i).isdir == 0) 
        answer = sprintf('File %s contains %g bytes.', a(i).name, a(i).bytes);
        disp(answer);
    end
end