%function [new_res, index_rows, mins, suitability, rows] = analyze_data_for_bn(bins, removal, threshold, minmax)
function [suitability, im_accumulators, rows,  ent_results,  per_results, c_mu, a_mu, a_cov, c_cov,results, full_results, ful_results, norm_results,norm_results_s, max_vals, min_vals] = analyze_data_for_bn_pca(bins, removal, threshold, minmax, reduce, outvar)


addpath('/home/kamila/Documents/mi/');
%addpath('../cov/');

p = '/home/kamila/Documents/';
addpath(genpath([p 'libsvm-3.20']));
addpath(genpath([p 'segbench/lib/matlab']));
addpath(genpath([p 'vlfeat-0.9.17/toolbox']));

rmpath([p 'vlfeat-0.9.17/toolbox/noprefix']); 

%change this according to where the results of your algorithms are located
%algo_path = {'./data/Results/Crf_Segs/','./data/Results/all_gt_segm_all_feats_pca_noncent_5000_3.000000_test_cls/'};
algo_path = {'./data/Results/ale_val_cls/', './data/Results/comp6_val_cls/', './data/Results/cpmc_val_cls/'};
%algo_path = {'/home/kamila/Documents/Image_Understanding/data/Multi_Algo_Final_Results/ale_val_cls/', '/home/kamila/Documents/Image_Understanding/data/Multi_Algo_Final_Results/sds_val_cls/', '/home/kamila/Documents/Image_Understanding/data/Multi_Algo_Final_Results/cpmc_val_cls/', '/home/kamila/Documents/Image_Understanding/data/Multi_Algo_Final_Results/long_shelhamer_val_cls/', '/home/kamila/Documents/Image_Understanding/data/Multi_Algo_Final_Results/wdo_val_cls/'};


VOCinit;
%load_path = '/mnt/images/2/VOC2012/Regions/JPEGImages/';
load_path = '/home/alexandra/Documents/Image_Understanding/data/';
output_path = '/home/alexandra/Documents/Image_Understanding/data/analysis_output/';

%%% 3class modification
mkdir(output_path); 

%if bins > 0
%    outvar = ['bins_' sprintf('%d',bins) '_reduced_' removal '_evalresult'];
%else
%    outvar = ['nobins__reduced_' removal '_evalresult'];
%end
%outvar = 'nobins__reduced_false_evalresult_full_piece';
%outvar = 'nobins_reduced_evalresult_full_image';

% if the minmax was defined
if minmax > 0
   
    load_path = [load_path 'from_whole_images_best_analysis/' outvar '.mat'];
    load (load_path, 'results');
    full_results = results;
    [ful_results, non_clustered] = gen_eval_results(results, algo_path,reduce);

    first_feature = 'brightness 1';
%     norm_results = cell(size(ful_results,1), size(ful_results,2));
%     norm_results(:,1:7) = ful_results(:,1:7);
%     norm_results(1,:) = ful_results(1,:);
%     
%     
%     [~,p] = find(strcmp(ful_results(1,:), 'brightness 1'));
%     for i=p:size(ful_results,2)
%         col = cell2mat(ful_results(2:end,i));
%         col = col/max(col);
%         norm_results(2:end,i) = num2cell(col);
%     end
    
    norm_results = cell(size(full_results,1), size(full_results,2));
    norm_results(:,1:7) = full_results(:,1:7);
    norm_results(1,:) = full_results(1,:);
    
    [~,p] = find(strcmp(full_results(1,:), first_feature));
    for i=p:size(full_results,2)
        col = cell2mat(full_results(2:end,i));       
        col = (col-min(col))/(max(col)-min(col));
        norm_results(2:end,i) = num2cell(col);
    end    
    
    %%%%%%%%%%%%%%%%%%%%%
    norm_results_s = cell(size(non_clustered,1), size(non_clustered,2));
    norm_results_s(:,1:7) = non_clustered(:,1:7);
    norm_results_s(1,:) = ful_results(1,:); 
    
    
       
    [~,p] = find(strcmp(non_clustered(1,:), first_feature));
    
    for i=p:size(non_clustered,2)
        col = cell2mat(non_clustered(2:end,i));
        %max_vals(1,i) = num2cell(max(col)); 
        col = col/max(col);
        norm_results_s(2:end,i) = num2cell(col);
    end    
   
    save(['/home/alexandra/Documents/Image_Understanding/data/from_whole_images_best_analysis/norm_results_cont' '.mat'], 'norm_results_s', '-v7.3');
    %max_vals = max_vals(:, 8:end);
    %%%%%%%%%%%%%%%%%%%%%
    
    [~,p] = find(strcmp(full_results(1,:), first_feature));
    newdata = zeros(size(full_results,1)-1,size(full_results,2));
       
    
    %reduce data to n bins
    if reduce > 0
        for i=p:size(full_results,2)
            d=cell2mat(full_results(2:end,i));
            [~,dd] = histc(d,linspace(min(d), max(d), reduce));
            newdata(:,i) = dd;
        end
         full_results(2:end,p:end) = num2cell(newdata(:,p:end));
    end
    %full results binned
    [~,p] = find(strcmp(results(1,:), first_feature));
    newdata = zeros(size(results,1)-1,size(results,2));


%     %reduce data to n bins
%     if reduce > 0
%         for i=p:size(results,2)
%             d=cell2mat(results(2:end,i));
%             [~,dd] = histc(d,linspace(min(d), max(d), reduce));
%             newdata(:,i) = dd;
%         end        
%         temp_result(2:end,p:end) = num2cell(newdata(:,p:end));
%     end
    
    only_data = results(2:end,:);

    %this contains results of segmentation with recognition for each
    %algorithm 
    rows = cell(size(only_data,1), numel(algo_path));
    for i=1:numel(algo_path)
        rows(:,i) = only_data(:,5+(i-1)*3);
    end
    rows = cell2mat(rows);

    
    % index_rows contains all rows with values of results higher than threshold
    index_rows = ones(size(only_data,1), numel(algo_path));
    for i=1:numel(algo_path)
        index_rows(:,i) = (rows(:,i) > threshold);
    end

    [~,suitability] = max(rows, [], 2);
    [mins ,~] = min(rows, [], 2);
    mins = mins == 0;
    only_data(:,4+numel(algo_path)*3)  = mat2cell(suitability, ones(1,size(only_data,1), [1]));
    
    final_index = zeros(size(only_data,1), 1);
    for i=1:numel(algo_path)
        final_index = final_index+index_rows(:,i);
    end
    index_rows = [final_index, index_rows];
    
    index_rows(:,1) = index_rows(:,1).* mins;
    new_res = only_data(logical(index_rows(:,1)),:);
    
    new_eval = cell(size(new_res,1), 3);
    suitability = (cell2mat(new_res(:,(4+numel(algo_path)*3)))-1)*3;
    for i=1:size(new_res,1)
        new_eval(i,:) = new_res(i,suitability(i)+4:suitability(i)+6);
    end
    labels = [results(1,1:6) results(1,4+numel(algo_path)*3:end) ];
    new_res = [new_res(:,1:3), new_eval, new_res(:,4+numel(algo_path)*3:end) ];
    new_res = [labels; new_res];
    results = new_res;

   [~,p] = find(strcmp(results(1,:), first_feature));
    
    for i=p:size(results,2)
        col = cell2mat(results(2:end,i));
        max_vals(1,i) = num2cell(max(col)); 
        min_vals(1,i) = num2cell(min(col));
        col = (col-min(col))/(max(col)-min(col));
        results(2:end,i) = num2cell(col);
    end    
    max_vals = max_vals(:, 8:end);
    min_vals = min_vals(:, 8:end);
    
    
    
else
    outvar1 = [outvar '_full'];
    load_path = [load_path outvar1 '.mat'];
    load (load_path, 'results');
    full_results = results;
    
    load_path = [load_path outvar '.mat']
    load (load_path, 'results');
    if reduce > 0
        for i=p:size(results,2)
            d=cell2mat(results(2:end,i));
            [~,dd] = histc(d,linspace(min(d), max(d), reduce))
            results(2:end,i) = num2cell(dd);
        end
    end
end




labels = results(1,:);
only_data = results(2:end,:);
if threshold > 0
    only_data = only_data(cell2mat(only_data(:,5))> threshold, :);
end
all_images = only_data(:,1:7);
% map label names to ints
for i=1:VOCopts.nclasses
%    sprintf('There are %d images from %s Category\n', size(only_data(strcmp(only_data(:,3),VOCopts.classes{i}),3),1), VOCopts.classes{i})
    only_data(strcmp(only_data(:,3),VOCopts.classes{i}),3) = {i};
end
numeric_data = cell2mat(only_data(:,3:end));


%find the number of algorithms
algos = unique(numeric_data(:,5));
f_labels = labels(1,8:end);
selectors = unique(numeric_data(:,5));
num_of_steps = 4;

loadflag = 1;

size(labels)
size(f_labels)
size(numeric_data)
% try
%     load([output_path 'a_cov_' outvar '.mat'], 'a_cov');
%     load([output_path 'a_mu_' outvar '.mat'], 'a_mu');
%     load([output_path 'c_cov_' outvar '.mat'], 'c_cov');
%     load([output_path 'c_mu_' outvar '.mat'], 'c_mu');
%     load([output_path 'classes_cat_' outvar '.mat'], 'classes_cat');
%     load([output_path 'per_results_' outvar '.mat'], 'per_results');
%     load([output_path 'ent_results_' outvar '.mat'], 'ent_results');
%     load([output_path 'im_accumulators_' outvar '.mat'], 'im_accumulators');
% catch err
%     sprintf(getReport(err, 'basic'))
%    loadflag = 1;
% end

if loadflag == 1
    row = 'Features';
    row1 =[];
    row2 = [];
    
    for l=1:numel(f_labels)
        for i=1:numel(selectors)
            row1 = [row1, {sprintf('Algorithm %d', i)}];
            row2 = [row2, {f_labels{l}}];
        end
    end
    
    
    % statistics for each category of objects
    % classes_cat = classes_stats(VOCopts, numeric_data, f_labels, selectors, row1, row2);
    
    
    % calculate the mutual information with respect to object classes
    c_mu = zeros(VOCopts.nclasses, numel(f_labels));
    c_cov = zeros(VOCopts.nclasses, numel(f_labels));
    for i=1:VOCopts.nclasses
        for j=1:numel(f_labels)
            c_mu(i,j) = mutualinfo (double(numeric_data(:,5+j)), double(numeric_data(:,1)== i));
            cv = corrcoef(double(numeric_data(:,5+j)), double(numeric_data(:,3)== i));
            c_cov(i,j) = cv(1,2);
        end
    end
    %calculate the mutual information with respect to the best algorithms
    a_mu = zeros(1, numel(f_labels));
    a_cov = zeros(1, numel(f_labels));
    
    for j=1:numel(f_labels)
        a_mu(1,j) = mutualinfo (double(numeric_data(:,5+j)), double(numeric_data(:,5)));
        cv = corrcoef (double(numeric_data(:,5+j)), double(numeric_data(:,5)));
        a_cov(1,j) = cv(1,2);
    end
    
    % evaluate each category with resepect to each algorithm and fear each
    % feature with certain threshold
    % 1 - isolate each object from the whole data set
    % 2 - iterate through a number of thresholds for each feature
    % 3 - observe at which threshold the separation between objects detected by
    % one algorithm is the highest
    ent_results = cell(VOCopts.nclasses+1,numel(labels));
    ent_results(1,:) = labels;
    ent_results(2:end,1) = VOCopts.classes;
    per_results = cell(VOCopts.nclasses+1,numel(labels));
    per_results(1,:) = labels;
    per_results(2:end,1) = VOCopts.classes;
    
    % generate the suitability data and collect images into accumulators for
    % visual inspection
    accumulators = cell(VOCopts.nclasses+1, numel(f_labels)+3);
    accumulators{1,1} = 'Objects';
    accumulators(2:end,1) = VOCopts.classes;
    accumulators(1,2:end-2) = f_labels;
    accumulators{1,end-1} = 'Total';
    accumulators{1,end} = 'Percentage';
    im_accumulators = cell(numel(algos), num_of_steps);
    for m=1:numel(algos)
        for l=1:num_of_steps
            im_accumulators{m,l} = accumulators;
        end
    end
    
    
    for i=1:VOCopts.nclasses
        idxes = numeric_data(:,1) == i;
        obj_data = numeric_data(idxes,:);
        obj_names = all_images(idxes,:);
        for j=1:numel(algos)
            a =  numel(obj_data(obj_data(:,5) == j,1));
            for k=1:num_of_steps
                im_accumulators{j, k}{i+1,96} = a;
            end
        end
        %for each feature split into k bins determine the image mixture
        for j=1:numel(f_labels)
            f_select = obj_data(:,5+j);
            mn = min(f_select);
            mx = max(f_select);
            if ~isempty(mx) && ~isempty(mn)% && mn ~= mx
                steps = linspace(mn,mx,num_of_steps);
                step_ent = zeros(1,numel(steps)-1);
                step_per = zeros(1,numel(algos));
                for k=2:numel(steps)
                    sel = f_select > steps(k-1) & f_select <= steps(k);
                    algos_mix = obj_data(sel,5);
                    if ~isempty(algos_mix)
                        final_names = obj_names(sel,:);
                        algos_name_mix = obj_data(sel,5);
                        for o=1:numel(algos)
                            l = algos_name_mix == algos(o);
                            algos_names = final_names(l,:);
                            im_accumulators{algos(o), k-1}{i+1,j+1} = algos_names;
                        end
                        hh = double(histc(algos_mix,[1 2]))/numel(algos_mix);
                        step_ent(1,k-1) = entropy(algos_mix);
                        if size(hh,1) > size(hh,2)
                            step_per = [step_per, hh'];
                        else
                            step_per = [step_per, hh];
                        end
                    else
                        step_ent(1,k-1) = -1;
                        step_per = [step_per, zeros(1, numel(algos))];
                    end
                end
                ent_results{1+i,j+7} = step_ent;
                per_results{1+i,j+7} = step_per;
            end
        end
    end
%     save([output_path 'a_cov_' outvar '.mat'], 'a_cov', '-v7.3');
%     save([output_path 'a_mu_' outvar '.mat'], 'a_mu', '-v7.3');
%     save([output_path 'c_cov_' outvar '.mat'], 'c_cov', '-v7.3');
%     save([output_path 'c_mu_' outvar '.mat'], 'c_mu', '-v7.3');
%     save([output_path 'classes_cat_' outvar '.mat'], 'classes_cat', '-v7.3');
%     save([output_path 'per_results_' outvar '.mat'], 'per_results', '-v7.3');
%     save([output_path 'ent_results_' outvar '.mat'], 'ent_results', '-v7.3');
%     save([output_path 'im_accumulators_' outvar '.mat'], 'im_accumulators', '-v7.3');
end

%suitability = 0;
%plots = 0;
%[suitability,plots] = gen_plots(VOCopts, f_labels, algos, num_of_steps, per_results);


%represent the rules as POF (product of features)

%extract rules for algorithm selection
%First concatenate all the names from the suitability matrices
% Each rule is constructed as:
% for each label extract into the rule only such feature that distinguishes
% the images with a 90% accuracy only
% [r1,c1] = size(im_accumulators);
% rdata = [];
% rules = cell(r1,c1);
% for a=1:r1
%     for b=1:c1
%         m = im_accumulators{a,b};
%         [r2,c2] = size(m);
%         rule = cell(r2,c2);
%         rule(:,1) = m(:,1);
%         rule(1,:) = m(1,:);
%         for c=2:r2
%             red = [];%cell(VOCopts.nclasses+1, numel(f_labels)+3);
%             cdata = [];
%             
%             for d=2:c2
%                 
%                 if ~isempty(m{c,d}) & ~(size(m{c,d},2) < 2)
%                     ce = {strcat(m{c,d}(:,1),m{c,d}(:,2))};
%                     re = strcat(m{c,d}(:,1),m{c,d}(:,2));
%                     red = [red, re'];
%                     cdata = [cdata, ce];
%                 else
%                     cdata = [cdata, cell(1,1)];
%                 end
%             end
%             if ~isempty(red)
%                 binranges = str2num(cell2mat(unique(red)'));
%                 im_accumulators{a,b}{c,97} = double(numel(binranges))/double(im_accumulators{a,b}{c,96});
%                 [cr,cc] = size(cdata);
%                 rd = zeros(numel(binranges), cc);
%                 for e=1:cc
%                     try
%                         rec = str2num(cell2mat(cdata{e}));
%                     catch
%                         rec = zeros(numel(binranges),1);
%                     end
%                     %                    rec
%                     %                    binranges
%                     t = histc(rec,binranges)';
%                     rd(:,e) = t;
%                 end
%                 if size(rd,1) == 1
%                     rd = double(rd)/numel(binranges);
%                 else
%                     rd = double(sum(rd))/numel(binranges);
%                 end
%                 rule(c,2:cc+1) = mat2cell(rd,[1], ones(1,cc));
%             end
%             emptyIndex = cellfun(@isempty, rule);
%             rule(emptyIndex) = {100};
%         end
%         rules{a,b} = rule;
%     end
% end

%now calculate the most extravagant unique features for each object class
%by determining teh variance and STD
% [r,c] = size(rules);
% rows = [];
% for i=1:r
%     for j=1:VOCopts.nclasses
%         rs = zeros(4,size(rules{1,1},2)-1);
%         for k=1:c-1
%             %             rules{i,k}(j+1,2:end);
%             %             cell2mat(rules{i,k}(j+1,2:end));
%             rs(k,:) = (cell2mat(rules{i,k}(j+1,2:end)));
%         end
%         rows = [rows; std(rs)];
%         rows = [rows; mean(rs)];
%         
%     end
% end
end

function [full_results, non_clustered] = gen_eval_results(results,algo_path,reduce)
    only_data = results(2:end,:);
    %this contains results of segmentation with recognition for each
    %algorithm 
    rows = cell(size(only_data,1), numel(algo_path));
    for i=1:numel(algo_path)
        rows(:,i) = only_data(:,5+(i-1)*3);
    end
    rows = cell2mat(rows);
    
    %index_rows contains all rows with values of results higher than 0
    index_zero_rows = ones(size(only_data,1), numel(algo_path));
    for i=1:numel(algo_path)
        index_zero_rows(:,i) = (rows(:,i) > 0);
    end
    
    [~,suitability] = max(rows, [], 2);
    only_data(:,4+numel(algo_path)*3)  = mat2cell(suitability, ones(1,size(only_data,1), [1]));
        
    final_index = zeros(size(only_data,1), 1);
    for i=1:numel(algo_path)
        final_index = final_index+index_zero_rows(:,i);
    end
    index_zero_rows = [final_index, index_zero_rows];
    
    index_zero_rows(:,1) = index_zero_rows(:,1);
    full_results = only_data(logical(index_zero_rows(:,1)),:);
    
    new_eval = cell(size(full_results,1), 3);
    suitability = (cell2mat(full_results(:,(4+numel(algo_path)*3)))-1)*3;
    for i=1:size(full_results,1)
        new_eval(i,:) = full_results(i,suitability(i)+4:suitability(i)+6);
    end
    labels = [results(1,1:6) results(1,4+numel(algo_path)*3:end) ];
    full_results = [full_results(:,1:3), new_eval, full_results(:,4+numel(algo_path)*3:end) ];
    full_results = [labels; full_results];
    
    non_clustered = full_results;
    
    [~,p] = find(strcmp(full_results(1,:), 'brightness 1'));
    newdata = zeros(size(full_results,1)-1,size(full_results,2));    
    %reduce data to n bins
    if reduce > 0
        for i=p:size(full_results,2)
            d=cell2mat(full_results(2:end,i));
            [~,dd] = histc(d,linspace(min(d), max(d), reduce));
            newdata(:,i) = dd;
        end
        full_results(2:end,p:end) = num2cell(newdata(:,p:end));
    end

end

function [] = gen_sep_file(im_accumulators, image_path, algo_path, output_path)
%generate files in seperate folders for visual inspection
% folder name is as follows: algorithm_id_Feature_Range
[r,c] = size(im_accumulators);
spath = [output_path 'Algorithm_%d/Object_%s/'];
for i=1:r
    for j=1:c
        x = im_accumulators{i,j};
        [xr,xc] = size(x)
        for k=2:xr
            for l=2:xc
                if size(x{k,l},2) > 5
                    save_path = sprintf(spath, i,x{k,1});
                    mkdir(save_path);
                    y = strcat(x{k,l}(:,1), {'_'}, x{k,l}(:,2), {'.jpg'});
                    yy = strcat(x{k,l}(:,1), {'_'}, x{k,l}(:,2), {'.png'});
                    for m=1:numel(y)
                        copyfile([image_path y{m}], save_path );
                        copyfile([algo_path{i} yy{m}], save_path);
                    end
                end
            end
        end
    end
end
end


function[suitability,plots] = gen_plots(VOCopts, f_labels, algos, num_of_steps, per_results)
%plot maximum percentile and minimum entropy for each feature
plots = zeros(VOCopts.nclasses, numel(f_labels), 2, numel(algos),num_of_steps);
suitability = cell(VOCopts.nclasses+1, numel(f_labels)+1, numel(algos));
%suitability = cell(numel(algos)+1,numel(f_labels));
for l=1:numel(algos)
    suitability(1,2:end,l) = f_labels;
    suitability(2:end,1,l) = VOCopts.classes;
end
for i=1:VOCopts.nclasses
    for j=1:numel(f_labels)
        cl = per_results{1+i,7+j};
        %coeffs = zeros(numel(algos),1);
        for l=1:numel(algos)
            [ma,ima] = max(cl(1,l:numel(algos):end));
            [mi,imi] = min(cl(1,l:numel(algos):end));
            plots(i,j,1,l,ima) = ma;
            plots(i,j,2,l,imi) = mi;
            if ma >= 1
                suitability{i+1,j+1,l} = ima;
            end
        end
    end
end
for i=1:VOCopts.nclasses+1
    for j=1:numel(f_labels)
        for l=1:numel(algos)
            if isempty(suitability{i,j,l})
                suitability{i,j,l} = 0;
            end
        end
    end
end
end


function classes_cat = classes_stats(VOCopts, only_numeric, f_labels, selectors, row1, row2)
classes_cat = row1;
classes_cat = [classes_cat;row2];
classes_cat = [[{'Category'}; {'Category'}],classes_cat];

% statistics for each category of objects
for l=1:VOCopts.nclasses
    sel_class = only_numeric(only_numeric(:,1) == l,:);
    %        sel_class = only_data(strcmp(VOCopts.classes{l},only_data(:,3)),:);
    fs = VOCopts.classes{l};
    for j=1:numel(f_labels)
        col = sel_class(:,5+j);
        for i=1:numel(selectors)
            cl = col(sel_class(:,5) == selectors(i),:);
            f(1,1) = std(cl);
            f(1,2) = mean(cl);
            f(1,3) = var(cl);
            f(1,4) = cov(cl);
            f(1,5) = median(cl);
            fs = [fs, mat2cell(f,1,5)];
        end
    end
    classes_cat = [classes_cat;fs];
end
end