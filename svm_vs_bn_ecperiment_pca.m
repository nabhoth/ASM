%function [bnet,engine,best_result,flabels, att_data_mean, model] = svm_vs_bn_experiment_pca()
function [best_result,flabels, att_data_mean, model, max_vals, U, B] = svm_vs_bn_experiment_pca()
%addpath(genpath( 'bnt/'));

%% Data preparation
fnum = {'pca1'};
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

[suitability, im_accumulators, rows,  ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov,results, full_results, ful_results,norm_results,norm_results_s, max_vals] = analyze_data_for_bn_pca(bins, removal, threshold, minmax,reduce_att);

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

findex = find(strcmp(results_cont(1,:), 'brightness'));
ind_att = find(strcmp(results_cont(1,:), 'Area'));

f_data = results_cont(2:end, findex:(ind_att-1));
att_data = results_cont(2:end, ind_att:end);
sel_data = results(2:end,7);
mid_data = cell(r-1,2);

att_data_cl = results(2:end, ind_att:end);

data = [f_data att_data mid_data sel_data];

for l = 1:size(att_data, 2)
    t{1, l} = mean(cell2mat(att_data(:, l)));
end
att_data_mean = t;


% %% Calculate proportion of 1 and 2 in sel_data and equilize it
% 
[temp777 temp222] = hist(cell2mat(data(:, end)), unique(cell2mat(data(:, end))));

[rows coloms] = size(data);
data_ones = [];
for m = 1: rows    
    if cell2mat(data(m, end))==1
       data_ones = [data_ones; data(m, :)];      
    end
end

% calculate oroportion of 1 and 2 in sel_data
[temp777 temp222] = hist(cell2mat(sel_data), unique(cell2mat(sel_data)));


% 
difference = temp777(2) - temp777(1);
for l = 1:difference
    coef = randi(temp777(1));
    data = [data; data_ones(coef, :)];     
    att_data_cl = [att_data_cl; att_data_cl(coef, :)];
end

%%%%%%%%%

[temp777 temp222] = hist(cell2mat(data(:, end)), unique(cell2mat(data(:, end))));




sel_data_inc = data(:, end);

B=cell2mat(data(:, 1:end-1));
R=cov(B);
[U,D]=eig(R);
B=B*U;


temp1 = data(1:10, 1:10)

%% Data clustering (need to modified)
pca_data = B(:, (end-fnum):(end-1));
newdata = zeros(size(pca_data,1),size(pca_data,2));    
    %reduce data to n bins
    if reduce > 0
        for i = 1:size(pca_data,2)
                d = pca_data(:,i);
                [~,dd] = histc(d,linspace(min(d), max(d), reduce));
                newdata(:,i) = dd;
        end
        pca_data = newdata;
    end
 
%data = [mat2cell(pca_data, ones(size(pca_data, 1), 1), ones(1, size(pca_data, 2))) data(:,size(f_data,2): (size(f_data,2)+ size(att_data, 2)-1)) cell(size(data, 1),2) data(:, end)];
data = [mat2cell(pca_data, ones(size(pca_data, 1), 1), ones(1, size(pca_data, 2))) att_data_cl cell(size(data, 1),2) sel_data_inc];


%% Partition

partition = cvpartition(cell2mat(data(:,end)), 'holdout', 0.2)
train_data = data(partition.training,:)';
test_data = data(partition.test,:)';

train_data(:,1:10)

%% BN

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The features used from min_rules
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

node_names = [flabels results(1,c-8:end)  {'featuresSuitability', 'attributesSuitability', 'suitability'}];
node_vars = genvarname(node_names);
node_sizes = zeros(1,numel(node_vars));

size(node_sizes)
size(data)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:numel(flabels)
	node_sizes(1,i) = reduce;
end

% add atributes
for i = 1:numel(results(1,end-8:end))
	node_sizes(1,i+numel(flabels)) = max(cell2mat(results(2:end,end-9+i)));
end

node_sizes(1,end-2:end) = 5;
node_sizes(1,end-1:end) = 5;
node_sizes(1,end:end) = 3;
% assign unique id to each node
for i = numel(node_vars):-1:1
    eval([node_vars{i} ' = i;']);
end

%Create BN DAG
N = numel(node_vars);
dag = zeros(N,N);
%specify their connectivity for feature nodes
for i = 1:fnum
    dag(eval(node_vars{i}), eval(node_vars{numel(node_names)-1})) = 1;
end
%specify their connectivity for attribute nodes
for i = fnum+1:N-3
    dag(eval(node_vars{i}), eval(node_vars{numel(node_names)-2})) = 1;
end
%Specify connecticity for the suitability nodes
dag(eval(node_vars{end-2}), eval(node_vars{N})) = 1;
dag(eval(node_vars{end-1}), eval(node_vars{N})) = 1;



%% Create BN

[rr,cc] = size(data);
bnet = mk_bnet(dag, node_sizes, 'names',  node_names);

seed = 0;
rand('state', seed);

for i=1:numel(node_vars)
   bnet.CPD{eval(node_vars{i})} =  tabular_CPD(bnet, eval(node_vars{i}));
end

engine = jtree_inf_engine(bnet);
[bnet, lltrace] = learn_params_em(engine,train_data,100,10);

[tr,tc] = size(test_data)
err = 0;
for i=1:tc
	evidence = test_data(:,i);
	evidence{cc} = [];
	[engine, loglik] = enter_evidence(engine, evidence);
	marg = marginal_nodes(engine, eval(node_vars{N}));
	[row,col] = find(marg.T == max(marg.T(:)));

	if row ~= test_data{cc,i}
		err = err + 1;
	end
end

e = err/tc;

if e < best_result{1,1}
	best_result{1,1} = e;
	best_result(1,2:end) = flabels;	
end

sprintf('BN_error: %d', (err/tc))

% %% SVM Matlab
% cvpart = cvpartition(cell2mat(sel_data_inc),'holdout',0.2);
% Xtrain = B(training(cvpart),(end-fnum):(end));
% Ytrain = sel_data_inc(training(cvpart),:);
% Xtest = B(test(cvpart),(end-fnum):(end));
% Ytest = sel_data_inc(test(cvpart),:);
% 
% [Xtest(1:10, :) cell2mat(Ytest(1:10,:))]
% 
% model = svmtrain((Xtrain),cell2mat(Ytrain),'kernel_function', 'rbf', 'rbf_sigma', 0.003, 'showplot', 'true');
% predicted1 = svmclassify(model, (Xtrain));
% errRate1 = sum(cell2mat(Ytrain)~= predicted1)/size(cell2mat(Ytrain),1) 
% predicted = svmclassify(model, (Xtest));
% SVM_error = sum(cell2mat(Ytest)~= predicted)/size(cell2mat(Ytest),1) ;
% 
% sprintf('SVM_error: %d', SVM_error)

% %% LibSVM
% 
% cvpart = cvpartition(cell2mat(sel_data_inc),'holdout',0.2);
% Xtrain = B(training(cvpart),(end-fnum):(end-1));
% Ytrain = sel_data_inc(training(cvpart),:);
% Xtest = B(test(cvpart),(end-fnum):(end-1));
% Ytest = sel_data_inc(test(cvpart),:);
% 
% 
% model  = svmtrain(cell2mat(Ytrain), Xtrain, '-s 0 -c 0.5  -g 10 -h 0');
% predicted = svmpredict(cell2mat(Ytest), Xtest, model);


end

