clc;
clear;

addpath('/home/alexandra/Documents/libsvm-3.20');
% p = '/home/alexandra/Documents/';
% addpath(genpath([p 'libsvm-3.20']));

% load('../data/from_whole_images_best_analysis/nobins_reduced_evalresult_full_image_5algos.mat');
load('dataset.mat');
load('temp_target.mat');

[coeff, score] = pca(dataset');
temp_target = temp_target';

cvpart = cvpartition(temp_target,'holdout',0.2);
Xtrain = score(training(cvpart),:);
Ytrain = temp_target(training(cvpart),:);
Xtest = score(test(cvpart),:);
Ytest = temp_target(test(cvpart),:);
model = svmtrain(Ytrain, Xtrain, '-s 0 -c 128 -g 0.125');
predicted = svmpredict(Ytest, Xtest, model);