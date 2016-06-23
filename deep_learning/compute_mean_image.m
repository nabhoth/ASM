% clc;
% clear;

CROPPED_DIM = 227;

dirName = './images_voc2012/';
files = dir(fullfile(dirName, '*.jpg'));
files = {files.name}'; 

algos = {'ale', 'cpmc', 'sds', 'long_shelhamer', 'wdo'};
for m = 1:length(files)
    files{m} = files{m}(1:end-4);
end
for i = 1:length(algos)
    cur = dir(['../data/Multi_Algo_Final_Results/' algos{i} '_val_cls/*.png']);
    cur = {cur.name};
    for m = 1:length(cur)
        cur{m} = cur{m}(1:end-4);
    end
    files = intersect(files, cur);
end

mean_image = zeros(256, 256, 3, 'single');
for i = 1:length(files)
    im = imread([dirName files{i} '.jpg']);
    mean_image = mean_image + prepare_image(im);
end

mean_image = mean_image/length(algos);
save('voc2012_mean.mat', 'mean_image');

