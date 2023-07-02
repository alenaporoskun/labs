% Пороскун Олени ПМ-81  
% Homework 1          Optional Problems  
                                            % 3. Encryption Algorithm.
original = 'This is my top secret message!';
length(original);
r = randperm(length(original));
encoded  = original(r);

mat = ones(length(original),  2);
mat(:, 1) = r;
mat(:, 2) = 1:length(original);

mat;
mat = sortrows(mat);
decoded = mat(:, 2);

disp(['Original: ', original])
disp(['Encoded: ',  encoded])
disp(['Decoded: ',  encoded(decoded)])

correct = strcmp(original, encoded(decoded));

disp (['Decoded correctly (1 true, 0 false): ', num2str(correct)])












                                  
                                     
                                                              