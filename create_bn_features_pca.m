function [bnet,engine,best_result,flabels] = create_bn_features_pca()
%fnum = {'feature1, feature2,...featureN'}
%{'brightness,fft,Gabor edges,wavelets1,wavelets2,wavelets3,wavelets4,contrast,accutance,gist,colorR,colorG,colorB,grey regions1,grey regions2,grey regions3,grey regions4,bw regions1,bw regions2,bw regions3,bw regions4'}
%create_rules() takes the set of labels, ane extracts rules for
%contradiction detection based on statistical evidence of proximity and
%position
%   Outputs:
%       rules - a set of symbolic rules organized in a tabular format
%       pos_rules: contradiction generation rules using relative position
%       of different classes
%       adj_rules: contradiction generation rules using relative adjacency
%       of different regions
%       rel_size_rules: contradiction generation rules using relative size
%       of different classes
%       shape_rules: contradiction generation rules using shape properties
%       of class
%clear all;
addpath(genpath( 'bnt/'));

%bn_table_path = '/mnt/images/2/VOC2012/Regions/JPEGImages/';
%processing_results_path = '/mnt/images/2/VOC2012/Regions/';
%load([bn_table_path 'evalresult.mat'], 'results');
%bn_output_path='/mnt/images/2/VOC2012/BN/';

fnum = {'pca1, pca2, pca3';}

bins = 0;
removal = 'false';
threshold = 70;
minmax = 1;
reduce = 3;
VOCinit;

[suitability, im_accumulators, rows,  ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov,results, full_results, ful_results,norm_results,norm_results_s ] = analyze_data_for_bn(bins, removal, threshold, minmax,reduce);
results = ful_results;


[r,c] = size(results)
for i = 1:r*c
    if(isnan(results{i}))
       results{i}=0;
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The features used from min_rules
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

flabels = strsplit(',',strjoin(fnum(:)',','));
fnum = numel(flabels);

flabels

best_result = cell(1,fnum+1);
best_result{1,1} = 100;



node_names = [flabels results(1,c-8:end)  {'featuresSuitability', 'attributesSuitability', 'suitability'}];
node_vars = genvarname(node_names);
node_sizes = zeros(1,numel(node_vars));

%%%%%%%%%%%%%%%%%%%%%%%%%prepare data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%prepare data
[r,c] = size(results);
findex = find(strcmp(results(1,:), 'brightness'));
ind_att = find(strcmp(results(1,:), 'Area'));
%prepare data
f_data = results(2:end, findex:(ind_att-1));
att_data = results(2:end, ind_att:end);
sel_data = results(2:end,7);
mid_data = cell(r-1,2);
data = [f_data att_data mid_data sel_data];
data_no_att = [f_data  mid_data sel_data];

% calculate oroportion of 1 and 2 in sel_data
[temp777 temp222] = hist(cell2mat(data(:, end)), unique(cell2mat(data(:, end))));
temp777


sel_data_inc = data(:, end);
sel_data_inc_no_att = data_no_att(:, end);

B=cell2mat(data);
B_no_att = cell2mat(data_no_att);


B(:,end)=[];
B_no_att(:, end) = [];

R=cov(B);
[U,D]=eig(R);
B=B*U;

R_na=cov(B_no_att);
[U_na,D_na]=eig(R_na);
B_no_att=B_no_att*U_na;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for i = 1:numel(flabels)
%	node_sizes(1,i) = max(B(2:end,end-(4-i)));
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
node_sizes
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


%%% cvpartion
f_data = B(:, (end-3):(end-1));

%%%%Remove negative values
f_data = f_data.^2+1;

num_intervals = 3.0;
min_val = min(f_data(:));
max_val = max(f_data(:))

range = max_val - min_val;
interval = range/num_intervals
min_val + 3*interval

for i = 1:size(f_data, 1)
    for k = 1:size(f_data, 2)
        if f_data(i, k) >= min_val && f_data(i, k) < min_val + interval
            f_data(i, k) = 1;
        elseif f_data(i, k) >= min_val+ interval && f_data(i, k) < min_val + 2*interval
            f_data(i, k) = 2;
        elseif  f_data(i, k) >= min_val+ 2*interval && f_data(i, k) <= min_val + 3*interval
            f_data(i, k) = 3;
        end
    end
end

%     [~,p] = find(strcmp(full_results(1,:), 'brightness'));
%     newdata = zeros(size(full_results,1)-1,size(full_results,2));
%  %reduce data to n bins
%     if reduce > 0
%         for i=p:size(full_results,2)
%             d=cell2mat(full_results(2:end,i));
%             [~,dd] = histc(d,linspace(min(d), max(d), reduce));
%             newdata(:,i) = dd;
%         end
%         full_results(2:end,p:end) = num2cell(newdata(:,p:end));
%     end
 
%% Data for BN
% results = norm_results;
% [r,c] = size(results);
% findex = find(strcmp(results(1,:), 'brightness'));
% ind_att = find(strcmp(results(1,:), 'Area'));
% %prepare data
% f_data = results(2:end, findex:(ind_att-1));
% att_data = results(2:end, ind_att:end);
% sel_data = results(2:end,7);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data = [mat2cell(f_data, ones(size(f_data, 1), 1), ones(1, size(f_data, 2))) att_data mid_data sel_data];

% cvpart = cvpartition(cell2mat(sel_data_inc),'holdout',0.2);
% Xtrain = data(training(cvpart),:);
% Ytrain = sel_data_inc(training(cvpart),:);
% Xtest = B(test(cvpart),(end-3):(end-1));
% Ytest = sel_data_inc(test(cvpart),:);
% train_data = [mat2cell(Xtrain, ones(row, 1), ones(1, col)) Ytrain];
% test_data = Xtest;

%% 
partition = cvpartition(cell2mat(data(:,end)), 'holdout', 0.2)
train_data = data(partition.training,:)';
test_data = data(partition.test,:)';

train_data(:,1:10)


[rr,cc] = size(data);
%create BN
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
	%[row,col] = max(marg.T(:));
	if row ~= test_data{cc,i}
		err = err + 1;
	end
end

e = err/tc;

if e < best_result{1,1}
	best_result{1,1} = e;
	best_result(1,2:end) = flabels;	
end

sprintf('Final error for the full evidence is: %d', (err/tc))
%err = 0;
%evidence = cell(tr,1);
%for i=1:tc
%	%evidence(1,1:end-11) = test_data(i,1:end-11);
%	evidence(1:end-11,1) = test_data(1:end-11,i);
%	evidence{cc} = [];
%	[engine, loglik] = enter_evidence(engine, evidence);
%	marg = marginal_nodes(engine, eval(node_vars{N}));
%	[row,col] = find(marg.T == max(marg.T(:)));
%	%[row,col] = max(marg.T(:));
%	if row ~= test_data{cc,i}
%		err = err + 1;
%	end
%end
%
%sprintf('Final error for the features evidence is: %d', (err/tc))

end
