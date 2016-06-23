VOCinit;

% Change the path accordingly
id = '/home/alexandra/Documents/Image_Understanding/Regions/NN_hypo_CNN_results2/';
[accuracies,avacc,conf,rawcounts] = VOCevalseg(VOCopts,id);

id = '/home/alexandra/Documents/Image_Understanding/data/Multi_Algo_Final_Results/ale_val_cls/';
[accuracies,avacc,conf,rawcounts] = VOCevalseg(VOCopts,id);

id = '/home/alexandra/Documents/Image_Understanding/data/Multi_Algo_Final_Results/sds_val_cls/';
[accuracies,avacc,conf,rawcounts] = VOCevalseg(VOCopts,id);

id = '/home/alexandra/Documents/Image_Understanding/data/Multi_Algo_Final_Results/cpmc_val_cls/';
[accuracies,avacc,conf,rawcounts] = VOCevalseg(VOCopts,id);

id = '/home/alexandra/Documents/Image_Understanding/data/Multi_Algo_Final_Results/long_shelhamer_val_cls/';
[accuracies,avacc,conf,rawcounts] = VOCevalseg(VOCopts,id);

id = '/home/alexandra/Documents/Image_Understanding/data/Multi_Algo_Final_Results/wdo_val_cls/';
[accuracies,avacc,conf,rawcounts] = VOCevalseg(VOCopts,id);