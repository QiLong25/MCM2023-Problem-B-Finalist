clear
clc

genmax = 100;       % max generation
sizepop = 100;      % 每个种群大小
pcross = 0.1;       % 交叉概率
pmut = 0.03;     % 变异概率
selection = 0.5;    % 选择概率

lenchrom = 3;                   % 变量数量
area = 999.75;       % total area of subregion
Nsmax = 100000;           % max number of stock

bound = [1, area*100; 1, area*100; 1, Nsmax];  % 变量取值范围

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
for i = 1 : sizepop
    if group(i, 1) + group(i, 2) > area*100                % 农业 + 畜牧业用地大于总面积
        if group(i, 1) <= group(i, 2)
            group(i, 2) = area*100 - group(i, 2);
        else
            group(i, 1) = area*100 - group(i, 1);
        end
    end
end

%%%  进化 Main Loop  %%%
turn = 0;
while turn < genmax
    turn = turn + 1;

%%%  选择 Selection  %%%
    for i = 1 : sizepop
        group(i, end) = aimfunc2(group(i, 1)/100, group(i, 2)/100, group(i, 3));         % 目标函数
    end 
    group = sortrows(group,lenchrom + 1, "descend");
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
    for i = 1 : sizepop
        if group(i, 1) + group(i, 2) > area*100                % 农业 + 畜牧业用地大于总面积
            if group(i, 1) <= group(i, 2)
                group(i, 2) = area*100 - group(i, 2);
            else
                group(i, 1) = area*100 - group(i, 1);
            end
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

    for i = 1 : sizepop
        if group(i, 1) + group(i, 2) > area*100                % 农业 + 畜牧业用地大于总面积
            if group(i, 1) <= group(i, 2)
                group(i, 2) = area*100 - group(i, 2);
            else
                group(i, 1) = area*100 - group(i, 1);
            end
        end
    end
end
x = linspace(1, genmax, genmax);
plot(x, avgfitness, '-*b', x, bestfitness, '-or');
bestchron = group(1, 1:lenchrom);
legend('average', 'best');
xlabel('turns');
ylabel('score');
set(gcf, 'Color', [1, 1, 1]);


