function [bnet,engine,best_result,flabels] = svm_vs_bn_experiment()


%% Data preparation
p = '/home/kamila/Documents/';
addpath(genpath([p 'libsvm-3.20']));
addpath(genpath([p 'segbench/lib/matlab']));
addpath(genpath([p 'vlfeat-0.9.17/toolbox']));
addpath(genpath ([p 'VOCdevkit/VOCcode']));
rmpath([p 'vlfeat-0.9.17/toolbox/noprefix']);

addpath(genpath([p 'bnt/']));

for reduce = 3:7
    fnum = {'pca1,pca2,pca3,pca4,pca5'};
    flabels = strsplit(',',strjoin(fnum(:)',','));
    fnum = numel(flabels);
    best_result = cell(1,fnum+1);
    best_result{1,1} = 100;
    
    
    bins = 0;
    removal = 'false';
    threshold = 70;
    minmax = 1;
    reduce_att = reduce;
    %reduce = 4;
    VOCinit;
    
    [suitability, im_accumulators, rows,  ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov,results, full_results, ful_results,norm_results,norm_results_s, max_vals] = analyze_data_for_bn_pca(bins, removal, threshold, minmax,reduce_att);
    
    results = ful_results;
    results_cont = norm_results_s;
    
    %% Remove NaN from data
    [r,c] = size(results_cont)
    for i = 1:r*c
        if(isnan(results_cont{i}))
            results_cont{i}=0;
        end
    end
    
    %% Prepare data
    %%%%%%%%%%%%%%%%%%%%%%%%%prepare data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    findex = find(strcmp(results_cont(1,:), 'brightness 1'));
    ind_att = find(strcmp(results_cont(1,:), 'Area'));
    
    % flabels = results(1, findex:findex+5);
    % % flabels = strsplit(',',strjoin(fnum(:)',','));
    % fnum = numel(flabels);
    %
    %
    % best_result = cell(1,fnum+1);
    % best_result{1,1} = 100;
    
    
    f_data = results_cont(2:end, findex:(ind_att-1));
    att_data = results_cont(2:end, ind_att:end);
    sel_data = results(2:end,7);
    mid_data = cell(r-1,2);
    
    
    % for h = 1:size(att_data,1)
    %     for l = 1: size(att_data, 2)
    %         t{h, l} = mean(cell2mat(att_data(:, l)));
    %     end
    % end
    %
    %
    % att_data = t;
    %
    % att_data(1:2, 1:5)
    
    
    
    %  f_data_cl = [];
    %  for a=1:numel(flabels)
    %  	f_data_cl = [f_data_cl, results(2:end,find(strcmp(results(1,:),flabels(a))))];
    %  end
    f_data_cl = f_data;
    
    att_data_cl = results(2:end, ind_att:end);
    %att_data_cl = cell(size(att_data_cl,1), size(att_data_cl,2));
    
    
    sel_data_cl = results(2:end,7);
    
%    data = [f_data att_data mid_data sel_data];
%    data_cl = [f_data_cl att_data_cl mid_data sel_data_cl];
    data = [f_data mid_data sel_data];
    data_cl = [f_data_cl mid_data sel_data_cl];
    
    %%%%%%%%%
    
    sel_data_inc = data(:, end);
    
    B=cell2mat(data(:, 1:end-1));
    R=cov(B);
    [U,D]=eig(R);
    B=B*U;
    
    
    %% Data clustering (need to modified)
    pca_data = B(:, (end-fnum+1):(end));
    newdata = zeros(size(pca_data,1),size(pca_data,2));
    %reduce data to n bins
    if reduce > 0
        for i = 1:size(pca_data,2)
            d = pca_data(:,i);
            [~,dd] = histc(d,linspace(min(d), max(d), reduce));
            newdata(:,i) = dd;
        end
        pca_data = newdata;
    end
    
   % data = [mat2cell(pca_data, ones(size(pca_data, 1), 1), ones(1, size(pca_data, 2))) data(:,size(f_data,2): (size(f_data,2)+ size(att_data, 2)-1)) cell(size(data, 1),2) data(:, end)];
   % data_cl = [num2cell(pca_data) att_data_cl cell(size(data_cl, 1),2) sel_data_inc];
    
    %data = [mat2cell(pca_data, ones(size(pca_data, 1), 1), ones(1, size(pca_data, 2))) data(:,size(f_data,2): (size(f_data,2)+ size(att_data, 2)-1)) cell(size(data, 1),2) data(:, end)];
    data_cl = [num2cell(pca_data) cell(size(att_data_cl)) cell(size(data_cl, 1),2) sel_data_inc];
    
    %% Partition
    
    partition = cvpartition(cell2mat(data_cl(:,end)), 'holdout', 0.2);
    train_data = data_cl(partition.training,:)';
    test_data = data_cl(partition.test,:)';
    
    train_data(:,1:10)
    
    %% BN
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % The features used from min_rules
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    node_names = [flabels results(1,c-8:end)  {'featuresSuitability', 'attributesSuitability', 'suitability'}];
    node_vars = genvarname(node_names);
    node_sizes = zeros(1,numel(node_vars));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    for i = 1:numel(flabels)
        node_sizes(1,i) = reduce_att;
    end
    
    % add atributes
    for i = 1:numel(results(1,end-8:end))
        node_sizes(1,i+numel(flabels)) = max(cell2mat(results(2:end,end-9+i)));
    end
    
    node_sizes(1,end-2:end) = 3;
    node_sizes(1,end-1:end) = 3;
    node_sizes(1,end:end) = 3;
    % assign unique id to each node
    for i = numel(node_vars):-1:1
        eval([node_vars{i} ' = i;']);
    end
    
    %Create BN DAG
    N = numel(node_vars);
    dag = zeros(N,N);
    %specify their connectivity for feature nodes
    for i = 1:fnum
        dag(eval(node_vars{i}), eval(node_vars{numel(node_names)-1})) = 1;
    end
    %specify their connectivity for attribute nodes
    for i = fnum+1:N-3
        dag(eval(node_vars{i}), eval(node_vars{numel(node_names)-2})) = 1;
    end
    %Specify connecticity for the suitability nodes
    dag(eval(node_vars{end-2}), eval(node_vars{N})) = 1;
    dag(eval(node_vars{end-1}), eval(node_vars{N})) = 1;
    
    
    
    %% Create BN
    
    [rr,cc] = size(data_cl);
    bnet = mk_bnet(dag, node_sizes, 'names',  node_names);
    
    seed = 0;
    rand('state', seed);
    
    for i=1:numel(node_vars)
        bnet.CPD{eval(node_vars{i})} =  tabular_CPD(bnet, eval(node_vars{i}));
    end
    
    engine = jtree_inf_engine(bnet);
    [bnet, lltrace] = learn_params_em(engine,train_data,100,10);
    
    [tr,tc] = size(test_data)
    err = 0;
    for i=1:tc
        evidence = test_data(:,i);
        evidence{cc} = [];
        [engine, loglik] = enter_evidence(engine, evidence);
        marg = marginal_nodes(engine, eval(node_vars{N}));
        [row,col] = find(marg.T == max(marg.T(:)));
        
        if row ~= test_data{cc,i}
            err = err + 1;
        end
    end
    
    e = err/tc;
    
    if e < best_result{1,1}
        best_result{1,1} = e;
        best_result(1,2:end) = flabels;
    end
    
    sprintf('BN_error: %d', (err/tc))
    
    %% SVM
    %cvpart = cvpartition(cell2mat(sel_data_inc),'holdout',0.2);
    %Xtrain = data(training(cvpart),1:(end-1));
    %Ytrain = sel_data_inc(training(cvpart),:);
    %Xtest = data(test(cvpart),1:(end-1));
    %Ytest = sel_data_inc(test(cvpart),:);
    
    %model  = svmtrain(Ytrain, Xtrain, '-s 0 -c 128  -g 0.125');
    %predicted = svmpredict(Ytest, Xtest, model);
    
    %model = svmtrain(cell2mat(Xtrain),cell2mat(Ytrain),'kernel_function', 'rbf', 'rbf_sigma', 0.001);
    %predicted1 = svmclassify(model, cell2mat(Xtrain));
    %errRate1 = sum(cell2mat(Ytrain)~= predicted1)/size(cell2mat(Ytrain),1)
    %predicted = svmclassify(model, cell2mat(Xtest));
    %SVM_error = sum(cell2mat(Ytest)~= predicted)/size(cell2mat(Ytest),1) ;
    
    %sprintf('SVM_error: %d', SVM_error)
end
end


