%function [bnet,engine,best_result,flabels, att_data_mean, model] = svm_vs_bn_experiment_pca()
function [] = svm_param_search()




p = '/home/kamila/Documents/';
addpath(genpath([p 'libsvm-3.20']));
addpath(genpath([p 'segbench/lib/matlab']));
addpath(genpath([p 'vlfeat-0.9.17/toolbox']));

rmpath([p 'vlfeat-0.9.17/toolbox/noprefix']); 



%% Data preparation
fnum = {'pca1,pca2,pca3,pca4,pca5'};
flabels = strsplit(',',strjoin(fnum(:)',','));
fnum = numel(flabels);
best_result = cell(1,fnum+1);
best_result{1,1} = 100;

bins = 0;
removal = 'false';
threshold = 70;
minmax = 1;
reduce = 3;
reduce_att = 3;
VOCinit;

[suitability, im_accumulators, rows,  ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov,results, full_results, ful_results,norm_results,norm_results_s] = analyze_data_for_bn_pca(bins, removal, threshold, minmax,reduce_att);

results = ful_results;
results_cont = norm_results_s;

%% Remove NaN from data
[r,c] = size(results_cont)
for i = 1:r*c
    if(isnan(results_cont{i}))
       results_cont{i}=0;
    end
end

%% PCA
%%%%%%%%%%%%%%%%%%%%%%%%%prepare data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%prepare data

findex = find(strcmp(results_cont(1,:), 'brightness 1'));
ind_att = find(strcmp(results_cont(1,:), 'Area'));

f_data = results_cont(2:end, findex:(ind_att-1));
att_data = results_cont(2:end, ind_att:end);
sel_data = results(2:end,7);
mid_data = cell(r-1,2);

att_data_cl = results(2:end, ind_att:end);

%data = [f_data att_data mid_data sel_data];
data = [f_data mid_data sel_data];


for l = 1:size(att_data, 2)
    t{1, l} = mean(cell2mat(att_data(:, l)));
end
att_data_mean = t;


%% Remove the lowest algorithm

[temp777 temp222] = hist(cell2mat(data(:, end)), unique(cell2mat(data(:, end))));

%[~, index] = sort(temp777);
%temp222 = temp222(index);
%ind = find(~(cell2mat(data(:, end))==temp222(1)));
%data = data(ind, :);
%%%%%%%%%

%[temp777 temp222] = hist(cell2mat(data(:, end)), unique(cell2mat(data(:, end))));
temp777

sel_data_inc = cell2mat(data(:, end))-2;

%% Calculate PCA
B=cell2mat(data(:, 1:end-1));
R=cov(B);
[U,D]=eig(R);
B=B*U;

% %% SVM Matlab
% cvpart = cvpartition(sel_data_inc,'holdout',0.2);
% Xtrain = B(training(cvpart),(end-fnum):(end));
% Ytrain = sel_data_inc(training(cvpart),:);
% Xtest = B(test(cvpart),(end-fnum):(end));
% Ytest = sel_data_inc(test(cvpart),:);
%
% [Xtest(1:10, :) Ytest(1:10,:)]
%
% model = svmtrain((Xtrain),Ytrain,'kernel_function', 'rbf', 'rbf_sigma', 0.003, 'showplot', 'true');
% predicted1 = svmclassify(model, (Xtrain));
% errRate1 = sum(Ytrain~= predicted1)/size(Ytrain,1)
% predicted = svmclassify(model, (Xtest));
% SVM_error = sum(Ytest~= predicted)/size(Ytest,1) ;
%
% sprintf('SVM_error: %d', SVM_error)

%% LibSVM

cvpart = cvpartition(sel_data_inc,'holdout',0.2);
Xtrain = B(training(cvpart),(end-fnum):(end-1));
Ytrain = sel_data_inc(training(cvpart),:);
Xtest = B(test(cvpart),(end-fnum):(end-1));
Ytest = sel_data_inc(test(cvpart),:);

smal_er = 1;
best_c = 0;
best_g = 0;

fileID = fopen('svm_param_nu.txt', 'w');
%for c = 0:0.005:1
for c = -5:2:15
    cost = num2str(2^c);
    %cost = num2str(c);
       for g = 5:-2:-15       
        gamma = num2str(2^g);
        com = ['-s 0 -c ' cost ' -g ' gamma]
        fprintf(fileID, com);     
        model  = svmtrain(Ytrain, Xtrain, com);
        predicted = svmpredict(Ytest, Xtest, model);       
        SVM_error = sum(Ytest~= predicted)/size(Ytest,1) ;
        fprintf(fileID, '\n error %d \n', SVM_error);
        if SVM_error < smal_er
            smal_er = SVM_error;
            best_c = cost;
            best_g = gamma;
        end
    end
end
smal_er
best_c
best_g
temp777
fclose(fileID);

end