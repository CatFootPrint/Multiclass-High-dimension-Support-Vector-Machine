clear;
clc;

%��.txtת��.xls����file->import data���������save
load wine.mat
wine_labels = wine(:,1);

% �����������ݵĿ��ӻ�ͼ
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

%�������ݣ���Ϊѵ�����Ͳ��Լ�
train_wine = [wine(1:30,:);wine(60:95,:);wine(131:153,:)];
train_wine_labels = [wine_labels(1:30);wine_labels(60:95);wine_labels(131:153)];
test_wine = [wine(31:59,:);wine(96:130,:);wine(154:178,:)];
test_wine_labels = [wine_labels(31:59);wine_labels(96:130);wine_labels(154:178)];

% %���ݹ�һ��
% [mtrain,ntrain] = size(train_wine);
% [mtest,ntest] = size(test_wine);
% dataset = [train_wine,test_wine];
% [dataset_scale,ps] = mapminmax(dataset',0,1);
% dataset_scale = dataset_scale';
% train_wine = dataset_scale(1:mtrain,:);
% test_wine = dataset_scale((mtrain+1):(mtrain+mtest),:);

% ����Ԥ����,��ѵ�����Ͳ��Լ���һ����[0,1]����

% mapminmaxΪmatlab�Դ���ӳ�亯��
[train_wine,pstrain] = mapminmax(train_wine');
% ��ӳ�亯���ķ�Χ�����ֱ���Ϊ0��1
pstrain.ymin = 0;
pstrain.ymax = 1;
% ��ѵ��������[0,1]��һ��
[train_wine,pstrain] = mapminmax(train_wine,pstrain);

% mapminmaxΪmatlab�Դ���ӳ�亯��
[test_wine,pstest] = mapminmax(test_wine');
% ��ӳ�亯���ķ�Χ�����ֱ���Ϊ0��1
pstest.ymin = 0;
pstest.ymax = 1;
% �Բ��Լ�����[0,1]��һ��
[test_wine,pstest] = mapminmax(test_wine,pstest);

% ��ѵ�����Ͳ��Լ�����ת��,�Է���libsvm����������ݸ�ʽҪ��
train_wine = train_wine';
test_wine = test_wine';

%SVMѵ����Ԥ��
model = svmtrain(train_wine_labels, train_wine, '-c 2 -g 0.02');
[predict_label, accuracy] = svmpredict(test_wine_labels, test_wine, model);
