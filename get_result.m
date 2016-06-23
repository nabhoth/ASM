function [ im, map ] = get_result( algo, imid )
% returns image corresponding to the processing of the selected algorithm

result_path = '/home/alexandra/Documents/Image_Understanding/data/Multi_Algo_Final_Results/';

algorithm_path_extensions = {'ale_val_cls/', 'sds_val_cls/', 'cpmc_val_cls/', 'long_shelhamer_val_cls/', 'wdo_val_cls/'};

[im, map] = imread([result_path algorithm_path_extensions{algo+2} imid '.png']);

sprintf('CHOSEN ALGO IS:')
sprintf(algorithm_path_extensions{algo+2})

end

