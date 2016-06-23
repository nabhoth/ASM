% Neural network working on the old features

% clc;
% clear;

% load('../data/from_whole_images_best_analysis/nobins_reduced_evalresult_full_image_5algos.mat', 'results');
num_of_algos = 5;
first_feature = 'brightness 2';
[~,ind] = find(strcmp(results(1,:), first_feature));

for i = ind:size(results,2)
    feature_matrix(:,i-ind+1) = normc(cell2mat(results(2:end, i)));
end

ground_truth_path = '/media/top/2/VOC2012/SegmentationClass/';
path = '/home/alexandra/Documents/Image_Understanding/data/Multi_Algo_Final_Results/';
algos = {'ale', 'cpmc', 'sds', 'long_shelhamer', 'wdo'};

target = zeros(num_of_algos, size(results,1)-1);

for i = 2:size(results,1)
    ids = [results{i,1} '_' results{i,2}]
    gt = imread(strcat(ground_truth_path, ids, '.png'));
    obj = unique(gt);
    obj = obj(1:end-1); % removing white color which is object border
    segm_arr = zeros(1,length(algos));
    for k=1:length(obj)
        for j=1:length(algos)
            try
                im = imread(strcat(path, algos{j}, '_val_cls/', ids, '.png'));
                 mask = (im==obj(k));
                [~, segm, ~ ] = eval_symb_seg(gt, mask, obj(k));
            catch
                segm = 0; % if it got here, then most likely image was not found, so we'll just assign segm a value of 0
            end           
            segm_arr(j) = segm_arr(j) + segm;
        end       
    end
    
    maxindex = 0;
    max = 0;
    for l = 1:length(segm_arr)
        if segm_arr(l) > max
            max = segm_arr(l);
            maxindex = l;
        end
    end
    target(:,i-1) = 0;
    target(maxindex,i-1) = 1;

end

[coeff, score] = pca(feature_matrix);
net = nn(score(:,1:300)', target);

%% SAVE IMAGES CLASSIFIED BY THE OBTAINED NN
resultpath = '/home/alexandra/Documents/Image_Understanding/Regions/NN_oldfeat_results/';
try
    mkdir(resultpath);
catch
end

dirName = './features/';
files = dir(fullfile(dirName, '*.mat'));
files = {files.name}'; 

for i = 1:length(files)
    imid = files{i}(1:end-4);
    output = net(score(i,1:300)');
    idx = 0;
    max = 0;
    for l = 1:length(output)
        if output(l) > max
            max = output(l);
            idx = l;
        end
    end
    [im, map] = get_result(idx-2, imid);
    sprintf(['writing ' imid '...'])
    imwrite(im, map, [resultpath imid '.png'], 'PNG');
end