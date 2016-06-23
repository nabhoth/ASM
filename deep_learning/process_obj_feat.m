clc;
clear;

%% DATA PREPARATION

dirName = './obj_features/';
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

ground_truth_path = '/media/kamila/3c82bfeb-15c9-4f45-b9d7-861e6410ad5c/top/2/VOC2012/SegmentationClass/';
path = '/home/alexandra/Documents/Image_Understanding/data/Multi_Algo_Final_Results/';
algos = {'ale', 'cpmc', 'sds', 'long_shelhamer', 'wdo'};

addpath(genpath ('/home/alexandra/Documents/VOCdevkit/VOCcode'));
VOCinit;
[gtids, ~]=textread(sprintf(VOCopts.seg.imgsetpath,VOCopts.testset),'%s %d');

for n=1:length(gtids)
    gt = imread(strcat(ground_truth_path, ids, '.png'));
    imname = gtids{n};   
   
	recs=PASreadrecord(sprintf(VOCopts.annopath,imname));
    for j=1:numel(recs.objects)        
        if (j > 9)
            jgtids = strrep(imname, '_00', sprintf('_%d',j));
        else
            jgtids = strrep(imname, '_00', sprintf('_0%d',j));            
        end
        
        if ((recs.objects(j).bbox(4) - recs.objects(j).bbox(2) > 20) && (recs.objects(j).bbox(3)-recs.objects(j).bbox(1) > 20))
            obj_gtim = gt(recs.objects(j).bbox(2):recs.objects(j).bbox(4), recs.objects(j).bbox(1):recs.objects(j).bbox(3),:);
          
        end
    end
end







temp_target = zeros(1, length(files));
for i = 1:length(files)
    ids = files{i}(1:end-4);
    gt = imread(strcat(path, 'ale_val_cls/',ids, '.png'));
    
    
    
    for j=1:numel(recs.objects)
        if ((recs.objects(j).bbox(4) - recs.objects(j).bbox(2) > 20) && (recs.objects(j).bbox(3)-recs.objects(j).bbox(1) > 20))
            try
                obj_im = im(recs.objects(j).bbox(2):recs.objects(j).bbox(4), recs.objects(j).bbox(1):recs.objects(j).bbox(3),:);
                % imshow(obj_im)

                get_cnn_features(obj_im, jgtids, 1, 'obj_features/');
            catch exception
                getReport(exception)
                continue
            end
        end
    end
    
    
    
%     original_imid = [ids(1:5) '00' ids(8:11)];
%     
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

end
% 
% target = zeros(num_of_classes, length(files));
% for j = 1:length(temp_target)
%     target(temp_target(j),j) = 1;
% end

%% TRAIN A NN
load('dataset_obj.mat');
load('target_obj.mat');
[coeff, score] = pca(dataset);
net = nn(score, target);

%% SAVE IMAGES CLASSIFIED BY THE OBTAINED NN
resultpath = '/home/kamila/Documents/Image_Understanding/Regions/NN_CNN_results/';
try
    mkdir(resultpath);
catch
end

for i = 1:length(files)
    imid = files{i}(1:end-4);
    %output = net(dataset(:,i));
    output = net(score(:,i));
    idx = 0;
    max = 0;
    for l = 1:length(output)
        if output(l) > max
            max = output(l);
            idx = l;
        end
    end
    [im, map] = get_result(idx, imid);
    sprintf(['writing ' imid '...'])
    imwrite(im, map, [resultpath imid '.png'], 'PNG');
end