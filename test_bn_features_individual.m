function [eresults] = test_bn_features_individual(bins)
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

bn_table_path = '/mnt/images/2/VOC2012/Regions/JPEGImages/';
processing_results_path = '/mnt/images/2/VOC2012/Regions/';
load([bn_table_path 'evalresult.mat'], 'results');
bn_output_path='/mnt/images/2/VOC2012/BN/';

[rr,rc] = size(results);

eresults = cell(rc-7,3);
eresults{1,1} = 'Feature Name';
eresults{1,2} = 'Full Evaluation';
eresults{1,3} = 'Feature Evaluation';

features_num = numel(results(1,8:end));
%features_num = numel(results(1,8:end-9));

bins = zeros(1,rc);
for e=8:rc
	bins(1,e) = max(cell2mat(results(2:end,e)));
end

for q=1:features_num

eresults{q+1,1} = results{1,q+7};
node_names = [results{1,q+7} {'suitability'}]
%node_names = [results{1,q+7} results(1,end-8:end) {'featuresSuitability', 'attributesSuitability', 'suitability'}]

node_vars = genvarname(node_names);
node_sizes = zeros(1,numel(node_vars));
if bins > 0
	node_sizes(1,:) = bins;
else
	node_sizes(1,1) = bins(1,q+7);
	%node_sizes(1,2:end) = bins(1,end-11:end);
end

node_sizes(1,end:end) = 2;
%node_sizes(1,end-2:end) = 2;

node_sizes
% assign unique id to each node
for i = numel(node_vars):-1:1
    %node_vars{i} =  i
    eval([node_vars{i} ' = i;']);
end

N = numel(node_vars);
dag = zeros(N,N);

%specify their connectivity for feature nodes
%for i = 1:N-12
%    dag(eval(node_vars{i}), eval(node_vars{numel(node_names)-1})) = 1;
%end
%specify their connectivity for attribute nodes
%for i = N-11:N-3
%    dag(eval(node_vars{i}), eval(node_vars{numel(node_names)-2})) = 1;
%end
dag(eval(node_vars{1}), eval(node_vars{numel(node_names)})) = 1;
%dag(eval(node_vars{end-2}), eval(node_vars{N})) = 1;
%dag(eval(node_vars{end-1}), eval(node_vars{N})) = 1;

%[r,c] = size(results);
%test_data=cell(r-1,1+9+3);
%data = cell(r-1,1+9+3);
%[rr,cc] = size(test_data);
%data(:,1) = results(2:end,q+7);
%data(:,2:end-3) = results(2:end,end-8:end);
%data(:,cc) = results(2:end,7);


[r,c] = size(results);
test_data=cell(r-1,2);
data = cell(r-1,2);
[rr,cc] = size(test_data);
data(:,1) = results(2:end,q+7);
%data(:,2:end-3) = results(2:end,end-8:end);
data(:,cc) = results(2:end,7);

partition = cvpartition(cell2mat(data(:,cc)), 'holdout', 0.1);

train_data = data(partition.training,:);
test_data = data(partition.test,:);


bnet = mk_bnet(dag, node_sizes, 'names',  node_names);

seed = 0;
rand('state', seed);

for i=1:numel(node_vars)
   bnet.CPD{eval(node_vars{i})} =  tabular_CPD(bnet, eval(node_vars{i}));
end

%training 
engine = jtree_inf_engine(bnet);
[bnet, lltrace] = learn_params_em(engine,train_data',100,10);


%testing
[tr,tc] = size(test_data)
err = 0;
evidence = cell(1,tc);
for i=1:tr
	evidence = test_data(i,:);
	evidence{cc} = [];
%	evidence{cc-1} = [];
%	evidence{cc-2} = [];
	[engine, loglik] = enter_evidence(engine, evidence);
	marg = marginal_nodes(engine, eval(node_vars{N}));
	[row,col] = find(marg.T == max(marg.T(:)));
	if row ~= test_data{i,cc}
		err = err + 1;
	end
end

sprintf('Final error for the full evidence is: %d', (err/tr))

eresults{q+1,2} = (err/tr);
%err = 0;
%evidence = cell(1,tc);
%for i=1:tr
%	evidence(1,1:end-12) = test_data(i,1:end-12);
%	evidence{cc} = [];
%	[engine, loglik] = enter_evidence(engine, evidence);
%	marg = marginal_nodes(engine, eval(node_vars{N}));
%	[row,col] = find(marg.T == max(marg.T(:)));
%	if row ~= test_data{i,cc}
%		err = err + 1;
%	end
%end

%sprintf('Final error for the features evidence is: %d', (err/tr))

%eresults{q+1,3} = (err/tr);
eresults(q+1,:)
end
