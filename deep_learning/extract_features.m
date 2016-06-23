% this script extracts whole images' CNN features and saves them in the
% folder 'features' with the appropriate image ids.

clc;
clear;

dirName = './images_voc2012/';
files = dir(fullfile(dirName, '*.jpg'));
files = {files.name}'; 
filenamescell = {};
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

save('filenames', 'files');

for i = 1:length(files)
    im = imread([dirName files{i} '.jpg']);
    get_cnn_features(im, files{i}, 1, 'features/');
end

