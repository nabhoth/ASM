function [ ] = iterative_analysis_understanding_svm_4algos(flabels, att_data_mean1, model1, max_vals1, U1, B1, min_vals1, att_data_mean2, model2, max_vals2, U2, B2, min_vals2)
%UNTITLED Summary of this function goes here
% Detailed explanation goes here
%Initialize the VOC databse
path_init = '/media/kamila/3c82bfeb-15c9-4f45-b9d7-861e6410ad5c/';
VOCinit;
%Result prefix path
ex_path = './Regions/';
output_path = './data/from_whole_images_best_analysis/';
%Path to the images to be processed
%im_path = '/home/nabhoth/codes/vision_algorithms/VOCdevkit/VOC2012/JPEGImages/';
im_path = [path_init 'top/2/VOC2012/JPEGImages/'];
%histogram ranges from training
load([path_init 'top/2/VOC2012/Regions/JPEGImages/binranges_3.mat'], 'binranges');
load([path_init 'top/2/VOC2012/Categories/Grouped_Attributes_Hypothesis_Regions_Mapping.mat'], 'attributes');
resultpath = [ex_path, 'Iterative_Analysis_Results/'];
try
    mkdir(ex_path, 'Iterative_Analysis_Results/');
catch
end

i_ale = dir('./data/Multi_Algo_Final_Results/ale_val_cls/*.png');
i_cpmc = dir('./data/Multi_Algo_Final_Results/cpmc_val_cls/*.png');
i_sds = dir('./data/Multi_Algo_Final_Results/sds_val_cls/*.png');
i_long = dir('./data/Multi_Algo_Final_Results/long_shelhamer_val_cls/*.png');

C = intersect({i_ale(:).name}, {i_cpmc(:).name});
C = intersect(C, {i_sds(:).name});
C = intersect(C, {i_long(:).name});

hypranges = linspace(1,VOCopts.nclasses,VOCopts.nclasses);
k = numel(flabels)+1;
evidence = cell(1,k);
whole_image_data = [];
region_data = [];
fileID = fopen('chosen_alg.txt','w');

for i = 1:length(C)
    try
        ids = C{i}(1:end-4);
        inim = imread(strcat(im_path,ids, '.jpg'));
        evidence(1,1:k) = get_features_bn_pca(inim, flabels, att_data_mean1, max_vals1, U1, B1, min_vals1);  %get all those 4000 features (PCA and normalized)
        
        %% SVM 
        [idx] = svmpredict(1, cell2mat(evidence(1,1:k)), model1); % get the chosen best algo

        %% Evaluation
        [result, map] = get_result(idx, ids);
        s_size = size(unique(result));
        fprintf(fileID,'%20s\n', ids);
        fprintf(fileID,'%5d\n', idx);
        if s_size(1) > 2
            whole_image_data = [whole_image_data; ids evidence];
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
                    ninim = zeros(size(inim));
                    ninim(:,:,1) = im2double(result==cell2mat(area(j,1))).*im2double(inim(:,:,1));
                    ninim(:,:,2) = im2double(result==cell2mat(area(j,1))).*im2double(inim(:,:,2));
                    ninim(:,:,3) = im2double(result==cell2mat(area(j,1))).*im2double(inim(:,:,3));
                    evidence(1,1:k) = get_features_bn_pca(im2uint8(ninim), flabels, att_data_mean2, max_vals2, U2, B2, min_vals2); 
                    
                    region_data = [region_data; ids j evidence];
                    %% SVM 
                    [algo] = svmpredict(1, cell2mat(evidence(1,1:k)), model2);  

                    %% Merging 
                    fprintf(fileID,'%5d\n', algo);
                    [hyp_result, map] = get_result(algo, ids);
                    result = merge_hypothesis_image(result, area{j,1}, hyp_result);
                end
                %check for contradiction and generate hypothesis
                [area, ~, pos_hypotheses, ~, adj_hypotheses, ~, shape_hypotheses, ~, rel_size_hypotheses] = contradiction_check( path, result );
                [arn,~] = size(area);
                % check if new hypotheses are different from previous ones
                same = 1;
                [t, ~] = size(pos_hypotheses);
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
            imwrite(result, map, [resultpath ids '.png'], 'PNG');
        end
    catch exception
        getReport(exception)
        continue
    end
end
save([output_path 'whole_image.mat'], 'whole_image_data', '-v7.3');
save([output_path 'region_data.mat'], 'region_data', '-v7.3');
end