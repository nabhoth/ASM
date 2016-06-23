function [flabels, att_data_mean, model, max_vals, U, B, min_vals] = boosting(outvar)
%% Data preparation

p = '/home/kamila/Documents/';
addpath(genpath([p 'libsvm-3.20']));
addpath(genpath([p 'segbench/lib/matlab']));
addpath(genpath([p 'vlfeat-0.9.17/toolbox']));
addpath(genpath ([p 'VOCdevkit/VOCcode']));
rmpath([p 'vlfeat-0.9.17/toolbox/noprefix']); 


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

[suitability, im_accumulators, rows,  ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov,results, full_results, ful_results,norm_results,norm_results_s, max_vals, min_vals] = analyze_data_for_bn_pca(bins,removal,threshold,minmax,reduce_att, outvar);

%results = ful_results;
%results_cont = norm_results_s;
results = results;
results_cont = results;

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

data = [f_data att_data sel_data];

for l = 1:size(att_data, 2)
    t{1, l} = mean(cell2mat(att_data(:, l)));
end
att_data_mean = t;


%% Remove the lowest algorithm

%[temp777 temp222] = hist(cell2mat(data(:, end)), unique(cell2mat(data(:, end))));
%[~, index] = sort(temp777);
%temp222 = temp222(index);
%ind = find(~(cell2mat(data(:, end))==temp222(1)));
%data = data(ind, :);

%%%%%%%%%
sel_data_inc = cell2mat(data(:, end))-2;

B=cell2mat(data(:, 1:end-1));
R=cov(B);
[U,D]=eig(R);
B=B*U;

%% Boosting
cvpart = cvpartition(sel_data_inc,'holdout',0.2);
Xtrain = B(training(cvpart),(end-fnum):(end));
Ytrain = sel_data_inc(training(cvpart),:);
Xtest = B(test(cvpart),(end-fnum):(end));
Ytest = sel_data_inc(test(cvpart),:);
model = fitensemble(Xtrain, Ytrain,'AdaBoostM2',100,'Tree');
predicted = predict(model, Xtest);
error = sum(Ytest~= predicted)/size(Ytest,1);

sprintf('Error: %d', error)
end