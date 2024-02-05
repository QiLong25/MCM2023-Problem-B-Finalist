clear
clc

stock = [45874, 64997, 85067, 78575, 86562, 98944, 97684, 93489, 92324, 101358, 77484, 50758, 117344]./15263;
wildlife = [37188, 13011, 11547, 13985, 19933, 10632, 11641, 20189, 20457, 17617, 24830, 24842, 13178]./15263;
x = 1./stock;
[Rsw, Psw] = corrcoef(x, wildlife);
a = polyfit(x, wildlife, 1);
xhat = linspace(40000, 120000, 100)./15263;
yhat = polyval(a, 1./xhat);

popu = [490490, 505303, 561656, 615927, 675443, 707324, 775671, 812283, 850920]./15263;
wild = [58392, 37188, 13011, 11547, 13985, 19933, 10632, 11641, 20189]./15263;
x2 = 1./popu;
[Rpw, Ppw] = corrcoef(x2, wild);
b = polyfit(x2, wild, 1);
xhat2 = linspace(400000, 900000, 100)./15263;
yhat2 = polyval(b, 1./xhat2);

stock3 = [45874, 64997, 85067, 78575, 86562, 98944, 97684, 93489]./15263;
popu3 = [505303, 561656, 615927, 675443, 707324, 775671, 812283, 850920]./15263;
c = polyfit(popu3, stock3, 2);
xhat3 = linspace(400000, 900000, 100)./15263;
yhat3 = polyval(c, xhat3);

figure(1)
hold on;
plot(stock, wildlife, '.k', 'MarkerSize', 20);
plot(xhat, yhat, '-r', 'LineWidth', 2);
title('Interation Between Stock and Wildlife');
xlabel('Stock Density');
ylabel('Wildlife Density');
set(gcf, 'Color', [1, 1, 1]);

figure(2)
hold on;
plot(popu, wild, '.k', 'MarkerSize', 20);
plot(xhat2, yhat2, '-r', 'LineWidth', 2);
title('Interation Between People and Wildlife');
xlabel('People Density');
ylabel('Wildlife Density');
set(gcf, 'Color', [1, 1, 1]);

figure(3)
hold on;
plot(popu3, stock3, '.k', 'MarkerSize', 20);
plot(xhat3, yhat3, '-r', 'LineWidth', 2);
title('Interation Between People and stock');
xlabel('People Density');
ylabel('Stock Density');
set(gcf, 'Color', [1, 1, 1]);