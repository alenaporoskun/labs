% Пороскун Олени ПМ-81                   
% Homework 1                               Optional Problems 
% 11. Buy and sell a stock.

%endValue=tradeStock(initialInvestment, price, buy, sell) 

load ('googlePrices.mat');
price;
len = length(price);
pr = price';
ps = peaks';
lw = lows';

figure;
x1 = 1:length(price);
plot(x1, price);
xlabel('index');
ylabel('price');
title('Task 11 TradeStock');
grid on
axis('xy');

maximum = max(price);
ind = find(price == maximum);

initialInvestment = 100000
endValue = initialInvestment
buy = lows;
sell = peaks;

for i = 1:length(lows) 
    k = floor(endValue/price(buy(i)));
    if (k > 0)
        disp(k)
        endValue = endValue - k*price(buy(i)) - 12.95; 
        endValue = endValue + k*price(sell(i)) - 12.95;
        ans = sprintf('endValue(%g) = %g', i, endValue);
        disp(ans);
    end
end 

endValue = sprintf('endValue = %10.3f', endValue);
disp(endValue)





