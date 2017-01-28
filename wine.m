clear;
clc;

%将.txt转成.xls，再file->import data，最后命令save
load wine.mat
wine_labels = wine(:,1);

% 画出测试数据的可视化图
figure
subplot(3,5,1);
hold on
for run = 1:178
    plot(run,wine_labels(run));
end
title('class','FontSize',10);

for run = 2:14
    subplot(3,5,run);
    hold on;
    str = ['attrib ',num2str(run-1)];
    for i = 1:178
        plot(i,wine(i,run-1));
    end
    title(str,'FontSize',10);
end

%载入数据，分为训练集和测试集
train_wine = [wine(1:30,:);wine(60:95,:);wine(131:153,:)];
train_wine_labels = [wine_labels(1:30);wine_labels(60:95);wine_labels(131:153)];
test_wine = [wine(31:59,:);wine(96:130,:);wine(154:178,:)];
test_wine_labels = [wine_labels(31:59);wine_labels(96:130);wine_labels(154:178)];

% %数据归一化
% [mtrain,ntrain] = size(train_wine);
% [mtest,ntest] = size(test_wine);
% dataset = [train_wine,test_wine];
% [dataset_scale,ps] = mapminmax(dataset',0,1);
% dataset_scale = dataset_scale';
% train_wine = dataset_scale(1:mtrain,:);
% test_wine = dataset_scale((mtrain+1):(mtrain+mtest),:);

% 数据预处理,将训练集和测试集归一化到[0,1]区间

% mapminmax为matlab自带的映射函数
[train_wine,pstrain] = mapminmax(train_wine');
% 将映射函数的范围参数分别置为0和1
pstrain.ymin = 0;
pstrain.ymax = 1;
% 对训练集进行[0,1]归一化
[train_wine,pstrain] = mapminmax(train_wine,pstrain);

% mapminmax为matlab自带的映射函数
[test_wine,pstest] = mapminmax(test_wine');
% 将映射函数的范围参数分别置为0和1
pstest.ymin = 0;
pstest.ymax = 1;
% 对测试集进行[0,1]归一化
[test_wine,pstest] = mapminmax(test_wine,pstest);

% 对训练集和测试集进行转置,以符合libsvm工具箱的数据格式要求
train_wine = train_wine';
test_wine = test_wine';

%SVM训练与预测
model = svmtrain(train_wine_labels, train_wine, '-c 2 -g 0.02');
[predict_label, accuracy] = svmpredict(test_wine_labels, test_wine, model);
