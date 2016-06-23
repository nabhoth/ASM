function [ ] = iterative_analysis_understanding_svm_stat(flabels, att_data_mean, model, max_vals, U, B, min_vals)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%Initialize the VOC databse

p = '/home/kamila/Documents/';
addpath(genpath([p 'libsvm-3.20']));
addpath(genpath([p 'segbench/lib/matlab']));
addpath(genpath([p 'vlfeat-0.9.17/toolbox']));
addpath(genpath ([p 'VOCdevkit/VOCcode']));
rmpath([p 'vlfeat-0.9.17/toolbox/noprefix']); 

path_init = '/media/kamila/3c82bfeb-15c9-4f45-b9d7-861e6410ad5c/';

VOCinit;


%Result prefix path
ex_path = './Regions/';
%Path to the images to be processed
%im_path = '/home/nabhoth/codes/vision_algorithms/VOCdevkit/VOC2012/JPEGImages/';
im_path = [path_init 'top/2/VOC2012/JPEGImages/'];
%histogram ranges from training
%load('/mnt/hdb/top/2/VOC2012/Regions/JPEGImages/binranges_3.mat', 'binranges');
%load ('/mnt/hdb/top/2/VOC2012/Categories/Grouped_Attributes_Hypothesis_Regions_Mapping.mat', 'attributes');
load([path_init 'top/2/VOC2012/Regions/JPEGImages/binranges_3.mat'], 'binranges');
load([path_init 'top/2/VOC2012/Categories/Grouped_Attributes_Hypothesis_Regions_Mapping.mat'], 'attributes');

resultpath = [ex_path, 'Iterative_Analysis_Results/'];
try
	mkdir(ex_path, 'Iterative_Analysis_Results/');
catch
end
i_ale = dir('./data/Multi_Algo_Final_Results/ale_val_cls/*.png');
i_cpmc = dir('./data/Multi_Algo_Final_Results/cpmc_val_cls/*.png');

[C ia ib] = intersect([{i_ale(:).name}], [{i_cpmc(:).name}]);
iids = i_ale(ia)

hypranges = linspace(1,VOCopts.nclasses,VOCopts.nclasses);
%[bnet,engine] = create_bn_simple;
%engine = jtree_inf_engine(bnet);

 k = numel(flabels)+1;
 n = k+9+2+1;
 %evidence = cell(1,n);
 %evidence = cell(1,k);
fileID = fopen('chosen_alg.txt','w');
%for i = 1:20
    
for i = 1:numel(iids)
    try
        ids = iids(i).name(1:end-4);        
        inim = imread(strcat(im_path,ids, '.jpg'));
        [h,w] = size(inim);        
        evidence = get_features_bn_pca(inim, flabels, att_data_mean, max_vals,U, B,min_vals);
        
        [idx] = svmpredict(1, cell2mat(evidence), model);      
        [result, map] = get_result(idx, ids);      
        s_size = size(unique(result));
        fprintf(fileID,'%20s\n', ids);
        fprintf(fileID,'%5d\n', idx);
        
        if s_size(1) > 2
            [area, pos_errors, pos_hypotheses, adj_errors, adj_hypotheses, shape_errors, shape_hypotheses, rel_size_errors, rel_size_hypotheses] = contradiction_check(path, result);
            [ar,~] = size(area);
            H = zeros(ar,1);
            
            conditionEnd = 'false';
            while strcmp(conditionEnd, 'false')
                
                if ar < 2
                    break;
                end
                
                % extract the hypothesis as the maximum occurence among all hypotheses
                hypotheses = [pos_hypotheses(:,3), adj_hypotheses(:,3), rel_size_hypotheses(:,3), shape_hypotheses(:,2)];
                
                for j=1:ar
                    % histograms of hypotheses
                    hypcounts = histc(hypotheses(j,:), hypranges);
                    [H(ar,1) H(ar,1)] = max(hypcounts);
                    %check if hypothesis is different from original label
                    if H(ar,1) == area{j,1}
                        continue;
                    end
                    %extract region features
                    %build an image with only reion being not black
                    ninim =  zeros(size(inim));
                    ninim(:,:,1) = im2double(result==cell2mat(area(j,1))).*im2double(inim(:,:,1));
                    ninim(:,:,2) = im2double(result==cell2mat(area(j,1))).*im2double(inim(:,:,2));
                    ninim(:,:,3) = im2double(result==cell2mat(area(j,1))).*im2double(inim(:,:,3));
                    att_data_mean = attributes(H(ar,1)+1,2:10);
                   % evidence = get_features_bn_pca(im2uint8(ninim), flabels, att_data_mean, max_vals, U, B, min_vals);                     
                    
                    %[algo] = svmpredict(1, cell2mat(evidence), model); 
                    [algo] = iterative_analysis_understanding_stat(area{j,1});
                    fprintf(fileID,'%5d\n', algo);
                    [hyp_result, map] = get_result(algo-2, ids);                  
                    result = merge_hypothesis_image(result, area{j,1}, hyp_result);
                    
                end
                %check for contradiction and generate hypothesis
                [area, pos_errors, pos_hypotheses, adj_errors, adj_hypotheses, shape_errors, shape_hypotheses, rel_size_errors, rel_size_hypotheses] = contradiction_check( path, result );
                [arn,~] = size(area);
                 % check if new hypotheses are different from previous ones
                H2 = zeros(arn,1);
                same = 1;
                [t z] = size(pos_hypotheses);
                if t > 0
                    % extract the hypothesis as the maximum occurence among all hypotheses
                    hypotheses2 = [pos_hypotheses(:,3), adj_hypotheses(:,3), rel_size_hypotheses(:,3), shape_hypotheses(:,2)];
                    
                    size(pos_hypotheses)
                    for j=1:arn
                        if hypotheses2(j,:) ~= hypotheses(j,:)
                            same = 0;
                            break;
                        end
                    end
                    
                end
                
                sprintf('writing...')
                
                imwrite(result, map, [resultpath ids '.png'], 'PNG');
                if same == 1
                    break
                end
                ar = arn;
            end
        else         
           obj_id = get_objid_for_single_object (path, result);
           algo = iterative_analysis_understanding_stat(obj_id);
           fprintf(fileID,'%5d\n', algo);
           [result, map] = get_result(algo-2, ids);
           sprintf('writing...')
           imwrite(result, map, [resultpath ids '.png'], 'PNG'); 
        end

    catch exception
        getReport(exception)
        continue
    end
end

end

