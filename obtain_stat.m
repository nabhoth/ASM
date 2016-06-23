function [stat, stat_final] = obtain_stat()
    % Get statistics for the five algos
    clc; clear all; close all;

    classnames = {'background', 'aeroplane', 'bicycle', 'bird', 'boat', 'bottle', 'bus', 'car', 'cat', 'chair', ...
        'cow', 'diningtable', 'dog', 'horse', 'motorbike', 'person', ...
        'pottedplant', 'sheep', 'sofa', 'train', 'tvmonitor'};

    ground_truth_path = '/media/kamila/3c82bfeb-15c9-4f45-b9d7-861e6410ad5c/top/2/VOC2012/SegmentationClass/';

    path = './data/Multi_Algo_Final_Results/';
    algos = {'ale', 'cpmc', 'sds', 'long_shelhamer', 'wdo'};


    stat = {};
    for i = 1:length(classnames)
        stat{i} = zeros(1,length(algos));
    end


    C = dir(['./data/Multi_Algo_Final_Results/' algos{1} '_val_cls/*.png']);
    C = {C.name};
    for i = 2:length(algos)
        cur = dir(['./data/Multi_Algo_Final_Results/' algos{i} '_val_cls/*.png']);
        C = intersect(C, {cur.name});
    end


    for i = 1:length(C)

        ids = C{i}(1:end-4);
        if ids(6) ~= '0' || ids(7) ~= '0'
            continue
        end
        gt = imread(strcat(ground_truth_path, ids, '.png'));
        obj = unique(gt);
        obj = obj(1:end-1); % removing white color which is object border
        for k=1:length(obj)
            segm_arr = zeros(1,length(algos));
            for j=1:length(algos)
                im = imread(strcat(path, algos{j}, '_val_cls/', ids, '.png'));
                mask = (im==obj(k));
                [~, segm, ~ ] = eval_symb_seg(gt, mask, obj(k));
                segm_arr(j) = segm;
            end

            maxindex = get_max_ind(segm_arr);
            if maxindex ~= 0
                stat{obj(k)+1}(maxindex) = stat{obj(k)+1}(maxindex) + 1;
            end
        end

    end

    stat_final = zeros(1, length(classnames));
    for i = 1:length(classnames)
        stat_final(i) = get_max_ind(stat{i}+1);
    end
end

function maxindex = get_max_ind(array)
    maxindex = 0;
    max = 0;
    for l = 1:length(array)
        if array(l) > max
            max = array(l);
            maxindex = l;
        end
    end
end

