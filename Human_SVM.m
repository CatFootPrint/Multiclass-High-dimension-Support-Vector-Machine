clear;
clc;
begin_position=1;
number_of_data=6500;
%��.txtת��.xls����file->import data���������save
% load wine.mat
% data=data;
% 
% disp(['Number of nodes=',num2str(number_of_nodes)]);
disp(['Number of data=',num2str(number_of_data)]);
load('.\Human\test_data.mat');
load('.\Human\test_label.mat');
load('.\Human\train_data.mat');
load('.\Human\train_label.mat');
% train_data=train_data(1:number_of_data,:);
tic;
Mdl = fitcecoc(train_data(begin_position:number_of_data+begin_position-1,:),train_label(begin_position:begin_position+number_of_data-1,:));
train_time=toc;
isLoss = resubLoss(Mdl);
% CMdl=Mdl.Trained{1};
labels = predict(Mdl,test_data);
accuracy_test=sum(sum(test_label==labels))/numel(labels);
disp(['Training time is ',num2str(train_time)]);
disp(['Testing accuracy is ',num2str(accuracy_test)]);
% data=[train_label,train_data];
% data_label = data(:,1);
% �����������ݵĿ��ӻ�ͼ
% figure
% subplot(3,5,1);
% hold on
% for run = 1:178
%     plot(run,data_label(run));
% end
% title('class','FontSize',10);
% 
% for run = 2:14
%     subplot(3,5,run);
%     hold on;
%     str = ['attrib ',num2str(run-1)];
%     for i = 1:178
%         plot(i,data(i,run-1));
%     end
%     title(str,'FontSize',10);
% end

%�������ݣ���Ϊѵ�����Ͳ��Լ�
% train_data = [data(1:30,:);data(60:95,:);data(131:153,:)];
% train_label = [data_label(1:30);data_label(60:95);data_label(131:153)];
% test_data = [data(31:59,:);data(96:130,:);data(154:178,:)];
% test_label = [data_label(31:59);data_label(96:130);data_label(154:178)];

% %���ݹ�һ��
% [mtrain,ntrain] = size(train_wine);
% [mtest,ntest] = size(test_wine);
% dataset = [train_wine,test_wine];
% [dataset_scale,ps] = mapminmax(dataset',0,1);
% dataset_scale = dataset_scale';
% train_wine = dataset_scale(1:mtrain,:);
% test_wine = dataset_scale((mtrain+1):(mtrain+mtest),:);

% % ����Ԥ����,��ѵ�����Ͳ��Լ���һ����[0,1]����
% 
% % mapminmaxΪmatlab�Դ���ӳ�亯��
% [train_data,pstrain] = mapminmax(train_data');
% % ��ӳ�亯���ķ�Χ�����ֱ���Ϊ0��1
% pstrain.ymin = 0;
% pstrain.ymax = 1;
% % ��ѵ��������[0,1]��һ��
% [train_data,pstrain] = mapminmax(train_data,pstrain);
% 
% % mapminmaxΪmatlab�Դ���ӳ�亯��
% [test_data,pstest] = mapminmax(test_data');
% % ��ӳ�亯���ķ�Χ�����ֱ���Ϊ0��1
% pstest.ymin = 0;
% pstest.ymax = 1;
% % �Բ��Լ�����[0,1]��һ��
% [test_data,pstest] = mapminmax(test_data,pstest);
% 
% % ��ѵ�����Ͳ��Լ�����ת��,�Է���libsvm����������ݸ�ʽҪ��
% train_data = train_data';
% test_data = test_data';
% 
% %SVMѵ����Ԥ��
% model = svmtrain(train_label, train_data, '-c 2 -g 0.02');
% [predict_label, accuracy] = svmpredict(test_label, test_data, model);