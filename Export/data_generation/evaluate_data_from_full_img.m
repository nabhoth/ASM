function [results] = evaluate_data_from_full_img()
% function [results] = evaluate_data_for_bn()
% evaluates the results of whole imate processing and termines which
% algorithms obtains the best result for a given image. Uses standard F
% measure to determine the quality of processing.
prefix='./data/Multi_Algo_Final_Results/';
% path to the resuls directories the suitability is indicated by integere
% corresponding to the order of th einput paths
%algo_paths = {'./Image_Understanding/data/Results/Crf_Segs/', './Image_Understanding/data/Results/all_gt_segm_all_feats_pca_noncent_5000_3.000000_test_cls/'};
algo_paths = {[prefix 'ale_val_cls/'], [prefix 'sds_val_cls/'], [prefix 'cpmc_val_cls/'], [prefix 'long_shelhamer_val_cls/'], [prefix 'wdo_val_cls/']};

%alepath = './Image_Understanding/data/Results/Crf_Segs/';
%cpmcpath = './Image_Understanding/data/Results/all_gt_segm_all_feats_pca_noncent_5000_3.000000_test_cls/';
% alepath = '/mnt/images/2/VOC2012/Regions/Result/Crf_Segs/';
% cpmcpath = '/mnt/images/2/VOC2012/Regions/results/VOC2012/Segmentation/all_gt_segm_all_feats_pca_noncent_5000_3.000000_test_cls/';
VOCinit;
% image test set
[gtids,t]=textread(sprintf(VOCopts.seg.imgsetpath,VOCopts.testset),'%s %d');
%output path
%output_pathevaluate_data_for_bn_bb.m = '/mnt/images/VOC2012/Train_Regions/';
%attributes = importdata(['/home/nabhoth/codes/BN-Selection/' 'BN-Table.csv'], ',');


p = '/home/kamila/Documents/';
addpath(genpath([p 'libsvm-3.20']));
addpath(genpath([p 'segbench/lib/matlab']));
addpath(genpath([p 'vlfeat-0.9.17/toolbox']));

rmpath([p 'vlfeat-0.9.17/toolbox/noprefix']);


output_path = './data/';
mkdir([output_path '/from_whole_images_best_analysis/']);

%output_path = '/mnt/images/2/VOC2012/Regions/JPEGImages/';
%load([output_path 'Textures_Hypothesis_Regions_Mapping_BN_' sprintf('%d',bins) '_reduced_' removal '.mat'], 'mapping');

load([output_path '/from_whole_images_best_analysis/Features_Hypothesis_Whole_Image_Mapping_extended.mat'], 'mapping');

[h,~] = size(mapping);

%mapping = mapping(max(isnan(mapping(:,:)),[],2),:);


findex = find(strcmp(mapping(1,:), 'brightness 1'));

all_count = 2;
results = cell(h,4+(3*numel(algo_paths))+numel(mapping(1,findex:end)));
results{1,1} = 'name prefix';
results{1,2} = 'name postfix';
results{1,3} = 'classname';
for i=1:numel(algo_paths)
    m = ((i-1)*3)+3;
    results{1,m+1} = 'detection';
    results{1,m+2} = 'segmentation';
    results{1,m+3} = 'raw segmentation';
end

results{1,(numel(algo_paths)*3)+4} = 'suitability';
results(1,(numel(algo_paths)*3)+5:end) = mapping(1,6:end);

mapping = mapping(2:end,:);

for n=1:length(gtids)
    imname = gtids{n};    
    
    gtfile = sprintf(VOCopts.seg.clsimgpath,imname);
    [gtim] = imread(gtfile);
    gtim = double(gtim);
    %get the bounding box for all objects
    % read annotation
    recs=PASreadrecord(sprintf(VOCopts.annopath,imname));
    
   
    %for j=1:numel(recs.objects)
    %algo_results = [];%zeros(numel(algo_paths),3);
    %         aleresult = zeros(1,3);
    %         cpmcresult = zeros(1,3);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %if (j > 9)
    %   jgtids = strrep(imname, '_00', sprintf('_%d',j));
    %else
    %    jgtids = strrep(imname, '_00', sprintf('_0%d',j));
    %    
    %end        
        

        [x,y] = find(ismember(mapping(:,1), imname(1:4)) & ismember(mapping(:,2), imname(6:end))); 
        if (~isempty(x) && ~isempty(y))
            results{all_count,1} = mapping{x,1};
            results{all_count,2} = mapping{x,2};
            results{all_count,3} = mapping{x,4};
            
        
            % extract objects of class
          
           index = cell(1, numel(recs.objects));
           for j = 1:numel(recs.objects())
               index{j}  =  find(ismember(VOCopts.classes, recs.objects(j).class));
           end
           
           ind = unique(cell2mat(index));           
     
         
           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            results(all_count,(numel(algo_paths)*3)+5:end) = mapping(x,6:end);    
            
            
            for k=1:numel(algo_paths)
                try                    
                    [resfile, ~] = imread([algo_paths{k} imname '.png']);                  

                    m = ((k-1)*3)+3;
                    detected = [];
                    seg = [];
                    rawsegm = [];
                    for j = 1:numel(ind)
                        mask = gtim;
                        mask = (mask == ind(j));                                 
                        [a, b, c] = eval_symb_seg(resfile, mask, ind(j));
                        detected = [detected a];
                        seg = [seg b];
                        rawsegm = [rawsegm c];                        
                    end                    
                                       
                    results{all_count,m+1} = mean(detected);
                    results{all_count,m+2} = mean(seg);
                    results{all_count,m+3} = mean(rawsegm); 
                    
                    if isempty(results{all_count,m+1})
                        results{all_count,m+1} = 0;
                        results{all_count,m+2} = 0;
                        results{all_count,m+3} = 0;                        
                    end

                catch
                    sprintf('algorithm %d error', k)
                    m = ((k-1)*3)+3;
                    results{all_count,m+1} = 0;
                    results{all_count,m+2} = 0;
                    results{all_count,m+3} = 0;
                end
            end
            
            all_count = all_count + 1;
        end
   % end    
end


%emptyrows = cellfun(@isempty,results(:,4));
%results(emptyrows,:) = [];
%% results(:,4:6)
%tt = cell2mat(results(2:end,4:6));
%size(tt)
%remove = tt(:,1)>0 | tt(:,2)>0 | tt(:,3)>0;
%remove = [1;remove];
%% remove = ~remove;
%% size(remove)
%% size(results)
%results = results(logical(remove),:);
%[r,c] = size(results);
%% tt = cell2mat(results(2:end,7));
%% tt = tt + 1;
%% results(2:end,7) = mat2cell(tt,ones(1,r-1),1);
save_path = [output_path '/from_whole_images_best_analysis/nobins_reduced_evalresult_full_image_5algos.mat'];

save (save_path, 'results', '-v7.3');

% %% Extract the images in directories according to the extract criterion
% % extract values 
% %           1 - extract images such that detection for one algorithm is 1
% %           and 0 for all others
% %           0 - extract images such that algorithm 1 is better than all
% %           others
% %           > 1 - extract images such that the detection for one algorithm
% %           is 1, 0 for all others and the overall result quality is > n
% if extract == 1
%     for j=1:numel(algo_paths)
%         result_data = results(2:end,:);
%         for k=1:numel(algo_paths)
%             m = ((k-1)*3)+3;
%             if k == j
%                 result_data = result_data(cell2mat(result_data(:,m+1)) > 0,:);
%             else
%                 result_data = result_data(cell2mat(result_data(:,m+1)) < 1,:);
%             end
%         end
%         gen_sep_file(j, result_data, image_path, algo_paths, [output_path '/from_whole_images_best_analysis/'], VOCopts, extract);
%     end
% else if extract < 1
%         for j=1:numel(algo_paths)
%             result_data = results(2:end,:);
%             n = ((j-1)*3)+3;
%             result_data = result_data(cell2mat(result_data(:,n+3)) > 0,:);
%             for k=1:numel(algo_paths)
%                 m = ((k-1)*3)+3;
%                 if k ~= j
%                     indx = cell2mat(result_data(:,m+3)) < cell2mat(result_data(:,n+3));
%                     result_data = result_data(indx,:);
%                 end
%             end
%             gen_sep_file(j, result_data, image_path, algo_paths, [output_path '/from_whole_images_best_analysis/'], VOCopts, extract);
%         end
%     else if extract > 1
%             for j=1:numel(algo_paths)
%                 result_data = results(2:end,:);
%                 for k=1:numel(algo_paths)
%                     m = ((k-1)*3)+3;
%                     if k == j
%                         result_data = result_data(cell2mat(result_data(:,m+1)) > 0,:);
%                     else
%                         result_data = result_data(cell2mat(result_data(:,m+1)) < 1,:);
%                     end
%                 end
%                 l = ((j-1)*3)+5;
%                 result_data = result_data(cell2mat(result_data(:,l)) >= extract,:);
%                 gen_sep_file(j, result_data, image_path, algo_paths, [output_path '/from_whole_images_best_analysis/'], VOCopts, extract);
%             end            
%         end
%     end
% end
end
%save([output_path 'train.txt'], 'out_names', '-ascii');
% function [] = gen_sep_file(algorithm, result_data, image_path, algo_paths, output_path, VOCopts, extract)
% %generate files in seperate folders for visual inspection
% % folder name is as follows: algorithm_id_Feature_Range
% [r,c] = size(result_data)
% 
% final_result = cell(1, VOCopts.nclasses);
% for i=1:VOCopts.nclasses
% %    final_resultnumel(result_data(strcmp (VOCopts.classes{i}, result_data(:,3)),1));
%     try
%         save_path = sprintf('Extract_%d/Algorithm_%d/Object_%s/', extract,algorithm,VOCopts.classes{i});
%         save_path = strcat(output_path, save_path)
%         mkdir(save_path);
%     catch err
%     
%     end
% end
% 
% for i=1:r
%     save_path = sprintf('Extract_%d/Algorithm_%d/Object_%s/', extract,algorithm,result_data{i,3});
%     save_path = strcat(output_path, save_path);
%     final_result{1,find(strcmp(VOCopts.classes(:), result_data{i,3}))} = [final_result{1,find(strcmp(VOCopts.classes(:), result_data{i,3}))}; result_data(i,:) ];
%     y = strcat(result_data{i,1}, {'_'}, result_data{i,2}, {'.jpg'});
%     yy = strcat(result_data{i,1}, {'_'}, result_data{i,2}, {'.png'});
% try
%     copyfile(char(strcat(algo_paths{algorithm}, yy)), char(save_path));
%     copyfile(char(strcat(image_path, y)), char(save_path) );
% catch
% end
% end
% for i=1:VOCopts.nclasses
%     save_path = sprintf('Extract_%d/Algorithm_%d/Object_%s/', extract,algorithm,VOCopts.classes{i});
%     save_path = strcat(output_path, save_path, 'features.mat');
%     results = final_result{1,i};
%     save(save_path, 'results');    
% end
% end

