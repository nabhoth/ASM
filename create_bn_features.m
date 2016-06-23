function [bnet,engine,best_result,flabels] = create_bn_features(fnum,iter)
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

bins = 0;
removal = 'false';
threshold = 70;
minmax = 1;
reduce = 4;
VOCinit;

[suitability, im_accumulators, rules, rows, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov,results, full_results, ful_results,norm_results, norm_results_s] = analyze_data_for_bn(bins, removal, threshold, minmax,reduce);
results = ful_results;

if iter == 0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The features used from min_rules
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%fnum = min_rules
	%first flaten it
%    tmp = regexp(fnum,'([^ ,:]*)','tokens');
%    fnum = cat(2,tmp{:});

	flabels = strsplit(',',strjoin(fnum(:)',','));
	fnum = numel(flabels);
 

best_result = cell(1,fnum+1);
best_result{1,1} = 100;


[r,c] = size(results)
node_names = [flabels results(1,c-8:end)  {'featuresSuitability', 'attributesSuitability', 'suitability'}];

node_vars = genvarname(node_names);
node_sizes = zeros(1,numel(node_vars));

for i = 1:numel(flabels)
	findex = find(strcmp(results(1,:),flabels(i)));
	node_sizes(1,i) = max(cell2mat(results(2:end,findex)));
end
for i = 1:numel(results(1,c-8:end))
	node_sizes(1,i+numel(flabels)) = max(cell2mat(results(2:end,c-9+i)));
end


node_sizes(1,end-2:end) = 2;
node_sizes(1,end-1:end) = 2;
node_sizes(1,end:end) = 2;
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

%prepare data
attr_data = results(2:end,c-8:end);
f_data = [];
for a=1:numel(flabels)
	f_data = [f_data, results(2:end,find(strcmp(results(1,:),flabels(a))))];
end
sel_data = results(2:end,7);
mid_data = cell(r-1,2);
data = [f_data, attr_data, mid_data,sel_data];

[rows coloms] = size(data)
data_ones = [];
for m = 1: rows    
    if cell2mat(data(m, end))==1
       data_ones = [data_ones; data(m, :)];
    end
end

% calculate oroportion of 1 and 2 in sel_data
[temp777 temp222] = hist(cell2mat(data(:, end)), unique(cell2mat(data(:, end))));
temp777

% 
difference = temp777(2) - temp777(1)
for l = 1:difference
    coef = randi(temp777(1));
    data = [data; data_ones(coef, :)];
end

[temp777 temp222] = hist(cell2mat(data(:, end)), unique(cell2mat(data(:, end))));
temp777

[rr,cc] = size(data);


partition = cvpartition(cell2mat(data(:,cc)), 'holdout', 0.2)
train_data = data(partition.training,:)';
test_data = data(partition.test,:)';

train_data(:,1:10)
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



else

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Random selection of features
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
best_result = cell(1,fnum+1);
best_result{1,1} = 100;


for i=1:iter
flabels = [];
for a=1:fnum
r = randi(numel(results(1,:)));	
    while r<7
		r = randi(numel(results(1,:)));
    end    
flabels = [flabels, results(1,r)];
end

[r,c] = size(results)
node_names = [flabels results(1,c-8:end)  {'featuresSuitability', 'attributesSuitability', 'suitability'}];
node_vars = genvarname(node_names);
node_sizes = zeros(1,numel(node_vars));

for i = 1:numel(flabels)
	findex = find(strcmp(results(1,:),flabels(i)));
	node_sizes(1,i) = max(cell2mat(results(2:end,findex)));
end
for i = 1:numel(results(1,c-8:end))
	node_sizes(1,i+numel(flabels)) = max(cell2mat(results(2:end,c-9+i)));
end

node_sizes(1,end-2:end) = 2;
node_sizes(1,end-1:end) = 2;
node_sizes(1,end:end) = 2;

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

%prepare data
attr_data = results(2:end,c-8:end);
f_data = [];
for a=1:numel(flabels)
	f_data = [f_data, results(2:end,find(strcmp(results(1,:),flabels(a))))];
end
sel_data = results(2:end,7);
mid_data = cell(r-1,2);
data = [f_data, attr_data,mid_data,sel_data];

[rr,cc] = size(data);

partition = cvpartition(cell2mat(data(:,cc)), 'holdout', 0.2)
train_data = data(partition.training,:)';
test_data = data(partition.test,:)';

train_data(:,1:10)
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
end
