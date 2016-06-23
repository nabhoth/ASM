clc; clear all; close all;

outvar = 'nobins_reduced_evalresult_full_image';
[flabels, att_data_mean1, model1, max_vals1, U1, B1, min_vals1] = svm_vs_bn_experiment_pca(outvar);
%[~, att_data_mean1, model1, max_vals1, U1, B1, min_vals1] = boosting(outvar);
 

iterative_analysis_understanding_svm_stat(flabels, att_data_mean1, model1, max_vals1, U1, B1, min_vals1);


VOCinit;
id = '/home/kamila/Documents/Image_Understanding/Regions/Iterative_Analysis_Results/';
[accuracies,avacc,conf,rawcounts] = VOCevalseg(VOCopts,id);

id = '/home/kamila/Documents/Image_Understanding/data/Multi_Algo_Final_Results/ale_val_cls/';
[accuracies,avacc,conf,rawcounts] = VOCevalseg(VOCopts,id);

id = '/home/kamila/Documents/Image_Understanding/data/Multi_Algo_Final_Results/comp6_val_cls/';
[accuracies,avacc,conf,rawcounts] = VOCevalseg(VOCopts,id);

id = '/home/kamila/Documents/Image_Understanding/data/Multi_Algo_Final_Results/cpmc_val_cls/';
[accuracies,avacc,conf,rawcounts] = VOCevalseg(VOCopts,id);
