function [bnet, out_results, mm_results,results, norm_results,min_rules] = find_algo_advantages(margin)
% calculate the average of results given label at point x in the given
% space given a feature id a
% first determine the min - max of a given feature and then determine how
% wide the region of proximity should be.
bins = 0;
removal = 'false';
threshold = 70;
minmax = 1;
reduce = 4;
VOCinit;

[suitability, im_accumulators, rules, rows, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov,results, full_results, ful_results,norm_results ] = analyze_data_for_bn(bins, removal, threshold, minmax,reduce);



%get te columns indexes from both the full data and from the min-max one
labels = results(1,:);
a = find (strcmpi('suitability', labels))+1;
data_index_start = a;
labels = labels(1, a:end);

full_labels = full_results(1,:);
a = find (strcmpi('suitability', full_labels))+1;
full_data_index_start = a;
flabels = full_labels(1, a:end);

out_results = cell(VOCopts.nclasses+1,numel(flabels)+1);
out_results(2:end,1) = VOCopts.classes;
out_results(1, 2:end) = flabels;

mm_results = cell(VOCopts.nclasses+1,numel(flabels)+1);
mm_results(2:end,1) = VOCopts.classes;
mm_results(1, 2:end) = flabels;

for i=1:VOCopts.nclasses
    label = VOCopts.classes{i};
    %sprintf('Label %s\n', label)
    %get the data again from the full and from the min-max data
    only_data_results = results(2:end,:);
    label_index = strcmp(only_data_results(:,3), label);
    label_results = only_data_results(label_index,:);
    %size(label_results)
    
    full_only_data_results = full_results(2:end,:);
    full_label_index = strcmp(full_only_data_results(:,3), label);
    full_label_results = full_only_data_results(full_label_index,:);
    
    for j=1:numel(labels)
        column = (cell2mat(label_results(:,data_index_start-1+j)));
        fmax = max(column);
        fmin = min(column);
        funique = unique(column);
        fdelta = fmax/(100/margin);
        
        fcolumn = (cell2mat(full_label_results(:,full_data_index_start-1+j)));
        %lower and upper bound for selection
        feat_results = [];
        mm_result = [max(fcolumn), min(fcolumn); fdelta, fdelta; -1, -1];
        %mm_result = [fmax, fmin; -1, -1];
        for k=1:numel(column)
            fval = column(k);
            f1 = fval - fdelta;
            f2 = fval + fdelta;
            all_index = (fcolumn > f1) & (fcolumn < f2);
            region_results = full_label_results(all_index,:);
            if size(region_results,1) > 0
                both_nil_index = (cell2mat(region_results(:,5)) ==0) & (cell2mat(region_results(:,8)) == 0);
                region_results(both_nil_index,:) = [];
                [~,best_algo] = max([cell2mat(region_results(:,5)), cell2mat(region_results(:,8))],[],2);
                [br,bc] = size(best_algo);
                region_results(:,10) = mat2cell(best_algo', ones(bc,1), ones(br,1));
                al1mean = mean(cell2mat(region_results(:,5)));
                al2mean = mean(cell2mat(region_results(:,8)));
                if max(al1mean,al2mean) > 60 & abs(al1mean - al2mean) > 40
                    feat_results = [feat_results; fval, al1mean, al2mean, numel(region_results(:,5))];
                end
            end
        end
        if size(feat_results,1) > 0
            [~,un,~] = unique(feat_results(:,1));
            feat_results = feat_results(un,:);
            [~,mm] = max(feat_results(:,2:3),[],2);
            B = zeros(size(feat_results(:,2:3)));
            B(sub2ind(size(B), 1:length(mm), mm')) = 1;
            t = bsxfun(@times, B, feat_results(:,1));
            mm_result = [mm_result; t];
        end
        [mr,mc] = size(mm_result);
        mm_results{1+i,1+j} = mat2cell(mm_result, ones(mr,1), ones(mc,1));
        
        [fr,fc] = size(feat_results);
        outr = mat2cell(feat_results, ones(fr,1), ones(fc,1));
        out_results{1+i,1+j} = outr;
    end
    
end
[gen_rules1, min_rules] = generalize_mm_results(mm_results,1);
%[gen_rules2, min_rules] = generalize_mm_results(mm_results,2);
%min_rules = [min_rules1; min_rules2];
%BN = buildbn(min_rules, ful_results, norm_results);
%bnet = buildbnfromdata(min_rules, ful_results, norm_results);
bnet = 0;
end

