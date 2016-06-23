% clc;
% clear;
% 
% p = '/home/kamila/Documents/';
% addpath(genpath([p 'libsvm-3.20']));
% 
% %% DATA PREPARATION
% % I have already set up data matrices and do not need to compute them again.
% % So now, I just load the matrices (I saved them into the current folder)
% % to save time.
% 
% load('../data/from_whole_images_best_analysis/nobins_reduced_evalresult_full_image_5algos.mat', 'results');
% load('dataset.mat');
% load('temp_target.mat');
% 
% 
% dirName = './features/';
% files = dir(fullfile(dirName, '*.mat'));
% files = {files.name}'; 
% 
% algos = {'ale', 'cpmc', 'sds', 'long_shelhamer', 'wdo'};
% 
% for i = 1:length(files)
%     files{i} = files{i}(1:end-4);   
% end
% 
% all_names = [];
% for i = 2:size(results,1)
%     all_names{i-1} = [results{i,1} '_' results{i,2}];
% end
% 
% first_feature = 'brightness 2';
% [~,ind] = find(strcmp(results(1,:), first_feature));
% 
% C = intersect(all_names, files);
% totalsize = size(dataset,1)+size(results,2)-ind+1;
% all_dataset = zeros(totalsize, 1441);
%  
% %% Old features normalization
% [size1, size2] = size(results);
% norm_results = zeros(size1-1,size2-ind+1);
% 
% for i = ind:size2
%     norm_results(:,i-ind+1) = normc(cell2mat(results(2:end, i)));
% end
% 
% 
% %% Joining tables of old features and CNN features
% for i = 1:length(C)
%     for j = 1:length(files)
%         if C{i} == files{j}
%             for k = 1:length(all_names)
%                 if C{i} == all_names{k}
%                     all_dataset(1:size(dataset,1),i) = dataset(:,j);
%                     all_dataset(size(dataset,1)+1:totalsize,i) = norm_results(k,:);
%                     break
%                 end
%             end
%             break
%         end
%     end
% end
% 
% [coeff, score] = pca(all_dataset);
%% Loading data (instead if running all of the code above)
load('all_cnn_oldfeat.mat');
load('temp_target.mat');

%% TRAIN A SVM
[coeff, score] = pca(all_dataset');
temp_target = temp_target';
cvpart = cvpartition(temp_target,'holdout',0.2);
Xtrain = score(training(cvpart),:);
Ytrain = temp_target(training(cvpart),:);
Xtest = score(test(cvpart),:);
Ytest = temp_target(test(cvpart),:);
model = svmtrain(Ytrain, Xtrain, '-s 0 -c 128 -g 0.125');
predicted = svmpredict(Ytest, Xtest, model);

