% Пороскун Олени ПМ-81                   
% Homework 2                               Optional Problems 
% 11. Buy and sell a stock.

load ('googlePrices.mat');

buy = lows;
sell = peaks;

initialInvestment = 100;
a = sprintf('initialInvestment = %10.3f', initialInvestment);
disp(a)
endValue = tradeStock(initialInvestment, price, buy, sell);

initialInvestment = 100000;
a = sprintf('initialInvestment = %10.3f', initialInvestment);
disp(a)
endValue = tradeStock(initialInvestment, price, buy, sell);

function endValue = tradeStock(initialInvestment, price, buy, sell)

endValue = initialInvestment;
for i = 1:length(buy) 
    k = floor(endValue/price(buy(i)));
    if (k > 0)
        endValue = endValue - k*price(buy(i)) - 12.95; 
        endValue = endValue + k*price(sell(i)) - 12.95;
    end
end 
endValue = sprintf('endValue = %10.3f', endValue);
disp(endValue)
end