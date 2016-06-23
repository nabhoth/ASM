clc; clear all; close all;
% in svm_vs_bn_experiment_pca make sure that you have those 4 algos listed
% in the array
outvar = 'nobins_reduced_evalresult_full_image_4algos';
[~, att_data_mean1, model1, max_vals1, U1, B1, min_vals1] = svm_vs_bn_experiment_pca(outvar);
 
outvar = 'nobins__reduced_false_evalresult_full_piece_4algos';
[flabels, att_data_mean, model2, max_vals2, U2, B2, min_vals2] = svm_vs_bn_experiment_pca(outvar);

iterative_analysis_understanding_svm_4algos(flabels, att_data_mean1, model1, max_vals1, U1, B1, min_vals1, att_data_mean, model2, max_vals2, U2, B2, min_vals2);


VOCinit;
id = '/home/kamila/Documents/Image_Understanding/Regions/Iterative_Analysis_Results/';
[accuracies,avacc,conf,rawcounts] = VOCevalseg(VOCopts,id);

id = '/home/kamila/Documents/Image_Understanding/data/Multi_Algo_Final_Results/ale_val_cls/';
[accuracies,avacc,conf,rawcounts] = VOCevalseg(VOCopts,id);

id = '/home/kamila/Documents/Image_Understanding/data/Multi_Algo_Final_Results/sds_val_cls/';
[accuracies,avacc,conf,rawcounts] = VOCevalseg(VOCopts,id);

id = '/home/kamila/Documents/Image_Understanding/data/Multi_Algo_Final_Results/cpmc_val_cls/';
[accuracies,avacc,conf,rawcounts] = VOCevalseg(VOCopts,id);

id = '/home/kamila/Documents/Image_Understanding/data/Multi_Algo_Final_Results/long_shelhamer_val_cls/';
[accuracies,avacc,conf,rawcounts] = VOCevalseg(VOCopts,id);

