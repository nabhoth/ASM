clc;
clear;

%% INIT
addpath('/home/alexandra/Documents/VOCdevkit/VOCcode/');
addpath('/home/alexandra/Documents/Image_Understanding/');

VOCinit;
hypranges = linspace(1,VOCopts.nclasses,VOCopts.nclasses);

%% LOAD DATA
dirName = './features/';
files = dir(fullfile(dirName, '*.mat'));
files = {files.name}';

% Because I extract object features in real-time I cannot use dataset.mat
% because I don't know at which rows to remove zeros. That's why I built
% a different database that will contain features that are averaged over
% the CNN features' columns (4096 x 1)

% And again, I saved the resulted matrix into dataset2 and just commented
% out the code that I used (below)

% dataset2 = zeros(4096, length(files));
% for i=1:length(files)
%     load([dirName files{i}]);
%     dataset2(:,i) = mean(features,2);
% end
% save('dataset2','dataset2');

load('dataset2.mat');
load('target.mat');

%% TRAIN A NN

[coeff, score] = pca(dataset2');
net = nn(score(:,1:300)', target);

%% SAVE IMAGES CLASSIFIED BY THE OBTAINED NN
resultpath = '/home/alexandra/Documents/Image_Understanding/Regions/NN_hypo_CNN_results2/';
try
    mkdir(resultpath);
catch
end

for i = 1:length(files)    
    imid = files{i}(1:end-4);
    recs=PASreadrecord(sprintf(VOCopts.annopath,imid));
    inim = imread(strcat('images_voc2012/',imid, '.jpg'));
    output = net(score(i,1:300)');
    maxind = 1;
    for l = 1:length(output)
        if output(l) > output(maxind)            
            maxind = l;
        end
    end
    [result, map] = get_result(maxind-2, imid);
    
    try
        s_size = size(unique(result));
        if s_size(1) > 2
            [area, pos_errors, pos_hypotheses, adj_errors, adj_hypotheses, shape_errors, shape_hypotheses, rel_size_errors, rel_size_hypotheses] = contradiction_check(path, result);
            [ar,~] = size(area);
            H = zeros(ar,1);
            while true
                if ar < 2
                    break;
                end
                % extract the hypothesis as the maximum occurence among all hypotheses
                hypotheses = [pos_hypotheses(:,3), adj_hypotheses(:,3), rel_size_hypotheses(:,3), shape_hypotheses(:,2)];
                for j=1:ar
                    % histograms of hypotheses
                    hypcounts = histc(hypotheses(j,:), hypranges);
                    H(ar,1) = max(hypcounts);
                    %check if hypothesis is different from original label
                    if H(ar,1) == area{j,1}
                        continue;
                    end
                    
                    %build an image with only region being not black
                    ninim = zeros(size(inim));
                    ninim(:,:,1) = im2double(result==cell2mat(area(j,1))).*im2double(inim(:,:,1));
                    ninim(:,:,2) = im2double(result==cell2mat(area(j,1))).*im2double(inim(:,:,2));
                    ninim(:,:,3) = im2double(result==cell2mat(area(j,1))).*im2double(inim(:,:,3));
                    features = double(return_cnn_features(ninim, 1)); 
                    %cur_obj_im = inim(recs.objects(j).bbox(2):recs.objects(j).bbox(4), recs.objects(j).bbox(1):recs.objects(j).bbox(3),:);
                    %features = double(return_cnn_features(cur_obj_im, 1));                    
                    pca_features = features'*coeff;
                    %% SVM 
                    output = net(pca_features(1:300)');
                    for l = 1:length(output)
                        if output(l) > output(maxind)            
                            maxind = l;
                        end
                    end
                    [hyp_result, map] = get_result(maxind-2, imid);

                    %% Merging 
                    result = merge_hypothesis_image(result, area{j,1}, hyp_result);
                end
                %check for contradiction and generate hypothesis
                [area, pos_errors, pos_hypotheses, adj_errors, adj_hypotheses, shape_errors, shape_hypotheses, rel_size_errors, rel_size_hypotheses] = contradiction_check(path, result);
                [arn,~] = size(area);
                % check if new hypotheses are different from previous ones
                H2 = zeros(arn,1);
                same = 1;
                [t, z] = size(pos_hypotheses);
                if t > 0
                    % extract the hypothesis as the maximum occurence among all hypotheses
                    if size(pos_hypotheses,2) < 3 || size(adj_hypotheses,2) < 3 || size(rel_size_hypotheses,2) < 3 || size(shape_hypotheses,2) < 2
                        hypotheses2 = [pos_hypotheses(:,3), adj_hypotheses(:,3), rel_size_hypotheses(:,3), shape_hypotheses(:,2)];
                        size(pos_hypotheses)
                        for j=1:arn
                            if hypotheses2(j,:) ~= hypotheses(j,:)
                                same = 0;
                                break;
                            end
                        end
                    end
                end                
                sprintf('writing...')
                imwrite(result, map, [resultpath imid '.png'], 'PNG');
                if same == 1
                    break
                end
                ar = arn;
            end            
        else
            imwrite(result, map, [resultpath imid '.png'], 'PNG');
        end
           
    catch        
        imwrite(result, map, [resultpath imid '.png'], 'PNG');
    end
    
end
