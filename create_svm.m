function [best_result,flabels] = create_svm()
bins = 0;
removal = 'false';
threshold = 70;
minmax = 1;
reduce = 3;
VOCinit;

[suitability, im_accumulators, rows,  ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov,results, full_results, ful_results,norm_results,norm_results_s] = analyze_data_for_bn(bins, removal, threshold, minmax,reduce);
results = norm_results_s;


[r,c] = size(results);
findex = find(strcmp(results(1,:), 'brightness'));
ind_att = find(strcmp(results(1,:), 'Area'));
%prepare data
f_data = results(2:end, findex:(ind_att-1));
att_data = results(2:end, ind_att:end);

for h = 1:size(att_data,1)
    for l = 1: size(att_data, 2)
        t{h, l} = mean(cell2mat(f_data(:, l)));
    end
end


att_data = t;

att_data(1:2, 1:5)


sel_data = results(2:end,7);
mid_data = cell(r-1,2);
data = [f_data att_data mid_data sel_data];
data_no_att = [f_data  mid_data sel_data];

size(data)
size(data_no_att)

[rows coloms] = size(data)
data_ones = [];
data_ones_no_att = [];
for m = 1: rows    
    if cell2mat(data(m, end))==1
       data_ones = [data_ones; data(m, :)];
       data_ones_no_att = [data_ones_no_att; data_no_att(m, :)];
    end
end

% calculate oroportion of 1 and 2 in sel_data
[temp777 temp222] = hist(cell2mat(sel_data), unique(cell2mat(sel_data)));
temp777

% 
difference = temp777(2) - temp777(1)
for l = 1:difference
    coef = randi(temp777(1));
    data = [data; data_ones(coef, :)];
    data_no_att = [data_no_att; data_ones_no_att(coef, :)];
end



sel_data_inc = data(:, end);
sel_data_inc_no_att = data_no_att(:, end);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

B=cell2mat(data);
B_no_att = cell2mat(data_no_att);


B(:,end)=[];
B_no_att(:, end) = [];

R=cov(B);
[U,D]=eig(R);
B=B*U;

R_na=cov(B_no_att);
[U_na,D_na]=eig(R_na);
B_no_att=B_no_att*U_na;


cvpart = cvpartition(cell2mat(sel_data_inc),'holdout',0.2);
Xtrain = B(training(cvpart),(end-3):(end-1));
Ytrain = sel_data_inc(training(cvpart),:);
Xtest = B(test(cvpart),(end-3):(end-1));
Ytest = sel_data_inc(test(cvpart),:);

model = svmtrain((Xtrain),cell2mat(Ytrain),'kernel_function', 'rbf', 'rbf_sigma', 0.001);
predicted1 = svmclassify(model, (Xtrain));
errRate1 = sum(cell2mat(Ytrain)~= predicted1)/size(cell2mat(Ytrain),1) 
predicted = svmclassify(model, (Xtest));
errRate = sum(cell2mat(Ytest)~= predicted)/size(cell2mat(Ytest),1) 




cvpart_1 = cvpartition(cell2mat(sel_data_inc_no_att),'holdout',0.2);
Xtrain_1 = B_no_att(training(cvpart_1),(end-3):(end-1));
Ytrain_1 = sel_data_inc_no_att(training(cvpart_1),:);
Xtest = B_no_att(test(cvpart_1),(end-3):(end-1));
Ytest = sel_data_inc_no_att(test(cvpart_1),:);

model = svmtrain((Xtrain_1),cell2mat(Ytrain_1),'kernel_function', 'rbf', 'rbf_sigma', 0.001);
predicted1 = svmclassify(model, (Xtrain_1));
errRate2 = sum(cell2mat(Ytrain_1)~= predicted1)/size(cell2mat(Ytrain_1),1) 
predicted2 = svmclassify(model, (Xtest));
errRate3 = sum(cell2mat(Ytest)~= predicted2)/size(cell2mat(Ytest),1) 

% % % cvpart = cvpartition(cell2mat(sel_data_inc),'holdout',0.5);
% % % Xtrain = data(training(cvpart),1:end-1);
% % % Ytrain = sel_data_inc(training(cvpart),:);
% % % Xtest = data(test(cvpart),1:end-1);
% % % size(Xtrain)
% % % size(data)
% % % Ytest = sel_data_inc(test(cvpart),:);


% B=cell2mat(data);
% B(:,end)=[];
% 
% R=cov(B);
% [U,D]=eig(R);
% 
% B=B*U;
% 
% t=cell2mat(sel_data_inc);
% 
% I=find(t==1);
% 
% figure(5)
% plot(B(:,end-1),B(:,end-2),'g.')
% hold
% plot(B(I,end-1),B(I,end-2),'.')


% XX=cell2mat(Xtrain);
% YY=cell2mat(Ytrain);

%learn from all features
            %Matlab Svm
%            model = svmtrain(cell2mat(Xtrain),cell2mat(Ytrain),'kernel_function', 'rbf', 'rbf_sigma', 1);
%             predicted1 = svmclassify(model, cell2mat(Xtrain));
%            errRate1 = sum(cell2mat(Ytrain)~= predicted1)/size(cell2mat(Ytrain),1) 
%            predicted = svmclassify(model, cell2mat(Xtest));
%            errRate = sum(cell2mat(Ytest)~= predicted)/size(cell2mat(Ytest),1)         
%             %libsvm
%             model = svmtrain(Ytrain,Xtrain, '-s 1 -c 0.5 -n 0.0001');
%             predicted = svmpredict(Ytest, Xtest, model);
            %Matlab Boosting
%            t = ClassificationTree.template('minleaf',5);
%            ens = fitensemble(Xtrain,Ytrain,'AdaBoostM1',100,t,'LearnRate',0.1,'nprint',100);
%            predicted = predict(ens,Xtest);
%            errRate = sum(Ytest~= predicted)/size(Ytest)         

           
%learn from selected histograms
            %Matlab Svm
%            model = svmtrain(sub_treF,sub_treA);
%            predicted = svmclassify(model, sub_tesF);
            %libsvm
%            model = svmtrain(sub_treA,sub_treF, '-s 1 -c 0.5 -n 0.0001');
%            predicted = svmpredict(sub_tesA, sub_tesF, model);
            %Matlab Boosting
%            t = ClassificationTree.template('minleaf',5);
%            ens = fitensemble(sub_treF,sub_treA,'AdaBoostM1',1000,t,'LearnRate',0.1,'nprint',100);
%            predicted = predict(ens,sub_tesF);