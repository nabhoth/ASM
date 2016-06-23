function [bnet,engine] = create_bn( )
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

%bn_table = cell(21,12);
bn_table_path = '/mnt/images/2/VOC2012/Regions/JPEGImages/';
processing_results_path = '/mnt/images/2/VOC2012/Regions/';
% fileID = fopen([bn_table_path 'BN-Table.csv']);
% bn_table = textscan(fileID,'%s %s %s %s %s %s %s %s %s %s %s %s','delimiter',',');
% fclose(fileID);
%attributes = importdata([bn_table_path 'BN-Table.csv'], ',');
%attributesNames = strsplit(' ,', attributes{1});
%load([processing_resulnode_vars(i)ts_path 'results.mat'], 'mapping');
load([bn_table_path 'evalresult.mat'], 'results');
%load([bn_table_path 'Features_Hypothesis_Regions_Mapping_BN_' sprintf('%d', bins) '.mat'], 'mapping');
bn_output_path='/mnt/images/2/VOC2012/BN/';
%mkdir('/mnt/images/2/VOC2012/', 'BN/');
node_names = [results(1,8:end) {'featuresSuitability', 'attributesSuitability', 'suitability'}];
node_vars = genvarname(node_names);
node_sizes = zeros(1,numel(node_vars));

for i = 1:numel(results(1,8:end))
	node_sizes(1,i) = max(cell2mat(results(2:end,7+i)));
end

node_sizes(1,end-2:end) = 2;
node_sizes(1,end-1:end) = 2;
node_sizes(1,end:end) = 2;
node_sizes
% assign unique id to each node
for i = numel(node_vars):-1:1
    eval([node_vars{i} ' = i;']);
end

%Create BN DAG
N = numel(node_vars)
dag = zeros(N,N);
%specify their connectivity for feature nodes
for i = 1:N-12
    dag(eval(node_vars{i}), eval(node_vars{numel(node_names)-1})) = 1;
end
%specify their connectivity for attribute nodes
for i = N-11:N-3
    dag(eval(node_vars{i}), eval(node_vars{numel(node_names)-2})) = 1;
end
%Specify connecticity for the suitability nodes
dag(eval(node_vars{end-2}), eval(node_vars{N})) = 1;
dag(eval(node_vars{end-1}), eval(node_vars{N})) = 1;

%prepare data
[r,c] = size(results);
data=cell(r-1,c-7+3);
[rr,cc] = size(data);
data(:,cc) = results(2:end,7);
data(:,1:end-3) = results(2:end,8:end);

partition = cvpartition(cell2mat(data(:,cc)), 'holdout', 0.2);
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

sprintf('Final error for the full evidence is: %d', (err/tc))
err = 0;
evidence = cell(tr,1);
for i=1:tc
	%evidence(1,1:end-11) = test_data(i,1:end-11);
	evidence(1:end-11,1) = test_data(1:end-11,i);
	evidence{cc} = [];
	[engine, loglik] = enter_evidence(engine, evidence);
	marg = marginal_nodes(engine, eval(node_vars{N}));
	[row,col] = find(marg.T == max(marg.T(:)));
	%[row,col] = max(marg.T(:));
	if row ~= test_data{cc,i}
		err = err + 1;
	end
end

sprintf('Final error for the features evidence is: %d', (err/tc))

%save([bn_output_path 'BN.mat'], 'bnet');
%bnetl = learn_params(bnet,test_data);

% ncases = 2;
% T = 10;
% cases = cell(1, ncases);
% for i=1:ncases
%   ev = sample_bnet(bnet);
%   cases{i} = cell(ss,T);
%   cases{i}(onodes,:) = ev(onodes, :);
% end

% obs = {'scaleType','scaleFactor','brightness','edges','color','greyRegions','bwRegions'};
% obs = [obs attributesNames];
% 
% attributesNames
% names = [names attributesNames];
% ss = length(names);
% intrac = {names{4}, names{1};   
%     names{3}, names{1};   
%     names{2}, names{1};
%     };
% 
% [intra, names] = mk_adj_mat(intrac, names, 1);
% 
% for i=1:length(obs)
%   onodes(i) = strmatch(obs{i}, names');
% end
% 
% interc = {attributesNames{1}, names{4};
%     attributesNames{2}, names{4};
%     attributesNames{3}, names{4};
%     attributesNames{4}, names{4};
%     attributesNames{5}, names{4};
%     attributesNames{6}, names{4};
%     attributesNames{7}, names{4};
%     attributesNames{8}, names{4};
%     attributesNames{9}, names{4};
%     attributesNames{10}, names{4};
%      attributesNames{11}, names{4};
%     names{11}, names{3};
%     names{10}, names{3};
%     names{9}, names{3};
%     names{8}, names{3};
%     names{7}, names{3};
%     names{6}, names{3};
%     names{5}, names{3};
%     };
% inter = mk_adj_mat(interc, names, 0);  
% 
% onodes = sort(onodes);
% dnodes = 1:ss; 
% ns = 2*ones(1,ss); % binary nodes
% bnet = mk_dbn(intra, inter, ns, 'discrete', dnodes);
% 
% for i=1:2*ss
%   bnet.CPD{i} = tabular_CPD(bnet, i);
% end
% engine = smoother_engine(jtree_2TBN_inf_engine(bnet));
% 
% ss = 2;%slice size(ss)
% ncases = 10;%number of examples
% T=10;
% max_iter=2;%iterations for EM
% cases = cell(1, ncases);
% for i=1:ncases
%   ev = sample_dbn(bnet, T);
%   cases{i} = cell(ss,T);
%   cases{i}(onodes,:) = ev(onodes, :);
% end
% cases
% %[bnet2, LLtrace] = learn_params_dbn_em(engine, cases, 'max_iter', 4);
