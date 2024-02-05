clear
clc

genmax = 70;       % max generation
sizepop = 50;      % 每个种群大小
pcross = 0.3;       % 交叉概率
pmut = 0.02;     % 变异概率
selection = 0.5;    % 选择概率

lenchrom = 2;                   % 变量数量
bound = [-100, 100; -100, 100];  % 变量取值范围

group = zeros(sizepop, lenchrom + 1);       % 最后一列为函数值
avgfitness = zeros(1, genmax);
bestfitness = zeros(1, genmax);
bestchron = zeros(lenchrom);

%%%  初始化种群 Initialization %%%
for i = 1 : sizepop
    for j = 1 : lenchrom
    group(i,j) = randi([bound(j,1),bound(j,2)]);       % 赋值函数
    end
end

%%%  进化 Main Loop  %%%
turn = 0;
while turn < genmax
    turn = turn + 1;

%%%  选择 Selection  %%%
    for i = 1 : sizepop
        group(i, end) = aimfunc1(group(i, 1), group(i, 2));         % 目标函数
    end 
    group = sortrows(group,lenchrom + 1);
    for i = 1 : sizepop/2
        if rand <= selection
           group(sizepop/2 + i, :) = group(i, :); 
        end
    end
    avgfitness(1, turn) = sum(group(:, lenchrom + 1)) / sizepop;
    bestfitness(1, turn) = group(1, lenchrom + 1);
    if turn >= genmax
        break;
    end

%%%  交叉互换 Crosscover  %%%
    for i = 1 : sizepop
        if rand <= pcross
            match = randi(sizepop);                  % 交换个体
            if match == i
                continue;
            end
            point = randi(lenchrom);                 % 交换位点
            temp = group(i, point);
            group(i, point) = group(match, point);
            group(match, point) = temp;
        end
    end

%%%  基因突变 Mutation  %%%
    for i = 1 : sizepop
        for j = 1 : lenchrom
            if rand <= pmut
                group(i,j) = randi([bound(j, 1),bound(j, 2)]);
            end
        end
    end

end
x = linspace(1, genmax, genmax);
figure(1)
hold on;
plot(x, avgfitness, '-b', 'LineWidth', 2);
plot(x, bestfitness, '-r', 'LineWidth', 2);
plot(x, avgfitness, 'ok', 'MarkerSize', 5);
plot(x, bestfitness, 'ok', 'MarkerSize', 5);
bestchron = group(1, 1:lenchrom);
legend('average', 'best');
xlabel('generation');
ylabel('value');
set(gcf, 'Color', [1, 1, 1]);

stock = [110107, 45874, 64997, 85067, 78575, 86562, 98944, 97684, 93489]./15263;
popu = [490490, 505303, 561656, 615927, 675443, 707324, 775671, 812283, 850920]./15263;
wild = [58392, 37188, 13011, 11547, 13985, 19933, 10632, 11641, 20189]./15263;

newx = 1./group(1, 1).*stock + 1./group(1,2).*popu;
a = polyfit(newx, wild, 1);
yhat = polyval(a, newx);


figure(2)
hold on;
plot(newx, yhat, '.b', 'MarkerSize', 20);
plot(newx, yhat, '-r', 'LineWidth', 2);
title('Interation Between Wildlife and Stock, People');
xlabel('Combination of Stock and People');
ylabel('Wildlife Density');
set(gcf, 'Color', [1, 1, 1]);





