% This script saves images in different folders by the most successful algorithms
clc; clear all; close all;

classnames = {'background', 'aeroplane', 'bicycle', 'bird', 'boat', 'bottle', 'bus', 'car', 'cat', 'chair', ...
    'cow', 'diningtable', 'dog', 'horse', 'motorbike', 'person', ...
    'pottedplant', 'sheep', 'sofa', 'train', 'tvmonitor'};


ground_truth_path = '/media/kamila/3c82bfeb-15c9-4f45-b9d7-861e6410ad5c/top/2/VOC2012/SegmentationClass/';
im_path = '/media/kamila/3c82bfeb-15c9-4f45-b9d7-861e6410ad5c/top/2/VOC2012/JPEGImages/';

ex_path = './Regions/';
resultpath = [ex_path, 'Sorted_Images/'];
try
	mkdir(ex_path, 'Sorted_Images/');
catch
end

i_ale = dir('./data/Multi_Algo_Final_Results/ale_val_cls/*.png');
i_cpmc = dir('./data/Multi_Algo_Final_Results/cpmc_val_cls/*.png');
i_sds = dir('./data/Multi_Algo_Final_Results/sds_val_cls/*.png');
dirs = {'./data/Multi_Algo_Final_Results/ale_val_cls/','./data/Multi_Algo_Final_Results/cpmc_val_cls/', './data/Multi_Algo_Final_Results/comp6_val_cls/'};
algos = {'ale', 'cpmc', 'comp6'};

C = intersect({i_ale(:).name}, {i_cpmc(:).name});
C = intersect(C, {i_sds(:).name});


for k = 1:length(algos) % 3 algos in total    
    try
        dir = strcat('Sorted_Images/', algos{k}, '/');
	    mkdir(ex_path, dir);
        for m = 1:length(classnames)
             mkdir(ex_path, strcat(dir, classnames{m}, '/'));
        end
    catch
    end           
end

for i = 1:length(C)
    try
        ids = C{i}(1:end-4);
        if ids(6) ~= '0' || ids(7) ~= '0'
            continue
        end
        gt = imread(strcat('/media/kamila/3c82bfeb-15c9-4f45-b9d7-861e6410ad5c/top/2/VOC2012/SegmentationClass/', ids, '.png'));
        obj = unique(gt);
        obj = obj(1:end-1); % removing white color which is object border
        for k=1:length(obj)
            segm_arr = zeros(1,3);
            for j=1:length(dirs)
                im = imread(strcat(dirs{j}, ids, '.png'));
                mask = (im==obj(k));
                [det, segm, rawsegm ] = eval_symb_seg(gt, mask, obj(k));
                segm_arr(j) = segm;
            end
            
            maxindex = 0;
            max = 0;
            for l = 1:length(dirs)
                if segm_arr(l) > max
                    max = segm_arr(l);
                    maxindex = l;
                end
            end
            if maxindex ~= 0
                sprintf(strcat('writing... ', ids))
                im = imread(strcat(im_path,ids, '.jpg'));
                imwrite(im, [resultpath  algos{maxindex} '/' classnames{obj(k)+1} '/' ids '.jpg'], 'JPG');
            end
        end

    catch exception
        getReport(exception)
        continue
    end
end
