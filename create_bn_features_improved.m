function [best_result] = create_bn_features_improved()
addpath(genpath( 'bnt/'));

bins = 0;
removal = 'false';
threshold = 70;
minmax = 1;
reduce = 4;
VOCinit;
[suitability, im_accumulators, rules, rows, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov,results, full_results, ful_results,norm_results, norm_results_s] = analyze_data_for_bn(bins, removal, threshold, minmax,reduce);
results = ful_results;
[r, c] = size(results);
t = c-9-7;
best_result = cell(1, t);
flabels_temp = [];
features = [];
for iter = 1:5
acc = 1;
    %for i = 8:(c-9)
    for i = 8:29
       if ~ismember(results{1,i}, features)
           [a, b, result, feature] = create_bn_features([features, results(1,i)], 0);           
           best_result{1,i-7} = result(1, 1:end); 
           d = best_result{1,i-7};
               if acc > d{1}
                  acc = d{1};
                  flabels_temp = feature;                      
               end  
        end
    end
    features = flabels_temp;
    features
    acc
end
end