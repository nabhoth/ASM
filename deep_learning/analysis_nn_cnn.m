clc;
clear;

%% DATA PREPARATION
% Commented code below prepares feature-object dataset from CNN features
% stored in ./features. If all fields in all images are 0, they are
% skipped. Otherwise, they are copied to the dataset matrix. The matrix
% target represents the desired algorithms. I commented the code because it
% takes time; So now, I just load the two matrices (I saved them) everytime
% to save time.
dirName = './features/';
files = dir(fullfile(dirName, '*.mat'));
files = {files.name}'; 

% num_of_classes = 5;
% num_of_features = 4096;
% num_of_subreg = 10;
% dataset = [];%zeros(4096, length(files));
% cur = 0;
% for k = 1:num_of_features
%     remove = 1;
% 
%     for i = 1:length(files)
%         load([dirName files{i}]);
%         for j = 1:num_of_subreg
%            if features(k,j) ~= 0
%                remove = 0;
%                break
%            end               
%         end
%         if remove == 0
%             break
%         end
%     end
%     
%     if remove == 0
%         for i = 1:length(files)
%             load([dirName files{i}]);
%             for j = 1:num_of_subreg
%                 dataset(cur*10+j,i) = features(k,j);
%             end
%         end
%         cur = cur + 1;
%     end        
%     
% end
% ground_truth_path = '/media/top/2/VOC2012/SegmentationClass/';
% path = '/home/alexandra/Documents/Image_Understanding/data/Multi_Algo_Final_Results/';
% algos = {'ale', 'cpmc', 'sds', 'long_shelhamer', 'wdo'};
% 
% temp_target = zeros(1, length(files));
% for i = 1:length(files)
%     ids = files{i}(1:end-4);
%     gt = imread(strcat(ground_truth_path, ids, '.png'));
%     obj = unique(gt);
%     obj = obj(1:end-1); % removing white color which is object border
%     segm_arr = zeros(1,length(algos));
%     for k=1:length(obj)
%         for j=1:length(algos)
%             im = imread(strcat(path, algos{j}, '_val_cls/', ids, '.png'));
%             mask = (im==obj(k));
%             [~, segm, ~ ] = eval_symb_seg(gt, mask, obj(k));
%             segm_arr(j) = segm_arr(j) + segm;
%         end       
%     end
%     
%     maxindex = 0;
%     max = 0;
%     for l = 1:length(segm_arr)
%         if segm_arr(l) > max
%             max = segm_arr(l);
%             maxindex = l;
%         end
%     end
%     temp_target(i) = maxindex;
% 
% end
% 
% target = zeros(num_of_classes, length(files));
% for j = 1:length(temp_target)
%     target(temp_target(j),j) = 1;
% end

%% TRAIN A NN


load('target.mat');
% [coeff, score] = pca(dataset);
% net = nn(score, target);

% Z=zscore(dataset');
% [coeff, score] = pca(Z);
% net = nn(score', target);

[coeff, score] = pca(dataset');
% net = nn(score(:,1:300)', target); % taking first 300 pca features
net = nn(score', target);
%% SAVE IMAGES CLASSIFIED BY THE OBTAINED NN
resultpath = '/home/alexandra/Documents/Image_Understanding/Regions/NN_CNN_results/';
try
    mkdir(resultpath);
catch
end

for i = 1:length(files)
    imid = files{i}(1:end-4);
    %output = net(dataset(:,i));
    %output = net(score(:,i));
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