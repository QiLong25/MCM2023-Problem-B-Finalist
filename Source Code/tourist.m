clear
clc

xd = 2015 : 2022;            % real data x
yd = [90000, 113213, 107254, 145238, 157591, 45328, 68349, 121471]./0.563;         % real data y

xb = 2015 : 2019;           % before Covid-19
yb = [90000, 113213, 107254, 145238, 157591]./0.563;     
f1 = polyfit(xb, yb, 1);
yhat1 = polyval(f1, xb);
deltaY1 = yhat1 - yb;
error1 = sum(deltaY1.^2);
f2 = polyfit(xb, yb, 2);
yhat2 = polyval(f2, xb);
deltaY2 = yhat2 - yb;
error2 = sum(deltaY2.^2);

xa = 2020 : 2022;           % after Covid-19
ya = [45328, 68349, 121471]./0.563;
f3 = polyfit(xa, ya, 1);
yhat3 = polyval(f3, xa);
deltaY3 = yhat3 - ya;
error3 = sum(deltaY3.^2);
f4 = polyfit(xa, ya, 2);
yhat4 = polyval(f4, xa);
deltaY4 = yhat4 - ya;
error4 = sum(deltaY4.^2);

f5 = polyfit(xd, yd, 1);        % global
yhat5 = polyval(f5, xa);
deltaY5 = yhat5 - ya;
error5 = sum(deltaY5.^2);

if error1 <= error2
    yp1 = polyval(f1, 2023);            % predicted y
    Fb = f1;
else
    yp1 = polyval(f2, 2023);
    Fb = f2;
end

if error3 <= error4
    yp2 = polyval(f3, 2023);
    Fa = f3;
else
    yp2 = polyval(f4, 2023);
    Fa = f4;
end

yavg = sum(yd) / 8;
yp3 = polyval(f5, 2023);
yp = (yavg + yp1 + yp2 + yp3) / 4;       % prediction


xall = 2014 : 2024;
xfunc1 = linspace(2014, 2024, 100);
xfunc2 = linspace(2019.5, 2024, 50);
xfunc3 = linspace(2014, 2019.5, 50);
yFb = polyval(Fb, xfunc3);
yFa = polyval(Fa, xfunc2);
yFd = polyval(f5, xfunc1);
yFB = polyval(Fb, xfunc2);
x2023 = [2023, 2023, 2023, 2023, 2023];

figure()
hold on;
plot(xfunc3, yFb, '-g', 'LineWidth', 2);
plot(xfunc2, yFB, '--g', 'LineWidth', 2);
plot(xfunc2, yFa, '-r', 'LineWidth', 2);
plot(xfunc1, yFd, '--c', 'LineWidth', 2);
plot(2023, yp1, '.k', 'MarkerSize', 25);
plot(2023, yp2, '.k', 'MarkerSize', 25);
plot(2023, yavg, '.k', 'MarkerSize', 25);
plot(2023, yp3, '.k', 'MarkerSize', 25);
plot(2023, yp, 'pb', 'MarkerFaceColor','b', 'MarkerSize', 20);
plot(x2023, [yp1, yp2, yavg, yp, yp3], '-b');
plot(xd, yd, '.b', 'MarkerSize', 25);
title('Tourist Quantity Prediction in 2023');
xlabel('Year');
ylabel('Population');
legend("regression based on data before epidemic", "regression based on data after epidemic", "regression based on all data");
set(gcf, 'Color', [1, 1, 1]);


