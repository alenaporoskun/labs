% Пороскун Олени ПМ-81
% Homework 2
% 6. Loops and flow control.

N = input('Введіть N:');
loopTest(N)
function loopTest(N)
A = 1:N;
for i = 1:N
    a = num2str(A(i),'%g  ');
    mod2 = mod(A(i), 2);
    mod3 = mod(A(i), 3);
    if (mod2 == 0 | mod3 == 0)
        if (mod2 == 0 & mod3 == 0)
        disp([a, ' is divisible by 2 AND 3'])
        elseif (mod2 == 0)
            disp([a, ' is divisible by 2']) 
        elseif (mod3 == 0)
            disp([a, ' is divisible by 3'])
        end
    else
        disp([a, ' is NOT divisible by 2 or 3']) 
    end
end
end 