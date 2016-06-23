% DESCRIPTION: this code combines nn classification with statistics. CNN
% features are used.

%% Initialization
clc;
clear;

% create directory for storing results
resultpath = '/home/alexandra/Documents/Image_Understanding/Regions/NN_stat_CNN_results/';
try
    mkdir(resultpath);
catch
end

% load CNN features
dirName = './features/';
files = dir(fullfile(dirName, '*.mat'));
files = {files.name}'; 

im_path = '/media/top/2/VOC2012/JPEGImages/';
path = '/home/alexandra/Documents/Image_Understanding/data/Multi_Algo_Final_Results/';
algos = {'ale', 'cpmc', 'sds', 'long_shelhamer', 'wdo'};

VOCinit;
hypranges = linspace(1,VOCopts.nclasses,VOCopts.nclasses);

load('dataset.mat');
load('target.mat');

[coeff, score] = pca(dataset');

%% TRAIN A NN

% net = nn(score(:,1:300)', target);  % taking first 300 pca features (adding others doesnt's really influence the end result)
net = nn(score', target);
%%
for i = 1:length(files)    
    imid = files{i}(1:end-4);
    inim = imread(strcat(im_path,imid, '.jpg'));
    output = net(score(i,1:300)');
    idx = 0;
    maxval = 0;
    for l = 1:length(output)
        if output(l) > maxval
            maxval = output(l);
            idx = l;
        end
    end
    [result, map] = get_result(idx-2, imid);
    imwrite(result, map, [resultpath imid '.png'], 'PNG');
    
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

                %% SVM 
                [algo] = iterative_analysis_understanding_stat_5algos(area{j,1});  

                %% Merging 
                [hyp_result, map] = get_result(algo-2, imid);
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
    end  
end

