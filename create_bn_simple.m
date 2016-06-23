function [bnet, test_data] = create_bn_simple(  )
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
clear all;
addpath(genpath( 'bnt/'));

%bn_table = cell(21,12);
bn_table_path = '/home/nabhoth/install/image_transforms/BN-Selection/';
processing_results_path = '/home/nabhoth/install/image_transforms/VOCdevkit/BN_Training_Images/';
% fileID = fopen([bn_table_path 'BN-Table.csv']);
% bn_table = textscan(fileID,'%s %s %s %s %s %s %s %s %s %s %s %s','delimiter',',');
% fclose(fileID);
attributes = importdata([bn_table_path 'BN-Table.csv'], ',');
attributesNames = strsplit(' ,', attributes{1});
load([processing_results_path 'results.mat'], 'mapping');
load([bn_table_path 'evalresult1.mat'], 'results');

%%just for fun keep it close
% classnames = {'aeroplane', 'bicycle', 'bird', 'boat', 'bottle', 'bus', 'car', 'cat', 'chair', ...
%     'cow', 'diningtable', 'dog', 'horse', 'motorbike', 'person', ...
%     'pottedplant', 'sheep', 'sofa', 'train', 'tvmonitor'};

%mapping = cell(length(gtids)*5,62);
% names ={'suitability', 'contextSuitability', 'featuresSuitability', 'attributesSuitability', ...
%     'scaleType','scaleFactor','brightness','edges','color','greyRegions','bwRegions'};%, ...

node_names = [attributesNames(1,2:end) mapping(1,6:end) {'attributesSuitability', 'featuresSuitability', 'suitability'}];
%node_names = [attributesNames(1,2:end) mapping(1,6:end) {'attributesSuitability', 'featuresSuitability', 'contextSuitability', 'suitability'}];

test_data = cell(39, length(node_names));
[x,y] = size(attributes);
for j=1:x
    attrs(j,:) = strsplit(' ,',attributes{j});
end
attrs{17,1} = 'pottedplant';

replacements = {{},{'smooth','textured';1,2},{'sharp','fuzzy','interrupted';1,2,3},{'straight','curved','complex','mixed';1,2,3,4},...
    {'light','dark','any';1,2,3},{'uniform','mixed';1,2},{'no','yes';1,2},{'no','yes';1,2},{'low','average','high';1,2,3},...
    {'average','full';1,2}, {'low','average','high';1,2,3}, {'rare','low','often';1,2,3}};
node_sizes = [2 5 5 5 5 5 5 5 5 6 11 11 11 11 11 11 11 2 2 2];
%node_sizes = [2 5 5 5 5 5 5 5 5 6 10 10 10 10 10 10 10 3 3 3 2];


[p,k] = size(attrs);
for i=2:k
    repl = replacements(1,i);
    repl = repl{1};
    for j=2:p
        [~,v] = find(ismember(repl(1,:),attrs{j,i}));
        attrs{j,i} = repl{2,v};
    end
end

[r,c] = size(results);
for i=2:r
    results{i,6} = results{i,6}+1;
    results{i,8} = results{i,8}+1;
    results{i,9} = results{i,9}+1;
    results{i,10} = results{i,10}+1;
    results{i,11} = results{i,11}+1;
    results{i,12} = results{i,12}+1;
    results{i,13} = results{i,13}+1;   
end
 
for i=2:4
   [n,m] = find(ismember(attrs(:,1),results{i,7}));
  
   test_data(i-1,1:11) = attrs(n,2:12);
   test_data(i-1,12:17) = results(i,8:13);
   test_data{i-1,18} = [];
   test_data{i-1,19} = randi(2);
   test_data{i-1,20} = results{i,6};
end

suitability = 20;
%contextSuitability = 20;
featuresSuitability = 19;
attributesSuitability = 18;

brightness = 12;
fft = 13;
edges = 14;
color = 15;
greyRegions = 16;
bwRegions = 17;

Surface = 1;
Borders = 2;
LineType = 3;
ColorRange = 4;
ColorType = 5;
Deformable = 6;
Articulated = 7;
ComponentsVariety = 8;
Connectedness = 9;
NumberOfComponents = 10;
Occlusions = 11;

% all_names = {'Surface','Borders','LineType','ColorRange','ColorType','Deformable','Articulated', ...
%     'ComponentsVariety','Connectedness','NumberOfComponents','Occlusions',...
%     'brightness','fft','edges','color','grey regions','bw regions',...
%     'attributesSuitability', 'featuresSuitability', 'contextSuitability', 'suitability'};

N = 20;
dag = zeros(N,N);

dag(Surface, attributesSuitability) = 1;
dag(Borders, attributesSuitability) = 1;
dag(LineType, attributesSuitability) = 1;
dag(ColorRange, attributesSuitability) = 1;
dag(ColorType, attributesSuitability) = 1;
dag(Deformable, attributesSuitability) = 1;
dag(Articulated, attributesSuitability) = 1;
dag(ComponentsVariety, attributesSuitability) = 1;
dag(Connectedness, attributesSuitability) = 1;
dag(NumberOfComponents, attributesSuitability) = 1;
dag(Occlusions, attributesSuitability) = 1;

dag(brightness, featuresSuitability) = 1;
dag(fft, featuresSuitability) = 1;
dag(edges, featuresSuitability) = 1;
dag(color, featuresSuitability) = 1;
dag(greyRegions, featuresSuitability) = 1;
dag(bwRegions, featuresSuitability) = 1;

%dag(contextSuitability, suitability) = 1;
dag(featuresSuitability, suitability) = 1;
dag(attributesSuitability, suitability) = 1;
bnet = mk_bnet(dag, node_sizes, 'names',  node_names);

seed = 0;
rand('state', seed);
bnet.CPD{Surface} = tabular_CPD(bnet, Surface);
bnet.CPD{Borders} = tabular_CPD(bnet, Borders);
bnet.CPD{LineType} = tabular_CPD(bnet, LineType);
bnet.CPD{ColorRange} = tabular_CPD(bnet, ColorRange);
bnet.CPD{ColorType} = tabular_CPD(bnet, ColorType);
bnet.CPD{Deformable} = tabular_CPD(bnet, Deformable);
bnet.CPD{Articulated} = tabular_CPD(bnet, Articulated);
bnet.CPD{ComponentsVariety} = tabular_CPD(bnet, ComponentsVariety);
bnet.CPD{Connectedness} = tabular_CPD(bnet, Connectedness);
bnet.CPD{NumberOfComponents} = tabular_CPD(bnet, NumberOfComponents);
bnet.CPD{Occlusions} = tabular_CPD(bnet, Occlusions);

bnet.CPD{brightness} = tabular_CPD(bnet, brightness);
bnet.CPD{fft} = tabular_CPD(bnet, fft);
bnet.CPD{edges} = tabular_CPD(bnet, edges);
bnet.CPD{color} = tabular_CPD(bnet, color);
bnet.CPD{greyRegions} = tabular_CPD(bnet, greyRegions);
bnet.CPD{bwRegions} = tabular_CPD(bnet, bwRegions);

%bnet.CPD{contextSuitability} = tabular_CPD(bnet, contextSuitability);
bnet.CPD{featuresSuitability} = tabular_CPD(bnet, featuresSuitability);
bnet.CPD{attributesSuitability} = tabular_CPD(bnet, attributesSuitability);
bnet.CPD{suitability} = tabular_CPD(bnet, suitability);

test_data(1:3,:)

%bnet3 = learn_params(bnet, test_data);
%size(test_data)
%sample_bnet(bnet)

 engine = jtree_inf_engine(bnet);
 [bnet, lltrace] = learn_params_em(engine,test_data,100);%,10);

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
