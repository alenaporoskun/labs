% Пороскун Олени ПМ-81                   
% Homework 2                             Optional Problems 
% 9 Logical indexing and piecewise plots. Transistor I-V curves.

Vt = 1;
K = 50;
Vds = 0:0.5:5;
Vgs = [0, 1, 2, 3, 4, 5];

for i = 1:6
    for j = 1:length(Vds)
        lin(j) = (Vds(j) >= 0 &  Vgs(i) - Vt >= Vds(j));
        sat(j) = (Vds(j) > Vgs(i) - Vt & Vgs(i) - Vt > 0);
        if (Vds(j) >= 0 & Vgs(i) - Vt < 0)                    % cutof
            Ids(j) = 0;                   
        elseif (lin(j) == 1)                                  % linear
            Ids(j) = K*((Vgs(i) - Vt)*Vds(j) - 0.5*(Vds(j)^2));
        elseif (sat(j) == 1)                                  % saturation
            Ids(j) = 0.5*K*((Vgs(i) - Vt)^2);
        end
    end
    Ids
    plot(Vds, Ids)
    hold on
end

title('Transistor Drain Current');
ylim([0 500]);
xlabel('V DS (V)');
ylabel('I DS (µA)');
legend('VGS = 0V', 'VGS = 1V', 'VGS = 2V', 'VGS = 3V', 'VGS = 4V', 'VGS = 5V', 'Location','northwest');