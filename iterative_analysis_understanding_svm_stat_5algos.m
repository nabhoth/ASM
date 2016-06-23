function [ ] = iterative_analysis_understanding_svm_stat_5algos(flabels, att_data_mean, model, max_vals, U, B, min_vals)
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
im_path = [path_init 'top/2/VOC2012/JPEGImages/'];
%histogram ranges from training
load([path_init 'top/2/VOC2012/Regions/JPEGImages/binranges_3.mat'], 'binranges');
load([path_init 'top/2/VOC2012/Categories/Grouped_Attributes_Hypothesis_Regions_Mapping.mat'], 'attributes');

resultpath = [ex_path, 'Iterative_Analysis_Results/'];
try
	mkdir(ex_path, 'Iterative_Analysis_Results/');
catch
end

algos = {'ale', 'cpmc', 'sds', 'long_shelhamer', 'wdo'};
C = dir([im_path, '*.jpg']);
C = {C.name};
for m = 1:length(C)
    C{m} = C{m}(1:end-4);
end
for i = 1:length(algos)
    cur = dir(['./data/Multi_Algo_Final_Results/' algos{i} '_val_cls/*.png']);
    cur = {cur.name};
    for m = 1:length(cur)
        cur{m} = cur{m}(1:end-4);
    end
    C = intersect(C, cur);
end


hypranges = linspace(1,VOCopts.nclasses,VOCopts.nclasses);

fileID = fopen('chosen_alg.txt','w');
    
for i = 1:length(C)
    try
        ids = C{i};        
        inim = imread(strcat(im_path,ids, '.jpg'));
        evidence = get_features_bn_pca(inim, flabels, att_data_mean, max_vals,U, B,min_vals);
        
        [idx] = svmpredict(1, cell2mat(evidence), model);      
        [result, map] = get_result(idx, ids);      
        s_size = size(unique(result));
        fprintf(fileID,'%20s\n', ids);
        fprintf(fileID,'%5d\n', idx);
        
        if s_size(1) > 2
            [area, ~, pos_hypotheses, ~, adj_hypotheses, ~, shape_hypotheses, ~, rel_size_hypotheses] = contradiction_check(path, result);
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
                    [H(ar,1), H(ar,1)] = max(hypcounts);
                    %check if hypothesis is different from original label
                    if H(ar,1) == area{j,1}
                        continue;
                    end
                    %extract region features
                    %build an image with only region being not black
                    ninim =  zeros(size(inim));
                    ninim(:,:,1) = im2double(result==cell2mat(area(j,1))).*im2double(inim(:,:,1));
                    ninim(:,:,2) = im2double(result==cell2mat(area(j,1))).*im2double(inim(:,:,2));
                    ninim(:,:,3) = im2double(result==cell2mat(area(j,1))).*im2double(inim(:,:,3));
                    att_data_mean = attributes(H(ar,1)+1,2:10);
                    %evidence = get_features_bn_pca(im2uint8(ninim), flabels, att_data_mean, max_vals, U, B, min_vals);                     
                    
                    %[algo] = svmpredict(1, cell2mat(evidence), model); 
                    [algo] = iterative_analysis_understanding_stat_5algos(area{j,1});
                    fprintf(fileID,'%5d\n', algo);
                    [hyp_result, map] = get_result(algo-2, ids);                  
                    result = merge_hypothesis_image(result, area{j,1}, hyp_result);
                    
                end
                %check for contradiction and generate hypothesis
                [area, ~, pos_hypotheses, ~, adj_hypotheses, ~, shape_hypotheses, ~, rel_size_hypotheses] = contradiction_check( path, result );
                
                %%%%%%%%%%%%%%%%%size(hypo1 or 2)
                [arn,~] = size(hypotheses);
                %[arn,~] = size(area);
                % check if new hypotheses are different from previous ones
                same = 1;
                [t, ~] = size(pos_hypotheses);
                if t > 0
                    % extract the hypothesis as the maximum occurence among all hypotheses                    
                    %%%%%%%%%%%%%%%%%%if any is empty, do not consider
                    if size(pos_hypotheses,2) < 3 || size(adj_hypotheses,2) < 3 || size(rel_size_hypotheses,2) < 3 || size(shape_hypotheses,2) < 2
                        hypotheses2 = [pos_hypotheses(:,3), adj_hypotheses(:,3), rel_size_hypotheses(:,3), shape_hypotheses(:,2)];
                        for j=1:arn
                            if hypotheses2(j,:) ~= hypotheses(j,:)
                                same = 0;
                                break;
                            end
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
           algo = iterative_analysis_understanding_stat_5algos(obj_id);
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

