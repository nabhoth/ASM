function [ ] = iterative_analysis_understanding(bnet, engine,flabels)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%Initialize the VOC databse
VOCinit;

%Result prefix path
ex_path = './Regions/';
%Path to the images to be processed
%im_path = '/home/nabhoth/codes/vision_algorithms/VOCdevkit/VOC2012/JPEGImages/';
im_path = '/media/3c82bfeb-15c9-4f45-b9d7-861e6410ad5c/top/2/VOC2012/JPEGImages/';
%histogram ranges from training
%load('/mnt/hdb/top/2/VOC2012/Regions/JPEGImages/binranges_3.mat', 'binranges');
%load ('/mnt/hdb/top/2/VOC2012/Categories/Grouped_Attributes_Hypothesis_Regions_Mapping.mat', 'attributes');
load('/media/3c82bfeb-15c9-4f45-b9d7-861e6410ad5c/top/2/VOC2012/Regions/JPEGImages/binranges_3.mat', 'binranges');
load('/media/3c82bfeb-15c9-4f45-b9d7-861e6410ad5c/top/2/VOC2012/Categories/Grouped_Attributes_Hypothesis_Regions_Mapping.mat', 'attributes');

resultpath = [ex_path, 'Iterative_Analysis_Results/'];
try
	mkdir(ex_path, 'Iterative_Analysis_Results/');
catch
end
iids = dir('./data/Multi_Algo_Final_Results/ale_val_cls/*.png');

hypranges = linspace(1,VOCopts.nclasses,VOCopts.nclasses);
%[bnet,engine] = create_bn_simple;
%engine = jtree_inf_engine(bnet);

 k = numel(flabels);
 n = k+9+2+1;
 evidence = cell(1,n);
 
%evidence = cell(1,19);

    for i = 1:numel(iids)
    try
    ids = iids(i).name(1:end-4);
%    try
        %read input image
        inim = imread(strcat(im_path,ids, '.jpg'));
%       inim = im2double(im);
        [h,w] = size(inim);
        
        %read salience scaled
        %im = imread(strcat(im_path,ids, '_salience.jpg'));
        %sim = im2double(im);
        %[sh,~] = size(sim);
        %if sh ~= h
        %    sim = imresize(sim, [h w]) ;
        %end
        %sim = double(sim);
        
        %read edge image
        %im = imread(strcat(ex_path,'JPEGImages/',ids, '_edge.ppm'));sho
        %eim = im2double(im);
        %[eh,~] = size(eim);
        %if eh ~= h
        %    eim = imresize(eim, [h w]) ;
        %end
        %eim = double(eim);
        
        %extract features from the whole input image

	% evidence(1,1:k) = get_features_bn(inim);
    
         evidence(1,1:k) = get_features_bn(inim, flabels);
   

        %evidence(1,1:7) = get_features_bn(inim);
        %cluster the evidence data to binranges
        evidence = reduce_attributes_features_real_time(binranges, evidence);
        
        
        
        %input  evidence data to the BN
        [engine, loglik] = enter_evidence(engine, evidence);
        %do inference using BN
        marg = marginal_nodes(engine, n);
        %marg = marginal_nodes(engine, 19);
%        marg.T
        [idx idx] = max(marg.T);
        
        %get the selected algorithm id
        result = get_result(idx, ids);
        %get the contradiction from the result obtained by the image
        %processsed by the algorithm id
        s_size = size(unique(result));
        
        if s_size(1) > 2   
            [area, pos_errors, pos_hypotheses, adj_errors, adj_hypotheses, shape_errors, shape_hypotheses, rel_size_errors, rel_size_hypotheses] = contradiction_check( path, result );           
            [ar,~] = size(area);           
            H = zeros(ar,1);

            conditionEnd = 'false';
            while strcmp(conditionEnd, 'false')                
               
                    if ar < 2
                    break;
                    end

                % extract the hypothesis as the maximum occurence among all hypotheses
                hypotheses = [pos_hypotheses(:,3), adj_hypotheses(:,3), rel_size_hypotheses(:,3), shape_hypotheses(:,2)];

                for i=1:ar               
                    % histograms of hypotheses
                    hypcounts = histc(hypotheses(i,:), hypranges);
                        [H(ar,1) H(ar,1)] = max(hypcounts);
                        %check if hypothesis is different from original label
                        if H(ar,1) == area{i,1}                      
                            continue;
                        end 
                        %extract region features
                        %build an image with only reion being not black                    
                        ninim =  zeros(size(inim));                   
                        ninim(:,:,1) = im2double(result==cell2mat(area(i,1))).*im2double(inim(:,:,1));
                        ninim(:,:,2) = im2double(result==cell2mat(area(i,1))).*im2double(inim(:,:,2));
                        ninim(:,:,3) = im2double(result==cell2mat(area(i,1))).*im2double(inim(:,:,3));                   
                       evidence(1,1:k) = get_features_bn(ninim, flabels);                  
                       evidence(1,k+1:end-3) = attributes(H(ar,1)+1,2:10);           
                       % evidence(1,1:7) = get_features_bn(ninim);
                       % evidence(1,8:end-3) = attributes(H(ar,1)+1,2:10);                    
                        evidence = reduce_attributes_features_real_time(binranges, evidence);
                        %do inference with BN by regional features and hypothesis attributes
                        [engine, loglik] = enter_evidence(engine, evidence);                    
                        marg = marginal_nodes(engine, n);
                        %marg = marginal_nodes(engine, 19);
        %        	    marg.T;
                        [algo algo] = max(marg.T);
                        %check if the new algorithm selected is different from previously
                        %selected one
                        hyp_result = get_result(algo, ids);
                        result = merge_hypothesis_image(result, uint16(floor(area{i,8})), hyp_result);

                end
                    %check for contradiction and generate hypothesis
                    [area, pos_errors, pos_hypotheses, adj_errors, adj_hypotheses, shape_errors, shape_hypotheses, rel_size_errors, rel_size_hypotheses] = contradiction_check( path, result );
                    [arn,~] = size(area);
                    sprintf('check 1...')
                    % check if new hypotheses are different from previous ones
                    H2 = zeros(arn,1);
                    same = 1;
                    % extract the hypothesis as the maximum occurence among all hypotheses
                    hypotheses2 = [pos_hypotheses(:,3), adj_hypotheses(:,3), rel_size_hypotheses(:,3), shape_hypotheses(:,2)];
            %	    if arn == ar
                for j=1:arn
                    if hypotheses2(j,:) ~= hypotheses(j,:)                    
                    same = 0;
                    break;
                    end
                end            


    	    
                sprintf('writing...')
                imwrite(result, [resultpath ids '.png'], 'PNG');
                if same == 1
                    break
                end
                ar = arn;
            end
            %hypotheses = hypotheses2;
        end
%    catch err
%	sprintf('%s',err.message)        
   catch exception
        getReport(exception)
        continue  
    end
end
   
end

