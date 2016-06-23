%-- 02/12/2014 12:49:44 PM --%
cd codes/vision_algorithms/matlab/
[suitability, f_labels, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false');
cd Image_Understanding/
[suitability, f_labels, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false');
load ./data/nobins__reduced_false_evalresult.mat;
clear all
[suitability, f_labels, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false');
history
plot(plots(:,:,1,1,1)')
plot(plots(:,:,1,1,2)')
bar(plots(:,:,1,1,2)')
bar(plots(:,:,1,1,3)')
bar(plots(:,:,1,1,4)')
bar(plots(:,:,1,2,4)')
bar(plots(:,:,1,3,4)')
bar(plots(:,:,1,2,3)')
bar(plots(:,:,1,2,2)')
bar(plots(:,:,1,1,2)')
bar(plots(:,1:10,1,1,2)')
bar(plots(:,1:10,1,2,2)')
bar(plots(:,1:10,1,3,2)')
bar(plots(:,1:10,1,2,3)')
bar(plots(:,1:10,1,2,4)')
bar(plots(:,1:10,1,1,4)')
bar(plots(:,1:10,1,1,3)')
bar(plots(:,1:10,1,1,2)')
help cell
[suitability, f_labels, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false');
bar(plots(:,1:10,1,1,2)')
plots(1,1:10,1,1,2)
[suitability, f_labels, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false');
suit1 = suitability(:,:,1);
suit2 = suitability(:,:,2);
clear all
[suitability, f_labels, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false');
suit2 = suitability(:,:,2);
suit1 = suitability(:,:,1);
clear all
[suitability, f_labels, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false');
suit1 = suitability(:,:,1);
suit2 = suitability(:,:,2);
clear all
[suitability, f_labels, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false');
suit2 = suitability(:,:,2);
suit1 = suitability(:,:,1);
plot (suit1(16,2:end))
plot (cell2mat(suit1(16,2:end)))
plot (cell2mat(suit1(16,2:end))')
plot (cell2mat(suit1(16,2:end)))
bar (cell2mat(suit1(16,2:end)))
a = cell2mat(suit1(16,2:end));
clear all
[suitability, f_labels, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false');
suit1 = suitability(:,:,1);
suit2 = suitability(:,:,2);
bar (cell2mat(suit1(16,2:end)))
bar (cell2mat(suit2(16,2:end)))
legend(suit1(1,2:end));
legend('Person');
xlabel(suit1(1,2:end));
bar (cell2mat(suit2(16,2:end)))
xlabel(suit1(1,2:end));
bar (cell2mat(suit2(16,2:end)))
legend('Person');
set(gca,'XTickLabel',suit1(1,2:end))
set(gca,'XTick',1:1:100)
set(gca,'XTickLabel',suit1(1,2:end))
set(gca,'XTickLabel','')
bar (cell2mat(suit2(16,2:end)))
bar (cell2mat(suit2(16,2:11)))
legend('Person');
set(gca,'XTickLabel',suit1(1,2:11))
bar (cell2mat(suit2(16,2:20)))
legend('Person');
set(gca,'XTickLabel',suit1(1,2:20))
set(gca,'XTick',1:1:20)
bar (cell2mat(suit1(16,2:20)))
legend('Person');
set(gca,'XTick',1:1:20)
set(gca,'XTickLabel',suit2(1,2:20))
clear all
[suitability, f_labels, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false');
sui1 = suitability(:,:,1);
sui2 = suitability(:,:,2);
load ./data/nobins__reduced_false_evalresult.mat;
max(cell2mat(results(2:end,5)))
[a,b] = max(cell2mat(results(2:end,5)))
numel(cell2mat(results(2:end,5))>0)
numel(results(cell2mat(results(2:end,5))>0,5))
numel(results(cell2mat(results(2:end,5))>0.8,5))
numel(results(cell2mat(results(2:end,5))>1,5))
(results(cell2mat(results(2:end,5))>1,5))
(results(cell2mat(results(2:end,5)),5))
(results(cell2mat(results(2:end,5))>0,5))
cell2mat(results(2:end,5))>0
cell2mat(results(2:end,5))>0.8
%-- 02/17/2014 10:26:18 AM --%
cd codes/vision_algorithms/matlab/
cd Image_Understanding/
[suitability, f_labels, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false');
clear all
load_path = './data/';
load_path = [load_path 'nobins__reduced_false_evalresult.mat']
load load_path;
load(load_path);
only_data = results(2:end,:);
a =  cell2mat(results(:,6))> 80;
a =  cell2mat(only_data(:,6))> 80;
a =  only_data(cell2mat(only_data(:,6))> 80, :);
a =  only_data(cell2mat(only_data(:,5))> 80, :);
[suitability, f_labels, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', .8);
suit1 = suitability(:,:,1);
suit2 = suitability(:,:,2);
bar (cell2mat(suit1(16,2:end)))
bar (cell2mat(suit2(16,2:end)))
[suitability, f_labels, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', .8);
[suitability, f_labels, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', .8);
suit2 = suitability(:,:,2);
bar (cell2mat(suit2(16,2:end)))
[suitability, f_labels, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', .8);
clear all
[suitability, f_labels, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', .8);
im_accumulators{1,1,1,1}
size(im_accumulators)
im_accumulators{1,1,1:2,1:2}
im_accumulators{1,1,1,1}
im_accumulators{1,1,1,2}
im_accumulators{1,1,1,3}
im_accumulators{1,1,1,4}
im_accumulators{1,1,2,1}
im_accumulators{1,1,3,1}
im_accumulators{2,1,3,1}
im_accumulators{3,1,3,1}
im_accumulators{2,2,3,1}
im_accumulators{2,3,3,1}
im_accumulators{2,4,3,1}
im_accumulators{2,5,3,1}
im_accumulators{2,1,2,1}
im_accumulators{2,1,5,1}
a = im_accumulators{1,1,1,1};
a = im_accumulators{1,2,1,1};
a = im_accumulators{1,3,1,1};
a = im_accumulators{1,5,1,1};
[suitability, f_labels, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', .8);
im_accumulators(:,:,1,2)
im_accumulators{:,:,1,2}
im_accumulators{1,1,1,2}
size(im_accumulators)
im_accumulators{1,1,1,1}
im_accumulators{1,2,1,1}
size(im_accumulators)
im_accumulators{1,1}
im_accumulators{1,2}
im_accumulators{1,3}
im_accumulators{1,4}
size(im_accumulators)
size(im_accumulators(1,1))
size(im_accumulators{1,1})
size(im_accumulators{1,2})
size(im_accumulators{1,3})
size(im_accumulators{1,4})
size(im_accumulators{1,5})
size(im_accumulators{1,30})
size(im_accumulators{1,500})
size(im_accumulators{1,4})
size(im_accumulators{2,4})
size(im_accumulators{4,4})
size(im_accumulators{2,4})
im_accumulators{1,4}
im_accumulators{1,3}
im_accumulators{1,2}
im_accumulators{1,1}
im_accumulators{2,1}
im_accumulators{2,2}
im_accumulators{2,3}
im_accumulators{2,4}
im_accumulators{2,5}
im_accumulators{2,6}
[suitability, f_labels, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', .8);
im_accumulators{2,6}
[suitability, f_labels, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', .8);
im_accumulators{1,1,1,1}
im_accumulators{1,1}
im_accumulators{1,1,1}
im_accumulators(1,1,1)
im_accumulators(1,1)
im_accumulators(1,1,1,1)
im_accumulators(1,1,4,1)
im_accumulators(1,1,1,1)
im_accumulators(1,5,1,1)
im_accumulators(1,1,1,5)
im_accumulators(1,1,1)
a  = im_accumulators{1,1};
a{1,1}
[suitability, f_labels, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', .8);
a{1,1}
im_accumulators{1,1}
im_accumulators{1,1,10,10}
im_accumulators(1,1)
im_accumulators{1,1}{1}
im_accumulators{1,1}{1,2}
[suitability, f_labels, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', .8);
im_accumulators{1,1}{1,2}
im_accumulators{1,1}{13,2}
im_accumulators{1,1}
im_accumulators{1,2}
im_accumulators{1,3}
im_accumulators{1,4}
im_accumulators{2,1}
im_accumulators{1,3}
im_accumulators{1,2}
load_path = './data/';
load_path = [load_path 'nobins__reduced_false_evalresult.mat']
load(load_path);
[suitability, f_labels, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', .8);
im_accumulators{1,2}
im_accumulators{1,1}
im_accumulators{1,3}
im_accumulators{1,4}
im_accumulators{1,1}
im_accumulators{1,1}{2,3}
b = results(results(:,1) ==im_accumulators{1,1}{2,3}{:,1})
b = results(strcmp(results(:,1),im_accumulators{1,1}{2,3}{:,1}))
help strcmp
b = results(ismember(results(:,1),im_accumulators{1,1}{2,3}{:,1}))
help ismember
b = results(ismember(results(:,1),im_accumulators{1,1}{2,3}{:,1}),:)
ismember(results(:,1),im_accumulators{1,1}{2,3}{:,1}
ismember(results(:,1),im_accumulators{1,1}{2,3}{:,1})
ismember(results(:,1),(im_accumulators{1,1}{2,3}{:,1}))
im_accumulators{1,1}{2,3}{:,1}
ismember(results(:,1),[im_accumulators{1,1}{2,3}{:,1}])
ismember(results(:,1),[im_accumulators{1,1}{2,3}{:,1}] & results(:,2),[im_accumulators{1,1}{2,3}{:,2}])
ismember(results(:,1),[im_accumulators{1,1}{2,3}{:,1}]) & ismember(results(:,2),[im_accumulators{1,1}{2,3}{:,2}])
results(ismember(results(:,1),[im_accumulators{1,1}{2,3}{:,1}]) & ismember(results(:,2),[im_accumulators{1,1}{2,3}{:,2}]));
b = results(ismember(results(:,1),[im_accumulators{1,1}{2,3}{:,1}]) & ismember(results(:,2),[im_accumulators{1,1}{2,3}{:,2}]));
b = results(ismember(results(:,1),[im_accumulators{1,1}{2,3}{:,1}]) & ismember(results(:,2),[im_accumulators{1,1}{2,3}{:,2}]),:);
im_accumulators{1,1}{2,3}{:,2}
b = results((ismember(results(:,1),[im_accumulators{1,1}{2,3}{:,1}]) & ismember(results(:,2),[im_accumulators{1,1}{2,3}{:,2}])),:);
(ismember(results(:,1),[im_accumulators{1,1}{2,3}{:,1}]) & ismember(results(:,2),[im_accumulators{1,1}{2,3}{:,2}]))
(ismember(results(:,1),[im_accumulators{1,1}{2,3}{:,1}]) & ismember(results(:,2),[im_accumulators{1,1}{2,3}{:,2}])) > 0
( ismember(results(:,2),[im_accumulators{1,1}{2,3}{:,2}])) > 0
( ismember(results(:,2),[im_accumulators{1,1}{2,3}{:,2}]))
b = results((ismember(results(:,2),[im_accumulators{1,1}{2,3}{:,2}])),:);
b > 0
b
b = results((ismember(results(:,1),[im_accumulators{1,1}{2,3}{:,1}])),:);
b
[im_accumulators{1,1}{2,3}{:,1}]
[im_accumulators{1,1}{2,3}{:,2}]
[im_accumulators{1,1}{2,3}{:,2} ]
[im_accumulators{1,1}{2,3} {:,2} ]
[im_accumulators{1,1}{2,3}(:,2)]
(ismember(results(:,1),[im_accumulators{1,1}{2,3}(:,1)]) & ismember(results(:,2),[im_accumulators{1,1}{2,3}(:,2)])) > 0
b = results(ismember(results(:,1),[im_accumulators{1,1}{2,3}(:,1)]) & ismember(results(:,2),[im_accumulators{1,1}{2,3}(:,2)])),:);
b = results(ismember(results(:,1),[im_accumulators{1,1}{2,3}(:,1)]) & ismember(results(:,2),[im_accumulators{1,1}{2,3}(:,2)]),:);
[suitability, f_labels, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', .8);
only_data = results(2:end,:);
only_data = only_data(cell2mat(only_data(:,5))> threshold, :);
only_data = only_data(cell2mat(only_data(:,5))> 0.8, :);
[suitability, f_labels, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', .8);
[suitability, f_labels, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 0.8);
[suitability, f_labels, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 80);
[suitability, f_labels, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 40);
[suitability, f_labels, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 60);
[suitability, f_labels, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
clear all
[suitability, f_labels, im_accumulators, only_data, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
[suitability, f_labels, im_accumulators, only_data, all_data, obj_data, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
ixes = all_data(:,1) = 10;
ixes = all_data(:,1) == 10;
ixes = all_data(:,1) == 15;
obj_data = all_data(ixes,:);
[suitability, f_labels, im_accumulators, only_data, all_data, obj_data, all_images, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
ixes = all_data(:,1) = 10;
ixes = all_data(:,1) == 15;
obj_data = all_data(ixes,:);
obj_names = all_images(idxes,:);
obj_names = all_images(ixes,:);
load_path = './data/';
load_path = [load_path 'nobins__reduced_false_evalresult.mat']
load(load_path);
f_select = obj_data(:,7);
mx = max(f_select);
mn = min(f_select);
steps = linspace(mn,mx,num_of_steps);
step_ent = zeros(1,numel(steps)-1);
step_per = zeros(1,numel(algos));
steps = linspace(mn,mx,4);
step_ent = zeros(1,numel(steps)-1);
step_per = zeros(1,numel(algos));
[suitability, f_labels, im_accumulators, only_data, all_data, obj_data, all_images, only_numeric, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
ixes = all_data(:,1) == 15;
obj_data = all_data(ixes,:);
obj_names = all_images(idxes,:);
obj_names = all_images(ixes,:);
f_select = obj_data(:,7);mx = max(f_select); mn = min(f_select);
algos = unique(only_numeric(:,1));
steps = linspace(mn,mx,4); step_ent = zeros(1,numel(steps)-1);step_per = zeros(1,numel(algos));
steps
sel = f_select <= steps(1);
sel = f_select > steps(1);
sel = f_select <= steps(1);
sel = f_select <= steps(2);
sel = f_select <= steps(1);
algos_mix = obj_data(sel,5);
binranges = unique(algos_mix);
algos_names = obj_names(obj_data(:,5) == algos_mix(1),:);
algos_names = obj_names(obj_data(:,5) == algos_mix(2),:);
algos_mix(1)
algos_mix(2)
algos_mix
clear all
[suitability, f_labels, im_accumulators, only_data, all_data, obj_data, all_images, only_numeric, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
suit1 = suitability(:,:,1);
suit2 = suitability(:,:,2);
bar (cell2mat(suit1(16,2:end)))
bar (cell2mat(suit2(16,2:end)))
bar (cell2mat(suit2(15,2:end)))
bar (cell2mat(suit1(15,2:end)))
bar (cell2mat(suit1(14,2:end)))
bar (cell2mat(suit2(14,2:end)))
bar (cell2mat(suit1(13,2:end)))
bar (cell2mat(suit1(12,2:end)))
bar (cell2mat(suit1(1,2:end)))
bar (cell2mat(suit2(1,2:end)))
cell2mat(suit2(1,2:end))
bar (cell2mat(suit2(2,2:end)))
bar (cell2mat(suit1(2,2:end)))
numel(im_accumulators)
size(im_accumulators)
im_accumulators{1,1}{2,2}
im_accumulators{1,1}{2,2}(:,1:2)
[im_accumulators{1,1}{2,2}(:,1:2)]
x = [strcat(im_accumulators{1,1}{2,2}(:,1), {'_'}, im_accumulators{1,1}{2,2}(:,2))]
x = [strcat(im_accumulators{1,1}{2,2}(:,1), {'_'}, im_accumulators{1,1}{2,2}(:,2)), {'.png'}]
x = [strcat(im_accumulators{1,1}{2,2}(:,1), {'_'}, im_accumulators{1,1}{2,2}(:,2), {'.png'})]
numel(x)
[suitability, f_labels, im_accumulators, only_data, all_data, obj_data, all_images, only_numeric, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
m = im_accumulators{1,1};
m
m{1,1}
[suitability, f_labels, im_accumulators, only_data, all_data, obj_data, all_images, only_numeric, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
m = im_accumulators{1,1};
m{1,1}
m{2,2}
x = strcat(m{2,2}(:,1), {'_'}, m{2,2}(:,2), {'.jpg'});
save_path = sprintf(spath, i,j,m{1,l},m{k,1})
spath = 'Algorithm_%d_Range_%d_Feature_%s_Object_%s';
save_path = sprintf(spath, i,j,m{1,l},m{k,1})
save_path = sprintf(spath, i,j,m{1,2},m{2,1})
m{1,2}
m{2,1}
[suitability, f_labels, im_accumulators, only_data, all_data, obj_data, all_images, only_numeric, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
m
m = im_accumulators{1,1};
x = m{2,3}
x = m{2,4}
x = m{2,5}
size(x)
[suitability, f_labels, im_accumulators, only_data, all_data, obj_data, all_images, only_numeric, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
x{1}
x
x = strcat(m{2,2}(:,1), {'_'}, m{2,2}(:,2), {'.jpg'});
x
x{1}
[suitability, f_labels, im_accumulators, only_data, all_data, obj_data, all_images, only_numeric, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
x = im_accumulators{1,1};
size(x)
x
x{2,5}
x{1,1}
[suitability, f_labels, im_accumulators, only_data, all_data, obj_data, all_images, only_numeric, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
x = im_accumulators{1,1};
x{2,3}
size(x{2,3})
size(x{3,2})
x{3,2}
size(x)
x(3,2)
[suitability, f_labels, im_accumulators, only_data, all_data, obj_data, all_images, only_numeric, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
ls data/
ls data/Results/
[suitability, f_labels, im_accumulators, only_data, all_data, obj_data, all_images, only_numeric, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
%-- 02/24/2014 01:23:46 PM --%
userpath
%-- 02/24/2014 01:32:12 PM --%
[suitability, f_labels, im_accumulators, only_data, all_data, obj_data, all_images, only_numeric, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
cd Image_Understanding/
[suitability, f_labels, im_accumulators, only_data, all_data, obj_data, all_images, only_numeric, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
[suitability, im_accumulators, obj_data, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
clear all
[suitability, im_accumulators, obj_data, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
[suitability, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
im_accumulators{1,1}{2,2}
im_accumulators{1,1}{2,2}{1}
im_accumulators{1,1}{2,2}(1:2)
im_accumulators{1,1}{2,2}(1,1:2)
im_accumulators{1,2}{2,2}(1,1:2)
im_accumulators{1,3}{2,2}(1,1:2)
im_accumulators{1,2}{2,2}(1,1:2)
im_accumulators{2,2}{2,2}(1,1:2)
im_accumulators{2,1}{2,2}(1,1:2)
%-- 03/03/2014 10:27:57 PM --%
%-- 03/04/2014 11:41:53 AM --%
cd Image_Understanding/
[suitability, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
im_accumulators{2,1}{2,2}(1,1:2)
im_accumulators{1,1}{2,2}(1,1:2)
im_accumulators{1,2}{2,2}(1,1:2)
im_accumulators{1,3}{2,2}(1,1:2)
im_accumulators{3,2}{2,2}(1,1:2)
im_accumulators{1,2}{2,2}(1,1:2)
im_accumulators{1,3}{2,2}(1,1:2)
im_accumulators
im_accumulators{1,1}
im_accumulators{1,4}
im_accumulators{1,2}
im_accumulators{1,3}
im_accumulators{1,3}{2,2}(1,1:2)
im_accumulators{1,2}{2,2}(1,1:2)
im_accumulators{1,1}{2,2}(1,1:2)
im_accumulators{2,1}{2,2}(1,1:2)
im_accumulators{2,2}{2,2}(1,1:2)
im_accumulators{2,3}{2,2}(1,1:2)
[suitability, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
load_path = './data/';
load_path = [load_path 'nobins__reduce_false_evalresult.mat']
load (load_path, 'results');
ls data
load (load_path, 'results');
load_path = [load_path 'nobins__reduced_false_evalresult.mat']
load (load_path, 'results');
load_path = [load_path 'nobins__reduced_false_evalresult.mat']
load_path = ['./data/nobins__reduced_false_evalresult.mat']
load_path = [load_path 'nobins__reduced_false_evalresult.mat']
only_data = results(2:end,:);
load (load_path, 'results');
load_path = ['./data/nobins__reduced_false_evalresult.mat']
load (load_path, 'results');
only_data = results(2:end,:);
only_numeric = cell2mat(only_data(:,7:end));
algos = unique(only_numeric(:,1));
f_labels = labels(1,8:end);
idxes = all_data(:,1) == 15;
all_data = cell2mat(only_data(:,3:end));
VOCinit;
for i=1:VOCopts.nclasses
only_data(strcmp(only_data(:,3),VOCopts.classes{i}),3) = {i};
end
all_data = cell2mat(only_data(:,3:end));
idxes = all_data(:,1) == 15;
obj_data = all_data(idxes,:);
all_images = only_data(:,1:7);
obj_names = all_images(idxes,:);
f_select = obj_data(:,5+1);
mn = min(f_select);
mx = max(f_select);
steps = linspace(mn,mx,num_of_steps);
steps = linspace(mn,mx,4)
sel = f_select > 1 & f_select <= 4;
algos_mix = obj_data(sel,5);
binranges = unique(algos_mix);
binranges = unique(algos_mix)
algos_names = obj_names(obj_data(:,5) == binranges(1),:);
algos_names = obj_names(obj_data(:,5) == binranges(2),:);
only_data = only_data(cell2mat(only_data(:,5))> 0.7, :);
only_data = only_data(cell2mat(only_data(:,5))> 70, :);
algos_names = obj_names(obj_data(:,5) == binranges(1),:)
only_numeric = cell2mat(only_data(:,7:end));
all_data = cell2mat(only_data(:,3:end));
all_images = only_data(:,1:7);
idxes = all_data(:,1) == i;
obj_data = all_data(idxes,:);
obj_names = all_images(idxes,:);
idxes = all_data(:,1) == 1;
obj_data = all_data(idxes,:);
obj_names = all_images(idxes,:);
binranges(1)
binranges(2)
binranges(3)
f_select = obj_data(:,5+3);
mn = min(f_select);
mx = max(f_select);
steps = linspace(mn,mx,num_of_steps)
steps = linspace(mn,mx,4)
sel = f_select > steps(1) & f_select <= steps(2);
algos_mix = obj_data(sel,5);
binranges = unique(algos_mix);
algos_names = obj_names(obj_data(:,5) == binranges(1),:)
sel = f_select > steps(2) & f_select <= steps(3);
algos_mix = obj_data(sel,5);
algos_names = obj_names(obj_data(:,5) == binranges(1),:)
f_select
steps(3)
steps(2)
steps(1)
sel = f_select > steps(2) & f_select <= steps(3)
sel = f_select > steps(1) & f_select <= steps(2)
algos_mix = obj_data(sel,5)
sel = f_select > steps(2) & f_select <= steps(3);
algos_mix = obj_data(sel,5)
algos_names = obj_names(obj_data(:,5),:)
algos_names = obj_names(sel,:)
sel = f_select > steps(1) & f_select <= steps(2);
algos_names = obj_names(sel,:)
algos_names = obj_data(sel,:)
algos_names = obj_data(sel,:);
algos_names = obj_data(sel,:)
algos_names = obj_names(sel,:)
sel = f_select > steps(2) & f_select <= steps(3);
algos_names = obj_names(sel,:)
algos_names = obj_data(sel,:);
algos_names = obj_names(obj_data(:,5) == binranges(1),:)
algos_names = obj_names(obj_data(:,5) == binranges(2),:)
algos_names = obj_names(obj_data(:,5) == binranges(1),:)
sel = f_select > steps(1) & f_select <= steps(2);
algos_names = obj_data(sel,:);
algos_names = obj_names(obj_data(:,5) == binranges(1),:)
obj_names
[suitability, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
algos_name_mix == binranges(o)
[suitability, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
clear all
[suitability, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
clear all
[suitability, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
suit2 = suitability(:,:,2);
suit1 = suitability(:,:,1);
bar (cell2mat(suit1(16,2:end)))
bar (cell2mat(suit1(1,2:end)))
bar (cell2mat(suit1(2,2:end)))
bar (cell2mat(suit1(3,2:end)))
bar (cell2mat(suit1(4,2:end)))
bar (cell2mat(suit2(16,2:end)))
bar (cell2mat(suit1(16,2:end)))
[suitability, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 0);
suit2 = suitability(:,:,2);
suit1 = suitability(:,:,1);
bar (cell2mat(suit1(16,2:end)))
bar (cell2mat(suit2(16,2:end)))
bar (cell2mat(suit2(1,2:end)))
bar (cell2mat(suit2(2,2:end)))
[suitability, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
suit1 = suitability(:,:,1);
suit2 = suitability(:,:,2);
bar (cell2mat(suit2(16,2:end)))
bar (cell2mat(suit1(16,2:end)))
push
ll
im_accumulators{1,1}{5,2}
im_accumulators{1,1}{5,2}{1,1}
im_accumulators{1,1}{5,2}(:,1:2)
im_accumulators{1,1}{5,2}(:,1)im_accumulators{1,1}{5,2}(:,2)
strcat(im_accumulators{1,1}{5,2}(:,1),im_accumulators{1,1}{5,2}(:,2))
[suitability, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
help save
[suitability, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
strcat(im_accumulators{1,1}{5,2}(:,1),im_accumulators{1,1}{5,2}(:,2))
im_accumulators{1,1}{5,2}
[suitability, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
im_accumulators{1,1}{2,2}
im_accumulators{1,1}{1,1}
[suitability, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
help isempty
a = []
a = {}
isempty(a)
a = []
isempty(a)
[suitability, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
help unique
a = [r d f c]
a = {'r', 'd', 'f', 'c'}
unique(a)
[suitability, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
clear all
[suitability, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
output_path = './data/analysis_output/';
load ./data/nobins__reduced_false_evalresult.mat;
outvar = ['nobins__reduced_false_evalresult'];
load([output_path 'im_accumulators_' outvar '.mat'], 'im_accumulators');
[suitability, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
clear all
a = {'a', 'b','c'}
b = {'o', 'R', 't'}
c = [a,b]
unique(c)
c = {a,b}
unique(c)
unique(c(:))
c
c(:)
c(:,:)
c{1}
class{c{1}}
c{1}
c{:}
[c{:}]
unique[c{:}]
unique([c{:}])
[suitability, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
c
d = [c,a,b]
d = [c,{a},{b}]
d(:)
d(:,:)
[d]
[[d]]
[[d](:)]
d(:,:)
[[d]]
[[d]]{1}
[d]
[d{1}]
[d{:}]
[suitability, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
[d{}]
[d{:,:}]
unique([d{:,:}])
[suitability, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
d{:,:}
[suitability, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
d
d{:}
a = {'a', 'b'}
d = [c,{a},{b}]
d{:}
[d{:}]
[suitability, im_accumulators, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
[suitability, im_accumulators, data, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
size(data)
data{:}
[data{:}]
[suitability, im_accumulators, data, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
data{:}
[data{:}]
a =data{:};
a
data(:)
data(:){:}
data{:}
data{}
data
a
d
a = {'a', 'b'; 'e', 'f'}
d = [c,{a},{b}]
[data{:}]
cell2mat(data)
cell2mat(data{:})
hell cellfun
help cellfun
D
d
cellfun([], d)
d{:}
d{2}
cellfun(@[], d)
cellfun(@unique, d)
cellfun
cellfun(@unique, d, 'UniformOutput' 'false')
cellfun(@unique, d, 'UniformOutput', 'false')
cellfun(@unique, d, 'UniformOutput', 0)
f = cellfun(@unique, d, 'UniformOutput', 0)
f{:}
d{:}
f = cellfun(@unique, d, 'UniformOutput', 0)'
f = cellfun(@unique', d, 'UniformOutput', 0)'
f = cellfun(@unique, d, 'UniformOutput', 0)
f{a}
f{1}
f{3}
size(d)
size(a)
size(b)
size(d)
d
size(a)
a
[suitability, im_accumulators, data, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
data
[data]
[data{:}]
d
[data']
[suitability, im_accumulators, data, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
data
data{1,3]
data{1,3}
data{1,3}'
size(data{,3})
size(data{1,3})
size(data{1,3}')
[suitability, im_accumulators, data, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
data
unique(data)
unique(data{:})
unique(data(:))
a = [2, 4, 5, 7]
binranges = a;
histc(a,binranges)
a = [2, 4, 5, 4]
histc(a,binranges)
a = [2, 4, 5, 0]
histc(a,binranges)
[suitability, im_accumulators, data, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
binranges = [2008012221
2010010392]
rec = 2008012221
histc(rec,binranges)
binranges
binranges(1)
binranges = [2008012221, 2010010392]
histc(rec,binranges)
rec = 2008012221
histc(rec,binranges)
[suitability, im_accumulators, data, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
binranges = ['2008012221','2010010392']
binranges = {'2008012221','2010010392'}
cell2mat(binranges)
binranges = {'2008012221','2010010392'}'
cell2mat(binranges)
[suitability, im_accumulators, data, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
binranges
cell2mat(binranges)
histc(rec,binranges)
histc(rec,cell2mat(binranges))
histc(rec,cell2mat(binranges)')
b = cell2mat(binranges)
b = double(cell2mat(binranges))
b = str2double(cell2mat(binranges))
b = str2num(cell2mat(binranges))
histc(rec,str2num(cell2mat(binranges)))
[suitability, im_accumulators, data, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
histc(rec,str2num(cell2mat(binranges)))
[suitability, im_accumulators, data, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
clear all
[suitability, im_accumulators, data, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
a = im_accumulators{1,1};
a{2,1}
a{3,1}
[suitability, im_accumulators, data, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
The\ Swhelp sum
help sum
[suitability, im_accumulators, data, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
load_path = './data/';
outvar = ['nobins__reduced_false_evalresult'];
load_path = [load_path outvar '.mat']
load (load_path, 'results');
help mat2cell
[suitability, im_accumulators, data, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
ones(1,10)
[ones(1,10)]
[suitability, im_accumulators, data, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
[suitability, im_accumulators, rules, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
[suitability, im_accumulators, rules, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 50);
clear all
[suitability, im_accumulators, rules, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 50);
plot(rules{1,1}(4,2:end))
plot(str2num(rules{1,1}(4,2:end)))
plot(cell2mat(rules{1,1}(4,2:end))
plot(cell2mat(rules{1,1}(4,2:end)))
plot(cell2mat(rules{1,1}(5,2:end)))
plot(cell2mat(rules{1,1}(2,2:end)))
plot(cell2mat(rules{1,3}(2,2:end)))
plot(cell2mat(rules{1,3}(3,2:end)))
[suitability, im_accumulators, rules, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 0);
size(rules{1,1})
[suitability, im_accumulators, rules, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 0);
%-- 03/07/2014 10:34:08 AM --%
cd Image_Understanding/
[suitability, im_accumulators, rules, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 0);
[suitability, im_accumulators, rules, rows, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 0);
help mean
mean([0,5 0.5 1])
[suitability, im_accumulators, rules, rows, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 0);
plot(rows(1,:))
plot(rows(5,:))
plot(rows(6,:))
plot(rows(11,:))
plot(rows(11,1:60))
plot(rows(31,1:60))
plot(rows(31,1:40))
plot(rows(32,1:40))
plot(rows(31,1:40))
x = linspace(1,40,40)
plot(x, rows(31,1:40), x, rows(32,1:40))
legend
legend('STD', 'Mean')
[suitability, im_accumulators, rules, rows, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 70);
plot(x, rows(31,1:40), x, rows(32,1:40))
[suitability, im_accumulators, rules, rows, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 0);
help |
[suitability, im_accumulators, rules, rows, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 0);
size(im_accumulators{1,1}{2,2}
size(im_accumulators{1,1}{2,2})
[suitability, im_accumulators, rules, rows, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 35);
plot(rows(31,1:40))
[suitability, im_accumulators, rules, rows, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 35);
output_path = './Image_Understanding/data/';
load([output_path 'Features_Hypothesis_Regions_Mapping_BN_NOBINS_reduced_false.mat'], 'mapping');
size(mapping)
99-6
size(mapping(:,6:end)
size(mapping(:,6:end))
[results] = evaluate_data_for_bn_bb_full(0, 'false')
r = results(results(:,4) == 1,:)
r = results(cell2num(results(2:end,4)) == 1,:)
help cell2num
r = results(cell2mat(results(2:end,4)) == 1,:)
r = results(cell2mat(results(2:end,7)) == 1,:)
r = results(cell2mat(results(2:end,4)) > 0,:)
r = cell2mat(results(2:end,4)) > 0
results_data = results(2:end,:);
r = results_data(cell2mat(results_data(:,4)) > 0,:);
r = results_data(cell2mat(results_data(:,7)) > 0,:);
r = results_data(cell2mat(results_data(:,4)) > 0,:);
r = results_data(cell2mat(results_data(:,7)) == 1,:);
r = results_data(cell2mat(results_data(:,4)) > 0,:);
r = results_data(cell2mat(results_data(:,7)) > 0,:);
r = results_data(cell2mat(results_data(:,7)) <1,:);
a = cell2mat(results_data(:,7)) > 0;
a = cell2mat(results_data(:,7));
[results] = evaluate_data_for_bn_bb_full(0, 'false')
[results] = evaluate_data_for_bn_bb_full(0, 'false');
results_data = results(2:end,:);
r = results_data(cell2mat(results_data(:,4)) > 0,:);
r = results_data(cell2mat(results_data(:,7)) > 0,:);
r = results_data(cell2mat(results_data(:,7)) > 0 & cell2mat(results_data(:,4)) < 1,:);
r = results_data(cell2mat(results_data(:,4)) > 0 & cell2mat(results_data(:,7)) < 1,:);
which sortrows
sortrows
help sortrows
rr = sortrows(r, 11);
rr = sortrows(r, 3);
[results] = evaluate_data_for_bn_bb_full(0, 'false', 1);
ls ./Image_Understanding/data/JPEGImages/2007_010032.jpg'
ls './Image_Understanding/data/JPEGImages/2007_010032.jpg'
[results] = evaluate_data_for_bn_bb_full(0, 'false', 1);
help copyfile
copyfile('./Image_Understanding/data/JPEGImages/2007_010032.jpg', './Image_Understanding/data/best_analysis/Algorithm_1/Object_aeroplane/')
clear all
[results] = evaluate_data_for_bn_bb_full(0, 'false', 1);
strcat('./Image_Understanding/data/JPEGImages/2007_010032.jpg')
[results] = evaluate_data_for_bn_bb_full(0, 'false', 1);
cell2mat(binranges)
soo
c
%-- 03/10/2014 06:08:49 PM --%
[results] = evaluate_data_for_bn_bb_full(0, 'false', 1);
%-- 03/10/2014 06:12:04 PM --%
[results] = evaluate_data_for_bn_bb_full(0, 'false', 1);
VOCinit
VOCopts.classes
find(strcmp(VOCopts.classes, 'cow'))
find(strcmp(VOCopts.classes(:), 'cow'))
final_result{1:VOCopts.nclasses}] = deal([]);
final_result{1:VOCopts.nclasses} = deal([]);
final_result(1:VOCopts.nclasses) = deal([]);
[final_result{1:VOCopts.nclasses}] = deal([]);
[final_result{1:VOCopts.nclasses}] = deal({});
help repmat
[final_result{1:VOCopts.nclasses}] = repmat([],VOCopts.classes);
final_result = repmat([],VOCopts.classes);
final_result = repmat(cell(1,104),VOCopts.classes);
help strcmp
[final_result{1:VOCopts.nclasses}] = repmat([],VOCopts.classes);
[results] = evaluate_data_for_bn_bb_full(0, 'false', 1);
help  save
[results] = evaluate_data_for_bn_bb_full(0, 'false', 1);
load ./Image_Understanding/data/best_analysis/Algorithm_2/Object_tvmonitor/features.mat;
plot_data = cell2mat(results(:,11:end);
plot_data = cell2mat(results(:,11:end));
size (plot_data)
plot(plot_data);
plot(plot_data');
figure;
load ./Image_Understanding/data/best_analysis/Algorithm_1/Object_tvmonitor/features.mat;
plot(plot_data');
figure;
plot_data = cell2mat(results(:,11:end));
plot(plot_data');
size(plot_data)
clear all
load ./Image_Understanding/data/best_analysis/Algorithm_1/Object_cow/features.mat;
plot_data = cell2mat(results(:,11:end));
plot(plot_data');
figure
load ./Image_Understanding/data/best_analysis/Algorithm_2/Object_cow/features.mat;
plot_data = cell2mat(results(:,11:end));
plot(plot_data');
no
[results] = evaluate_data_for_bn_bb_full(0, 'false', 50);
load ./Image_Understanding/data/best_analysis_50/Algorithm_2/Object_cow/features.mat;
clear all
load ./Image_Understanding/data/best_analysis_50/Algorithm_2/Object_cow/features.mat;
plot_data = cell2mat(results(:,11:end));
plot(plot_data');
figure
load ./Image_Understanding/data/best_analysis_50/Algorithm_1/Object_cow/features.mat;
plot_data = cell2mat(results(:,11:end));
plot(plot_data');
which test
help test
pwd
compile
open features
features
features --help
help features
load('VOC2007/car_final');
help repmat
Detect_Dir('.')
Detect_Dir()
ls VOC2010/
Detect_Dir()
Detect_Dir('/mnt/images/2/VOC2012/Regions/')
ls './Recognition/voc_release5/VOC2010/aeroplane_final.mat'
ls './Recognition/voc_release5/VOC2010/'
ls './Recognition/voc_release5/'
ls './Recognition/'
Detect_Dir('/mnt/images/2/VOC2012/Regions/')
open startup
Detect_Dir('/mnt/images/2/VOC2012/Regions/')
models = Detect_Dir('/mnt/images/2/VOC2012/Regions/');
models{1,1}
models{1,1}(1,1)
models{1,1}
model
models{1,1}{1,1}
models{1,1}(1,1)
models{1,1}.model
models = Detect_Dir('/mnt/images/2/VOC2012/Regions/');
%-- 03/18/2014 12:10:11 PM --%
pwd
%-- 03/19/2014 10:35:21 AM --%
VOCinit
VOCopts
[results] = evaluate_data_from_full_img_to_bb_full(0, 'false', 50);
generate_data_for_bn_testing_bb_whole_images(  );
which VOCinit
open /home/nabhoth/codes/vision_algorithms/VOCdevkit/VOCcode/VOCinit.m
ls /home/nabhoth/codes/vision_algorithms/VOCdevkit/VOCcode/
ls /home/nabhoth/codes/vision_algorithms/VOCdevkit/
ls /home/nabhoth/codes/vision_algorithms/VOCdevkit/VOCcode/
open /home/nabhoth/codes/vision_algorithms/VOCdevkit/VOCcode/VOCinit.m
VOCinit
mfilename
mfilename('fullpath')
strrep(fileparts(fileparts(mfilename('fullpath'))),'\','/')
open /home/nabhoth/codes/vision_algorithms/VOCdevkit/VOCcode/VOCinit.m
generate_data_for_bn_testing_bb_whole_images(  );
VOCinit
(VOCopts.seg.imgsetpath
VOCopts.seg.imgsetpath
VOCopts.testset
ls /mnt/images/1/VOC2012/VOC2012/ImageSets/Segmentation/val.txt
ls /mnt/images/1/VOC2012/ImageSets/Segmentation/val.txt
generate_data_for_bn_testing_bb_whole_images(  );
detTG
addpath('/home/nabhoth/codes/vision_algorithms/BSR/grouping/lib/');
detTG
ls '/home/nabhoth/codes/vision_algorithms/BSR/grouping/lib/'
ls /home/nabhoth/codes/vision_algorithms/BSR/grouping/
ls /home/nabhoth/codes/vision_algorithms/BSR/
ls '/home/nabhoth/codes/vision_algorithms/segbench/lib/matlab/'
addpath('/home/nabhoth/codes/vision_algorithms/segbench/lib/matlab/')
detTG
clear all
generate_data_for_bn_testing_bb_whole_images(  );
open detTG
generate_data_for_bn_testing_bb_whole_images(  );
%-- 03/19/2014 05:30:02 PM --%
%-- 03/19/2014 05:32:04 PM --%
ls
%-- 03/21/2014 07:24:27 PM --%
[mapping] = reduce_attributes_features(bins,removal);
[mapping] = reduce_attributes_features(0,'false');
nice i have not drink for a while now - i wonder what
[results] = evaluate_data_from_full_img_to_bb_full(0, 'false', 0);
VOCinit
VOCopts.seg.imgsetpath
[results] = evaluate_data_from_full_img_to_bb_full(0, 'false', 0);
help imwrite
[results] = evaluate_data_from_full_img_to_bb_full(0, 'false', 0);
%-- 03/22/2014 12:42:04 AM --%
VOCinit
VOCopts
which VOCinit
open /home/nabhoth/codes/vision_algorithms/VOCdevkit/VOCcode/VOCinit.m
VOCopts
VOCinit
VOCopts
[results] = evaluate_data_from_full_img_to_bb_full(0, 'false', 0);
help imwrite
help imread
[results] = evaluate_data_from_full_img_to_bb_full(0, 'false', 0);
help imwrite
%-- 03/24/2014 02:32:54 PM --%
cd Ima
cd Image_Understanding/
cd data/
ls
ls -alrt
ls from_whole_images_best_analysis/
load from_whole_images_best_analysis/nobins__reduced_false_evalresult_full.mat;
onlydata = results(2:end,:);
cowsale = onlydata(strcmp(onlydata(:,3), 'cow'),:);
clear all
load('/home/nabhoth/codes/vision_algorithms/matlab/Image_Understanding/data/from_whole_images_best_analysis/Extract_0/Algorithm_1/Object_cow/features.mat')
cowsale = cowsale(strcmp(cowsale(4,:), '1'));
cowsale = results(strcmp(results(4,:), '1'));
results(4,:)
cowsale = results(strcmp(results(:,4), '1'));
results(:,4)
cowsale = results(strcmp('1',results(:,4)));
cowsale = results(strcmp(results(:,4), '1'));
cowsale = results(strcmp(results(:,4), '1'),:);
strcmp(results(:,4), '1')
strcmp(results(:,4), 1)
strcmp(results(:,4), {'1'})
strcmp(results(:,3), 'cow')
strcmp(results(:,4), '1')
strcmp(results(:,4), '0')
results{1,4}
strcmp(results{1,4}, '1')
strcmp(results{1,4}, 1)
strcmp(results{1,4}, str(1))
results{1,4} == 1
cowsale = results(results(:,4) == 1,:);
results(:,4) == 1
results(:,4) == '1'
results(1,4) == 1
results{1,4} == 1
results{:,4} == 1
onlydata = results(:,4:end);
cowsale = onlydata(onlydata(:,4) == 1,:);
onlydata = cell2mat(results(:,4:end));
cowsale = onlydata(onlydata(:,4) == 1,:);
cowsale = onlydata(onlydata(:,1) == 1,:);
plot(cowsale(:,7:end));
cowcpmc = onlydata(onlydata(:,1) == 1,:);
cowsale = onlydata(onlydata(:,1) == 0,:);
cowsale = onlydata(onlydata(:,1) == 1,:);
load('/home/nabhoth/codes/vision_algorithms/matlab/Image_Understanding/data/from_whole_images_best_analysis/Extract_0/Algorithm_2/Object_cow/features.mat')
onlydata = cell2mat(results(:,4:end));
cowcpmc = onlydata(onlydata(:,1) == 1,:);
Figure
figure
plot(cowcpmc(:,7:end));
plot(cowcpmc(:,7:end)');
plot(cowsale(:,7:end));
figure
plot(cowcpmc(:,7:end));
figure
plot(cowcpmc(:,7:end)');
plot(cowsale(:,7:end)');
figure
plot(cowcpmc(:,7:end)');
plot(mean(cowcpmc(:,7:end))');
plot(mean(cowale(:,7:end))');
plot(mean(cowsale(:,7:end))');
plot(mean(cowcpmc(:,7:end))');
plot(mean(cowsale(:,7:end))');
plot(mean(cowcpmc(:,7:end))');
plot(std(cowcpmc(:,7:end))');
plot(std(cowsale(:,7:end))');
plot(std(cowsale(:,7:end))', std(cowcpmc(:,7:end))');
plot(std(cowsale(:,7:end))', mean(cowcpmc(:,7:end))');
plot(mean(cowsale(:,7:end))', mean(cowcpmc(:,7:end))');
help mean
plot(var(cowsale(:,7:end))', var(cowcpmc(:,7:end))');
plot(var(cowsale(:,7:end))');
plot(var(cowcpmc(:,7:end))');
plot(var(cowsale(:,7:end))');
x = linspace(1,100,100);
plot(x,var(cowsale(:,7:end))',x,var(cowcpmc(:,7:end))');
size(var(cowsale(:,7:end)))
x = linspace(1,94,94);
plot(x,var(cowsale(:,7:end))',x,var(cowcpmc(:,7:end))');
plot(x,std(cowsale(:,7:end))',x,std(cowcpmc(:,7:end))');
plot(x,median(cowsale(:,7:end))',x,median(cowcpmc(:,7:end))');
legend
legend('Ale', 'Cpmc');
plot(x,std(cowsale(:,7:end))',x,std(cowcpmc(:,7:end))');
legend('Ale', 'Cpmc');
plot(x,median(cowsale(:,7:end))',x,median(cowcpmc(:,7:end))');
plot(x,mean(cowsale(:,7:end))',x,mean(cowcpmc(:,7:end))');
help median
help cov
cov(mean(cowsale(:,7:end))',mean(cowcpmc(:,7:end))')
corrcoef(mean(cowsale(:,7:end))',mean(cowcpmc(:,7:end))')
corrcoef(mean(cowsale(:,7:end)),mean(cowcpmc(:,7:end)))
corrcoef((cowsale(:,7:end)),(cowcpmc(:,7:end)))
corrcoef((cowsale(:,7:end))))
corrcoef((cowsale(:,7:end)))
help corrcoeff
help corrcoef
[r,p] = corrcoef((cowsale(:,7:end)));
[i,j] = find(p<0.05);
plot([i,j])
plot([i,j]')
[i,j] = find(p<0.85);
plot([i,j])
[i,j] = find(p<0.95);
plot([i,j])
corrcoef(mean(cowsale(:,7:end)),mean(cowcpmc(:,7:end)))
plot(x,mean(cowsale(:,7:end))',x,mean(cowcpmc(:,7:end))');
plot(x,avg(cowsale(:,7:end))',x,avg(cowcpmc(:,7:end))');
plot(x,median(cowsale(:,7:end))',x,median(cowcpmc(:,7:end))');
legend('Ale', 'Cpmc');
xy = linspace(1,30,30);
plot(xy,median(cowsale(:,7:37))',xy,median(cowcpmc(:,7:37))');
plot(xy,median(cowsale(:,7:38))',xy,median(cowcpmc(:,7:38))');
size(median(cowcpmc(:,7:37)))
plot(xy,median(cowsale(:,7:36))',xy,median(cowcpmc(:,7:36))');
load('/home/nabhoth/codes/vision_algorithms/matlab/Image_Understanding/data/from_whole_images_best_analysis/nobins__reduced_false_evalresult_full.mat')
%-- 03/27/2014 03:01:56 PM --%
Detect_Dir('./results/');
cd ..
Detect_Dir('./results/');
mat2cellhelp
help mat2cell
Detect_Dir('./results/');
help save
Detect_Dir('./results/');
ls results
ls results/voc_release5_results/
ls results/voc_release5_results/person/
load  results/voc_release5_results/recognition_results.mat;
help line
load('VOC2007/car_final');
model.vis = @() visualizemodel(model, ...
1:2:length(model.rules{model.start}));
model.vis();
im = imread('000034.jpg');
[ds, bs] = imgdetect(im, model, -0.3);
b = reduceboxes(bs,model);
b = reduceboxes(model,bs);
clear all
Detect_Dir('./results/');
load('VOC2010/airplane_final.mat');
pwd
cd Recognition/voc-release5/
load('VOC2010/airplane_final.mat');
ls 2010
ls VOC2010/
load('VOC2010/aeroplane_final.mat');
VOCinit;
[gtids,t]=textread(sprintf(VOCopts.seg.imgsetpath,VOCopts.testset),'%s %d');
im = imread(sprintf(VOCopts.imgpath,gtids{1}));
[ds, bs] = imgdetect(im, model, -0.3];
[ds, bs] = imgdetect(im, model, -0.3);
op = nms(ds, 0.5);
bb = reduceboxes(model, bs(top,:))
bb = reduceboxes(model, bs(op,:))
bbox = bboxpred_get(model.bboxpred, ds, reduceboxes(model, bs));
bbox = clipboxes(inim, bbox)
bbox = clipboxes(im, bbox)
top = nms(bbox, 0.5);
top = nms(bbox, 0.5)
bbox = bboxpred_get(model.bboxpred, ds, reduceboxes(model, bs))
bb
bs
top = nms(ds, 0.5);
ds
model.type
model
Detect_Dir('./results/');
cd ..
Detect_Dir('./results/');
clear all
load  results/voc_release5_results/recognition_results.mat;
Detect_Dir('./results/');
%-- 04/01/2014 10:38:30 PM --%
cd Recognition/
cd voc-release5/
ls results/
ls results/voc_release5_results/
cd ..
ls results/
ls results/voc_release5_results/
ls results/voc_release5_results/recognition_results.mat
load results/voc_release5_results/recognition_results.mat;
ls results/voc_release5_results/aeroplane/
Detect_Dir('./results/');
ls results/voc_release5_results/
load results/voc_release5_results/recognition_results.mat;
clear all
load results/voc_release5_results/recognition_results.mat;
Detect_Dir('./results/');
load results/voc_release5_results/recognition_results.mat;
Detect_Dir('./results/');
load results/voc_release5_results/recognition_results.mat;
Detect_Dir('./results/');
imname =
2007_000123
Detect_Dir('./results/');
pwd
ls -alrt
open mod_images.m
ls Image_Understanding/data/
ls Image_Understanding/data/JPEG_alterations/
help copyfile
help imwrite
ls Image_Understanding/data/JPEG_alterations/
mod_images('Image_Understanding/data/JPEG_alterations/');
mod_images('./Image_Understanding/data/JPEG_alterations/');
help imwrite
mod_images('./Image_Understanding/data/JPEG_alterations/');
im = imread('./Image_Understanding/data/JPEG_alterations/2010_005877.jpg');
r = stdfilt(im);
imshow(r)
mod_images('./Image_Understanding/data/JPEG_alterations/');
%-- 04/06/2014 09:07:35 PM --%
help brightness
im = imread('000034.jpg');
cd Recognition/voc-release5/
im = imread('000034.jpg');
imshow(im)
i = imadjust(im,[[0 0],[0.5 0]);
i = imadjust(im,[0 0],[0.5 0]);
i = imadjust(im,[0 0],[0.5 1]);
i = imadjust(im,[0 1],[0.5 1]);
imshow(i)
i = imadjust(im,[0 1],[0 1]);
imshow(i)
i = imadjust(im,[0 1],[0 0.5]);
imshow(i)
i = imadjust(im,[0 0.5],[0 0.5]);
imshow(i)
i = imadjust(im,[0 0.5],[0 1]);
imshow(i)
imshow(im)
i = imadjust(im,[0 0.5],[0 1]);
imshow(im)
imshow(i)
i = imadjust(im,[0 1],[0 0.5]);
imshow(i)
i = imadjust(im,[0 0.5],[0 1]);
imshow(i)
imshow(im)
hsvimg = rgb2hsv(im);
for ch=2:3
hsvimg(;,;,ch) = imadjust(hsvimg(;,;,ch), stretchlim(hsvimg(;,;,ch), 0.01));
end
hsvimg(;,;,2) =imadjust(hsvimg(;,;,ch), stretchlim(hsvimg(;,;,ch), 0.01))
for ch=2:3
hsvimg(:,:,2) =imadjust(hsvimg(:,:,ch), stretchlim(hsvimg(:,:,ch), 0.01))
end
for ch=2:3
hsvimg(:,:,2) =imadjust(hsvimg(:,:,ch), stretchlim(hsvimg(:,:,ch), 0.01));
end
imgad = hsv2rgb(hsvimg);
imshow(imgad)
for ch=2:3
hsvimg(:,:,2) =imadjust(hsvimg(:,:,ch), stretchlim(hsvimg(:,:,ch), 0.001));
end
imgad = hsv2rgb(hsvimg);
imshow(imgad)
pwd
cd ..
cd Image_Understanding/data/MinMaxImages/
ls
f = fileread('list.txt');
f
[f]
f(1)
f = dlmread('list.txt' '\n');
f = dlmread('list.txt', '\n');
f = fileread('list.txt', '\n');
f = textread('list.txt', '\n');
f = textread('list.txt', 'delimiter', '\n');
f = textread('list.txt', '%s', 'delimiter', '\n');
f
f = textread('list.txt', '%s', 'delimiter', '\n');
f
f = textread('list.txt', '%s', 'delimiter', '\n');
f = textread('list.txt', '%s', 'delimiter', '\n');fj = [f, '.jpg']
fj = [f, '.jpg']
fj = [f, {'.jpg'}]
vector
fj{1}
f{1}
fj= strcat(f, '.jpg');
fj
VOCinit
VOCopts.imgpath
files = dir(['./Image_Understanding/data/JPEG_alterations/' '*.jpg']);
files
pwd
cd ..
files = dir(['./Image_Understanding/data/JPEG_alterations/' '*.jpg']);
files
files.name
[files.name]
{files.name}
strcat('./Image_Understanding/data/JPEG_alterations/', {files.name})
ff = strcat('./Image_Understanding/data/JPEG_alterations/', {files.name})
ff{1}
ff{2}
fj
tt = strcat(VOCopts.imgpathname, fj);
tt = strcat(VOCopts.imgpath, fj);
ff{1}
fj
VOCopts.imgpath
f = textread('list.txt', '%s', 'delimiter', '\n');
cd Image_Understanding/data/MinMaxImages/
f = textscan('list.txt', '%s', 'delimiter', '\n');
f
f{1}
f = textscan(fopen('list.txt'), '%s', 'delimiter', '\n');
f
f{1}
f = textscan(fopen('list.txt'), '%s');
f
f = textscan(fopen('list.txt'), '%s\n');
f
f{1}
f = textscan(fopen('list.txt'), '%s\n');
fid = fopen('list.txt');
fid
f = textscan(fopen('list.txt'), '%s\n' 10);
f = textscan(fopen('list.txt'), '%s\n', 10);
f
f{1}
f = textscan(fopen('list.txt'), '%s\n', 1);
f{1}
break cell into subcells
f = textscan(fopen('list.txt'), '%s\n');
f
filesd = strsplit(f, '\n');
filesd = strsplit(f{1}, '\n');
f{1}
f
f{1,1}
f{2,1}
size(f)
size(f{1})
r = f{1};
size(r)
r{1}
numel(r)
for i = 1:numel(r)
files{i} =  sprintf(VOCopts.imgpath, r{i});
end
r{1}
r{2}
a = sprintf(VOCopts.imgpath, r{i});
a
numel(r)
cd ..
mod_images('./Image_Understanding/data/MinMaxImages/');
mod_images('./Image_Understanding/data/MinMaxImages/')
%-- 04/08/2014 10:40:56 AM --%
%-- 04/16/2014 04:42:35 PM --%
help isfile
isdir
help isdir
mod_images_statistics('./Image_Understanding/data/MinMaxImages/')
help mean
open cgtg
VOCinit
VOCopts
VOCopts.clsimgsetpath
VOCopts.resdir
VOCopts.seg
mod_images_statistics('./Image_Understanding/data/MinMaxImages/')
ls ./Image_Understanding/data/MinMaxImages/wiener/*.png
ls ./Image_Understanding/data/MinMaxImages/wiener/*.jpg
mod_images_statistics('./Image_Understanding/data/MinMaxImages/')
ls ../segbench/
ls ../segbench/lib/
ls ../segbench/lib/matlab/
open detCG
open ../segbench/lib/matlab/detCG.m
open ../segbench/lib/matlab/cgmo.m
open ../segbench/lib/matlab/cgso.m
open ../segbench/lib/matlab/tgmo.m
open ../segbench/lib/matlab/tgso.m
im = imread('../VOCdevkit/VOC2012/JPEGImages/2008_008268.jpg');
gim = imread('../VOCdevkit/VOC2012/SegmentationClass/2008_008268.png');
addpath('../segbench/lib/matlab/');
[a,b,c] = detTG(im);
size(a)
size(b)
size(c)
imshow(c)
imshow(short(c))
imshow(single(c))
imshow(single(c.*4))
imshow(im2int16(c.*4))
imshow(im2int16(c).*4)
d = (im2int16(c).*4);
d = (im2single(c).*4);
imshow(im2int16(c).*4)
imshow(im)
imshow(im2int(c).*4)
imshow(im2int8(c).*4)
imshow(c./64)
gim = imread('../VOCdevkit/VOC2012/SegmentationClass/2008_008051.jpg');
pwd
gim = imread('../VOCdevkit/VOC2012/JPEGImages/2008_008051.jpg');
[a,b,c] = detTG(im);
imshow(c./64)
im = imread('../VOCdevkit/VOC2012/JPEGImages/2008_008051.jpg');
imshow(c./64)
[a,b,c] = detTG(im);
imshow(c./64)
imshow(im)
imshow(c./64)
gim = imread('../VOCdevkit/VOC2012/SegmentationClass/2008_008051.png');
unique(gim)
indexes = gim == 0;
imshow(c(indexes)./64)
imshow(c(indexes)./64);
size(s(indexes))
size(c(indexes))
size(c)
size(indexes)
size(c.*indexes)
imshow(c.*indexes./64);
indexes = gim == 11;
imshow(c.*indexes./64);
indexes = gim == 255;
imshow(c.*indexes./64);
imshow(im.*indexes);
imshow(im(:,:,1).*indexes);
imshow(im(:,:,1).*double(indexes));
imshow(im(:,:,1).*unint(indexes));
imshow(im(:,:,1).*uint(indexes));
imshow(im(:,:,1).*uint8(indexes));
imshow(im(:,:,2).*uint8(indexes));
VOCopts.seg
VOCopts.seg.clsimgpath
VOCopts.seg.imgsetpath
VOCopts.seg.clsimgpath
VOCopts.seg
VOCopts.seg.clsimgpath
VOCopts.seg.clsresdir
VOCopts.seg.instimgpath
gim = imread('../VOCdevkit/VOC2012/SegmentationClass/2008_008051.png');
addpath('../segbench/lib/matlab/');
mod_images_statistics('./Image_Understanding/data/MinMaxImages/')
mod_images_statistics('./Image_Understanding/data/MinMaxImages/brightness_inc/', '2007_000572.jpg')
ls
mod_images_statistics('./Image_Understanding/data/MinMaxImages/brightness_inc/', '2007_000572.jpg')
VOCopts.seg.instimgpath
img = '2007_000572.jpg'
sprintf( VOCopts.seg.instimgpath, img(1:end-4))
ls /home/nabhoth/codes/vision_algorithms/VOCdevkit/VOC2012/SegmentationObject/2007_000572.png
mod_images_statistics('./Image_Understanding/data/MinMaxImages/brightness_inc/', '2007_000572.jpg')
[gcrtst, brght, contrasts, textures] =mod_images_statistics('./Image_Understanding/data/MinMaxImages/brightness_inc/', '2007_000572.jpg');
[gcrtst, brght, contrasts, textures] =mod_images_statistics('./Image_Understanding/data/MinMaxImages/brightness_inc/', '2008_008268.jpg');
[gcrtst, brght, contrasts, textures] =mod_images_statistics('./Image_Understanding/data/MinMaxImages/brightness_inc/', '2007_000572.jpg');
[gcrtst, brght, contrasts, textures] =mod_images_statistics('./Image_Understanding/data/MinMaxImages/brightness_inc/', '2007_000837.jpg');
VOCopts.seg
VOCopts.seg.clsimgpath
[gcrtst, brght, contrasts, textures] =mod_images_statistics('./Image_Understanding/data/MinMaxImages/brightness_inc/', '2007_000837.jpg');
%-- 04/17/2014 10:37:02 PM --%
[gcrtst, brght, contrasts, textures] =mod_images_statistics('./Image_Understanding/data/MinMaxImages/brightness_inc/', '2007_000837.jpg');
[gcrtst, brght, contrasts, textures] =mod_images_statistics('./Image_Understanding/data/MinMaxImages/brightness_inc/', '2007_000572.jpg');
[gcrtst, brght, contrasts, textures] =mod_images_statistics('./Image_Understanding/data/MinMaxImages/brightness_inc/', '2007_000837.jpg');
[gcrtst, brght, contrasts, textures] =mod_images_statistics('./Image_Understanding/data/MinMaxImages/brightness_dec/', '2007_000837.jpg');
[gcrtst, brght, contrasts, textures] =mod_images_statistics('./Image_Understanding/data/MinMaxImages/gauss_fily/', '2007_000572.jpg');
[gcrtst, brght, contrasts, textures] =mod_images_statistics('./Image_Understanding/data/MinMaxImages/gauss_filt/', '2007_000572.jpg');
[gcrtst, brght, contrasts, textures] =mod_images_statistics('./Image_Understanding/data/MinMaxImages/brightness_inc/', '2007_000837.jpg');
[gcrtst, brght, contrasts, textures] =mod_images_statistics('../VOCdevkit/VOC2012/JPEGImages/', '2007_000837.jpg');
[gcrtst, brght, contrasts, textures] =mod_images_statistics('./Image_Understanding/data/MinMaxImages/brightness_inc/', '2007_000837.jpg');
[gcrtst, brght, contrasts, textures] =mod_images_statistics('../VOCdevkit/VOC2012/JPEGImages/', '2007_000837.jpg');
process_images_stats_dir('./Image_Understanding/data/Multi_Algo_Final_Results/ale_val_cls_selected/', 'min_ale.txt');
process_images_stats_dir('../VOCdevkit/VOC2012/JPEGImages_selected/', 'min_ale.txt');
%-- 04/18/2014 11:18:22 AM --%
process_images_stats_dir('../VOCdevkit/VOC2012/JPEGImages_selected/', 'min_ale.txt');
results = process_images_stats_dir('../VOCdevkit/VOC2012/JPEGImages_selected/', 'min_ale.txt');
results = process_images_stats_dir('../VOCdevkit/VOC2012/JPEGImages_selected/', 'min_cpmc.txt');
alea = cell2mat(aleresults(:,1));
aleb = cell2mat(aleresults(:,2));
alec = cell2mat(aleresults(:,3));
alec = cell2mat(aleresults(:,3), ones(1,53), [1 1 1]);
alec = cell2mat(aleresults(:,3));
aleresults(:,3)
aleresults(:,3){1}
aleresults(1,3)
aleresults(1,3){1}
aleresults(:3)
aleresults(:,3)
aleresults(:,3)(1)
{aleresults(:,3)}
{aleresults(:,3)}{1}
{aleresults(:,3)}(1)
[aleresults(:,3)]
[aleresults(:,3)]{1}
[aleresults(:,3){1}]
aleresults{:,3}
aleresults{:,3}{1}
aleresults{:,3}(1,1)
[aleresults{:,3}]
aleresults{:,3}
aleresults{:,3,1}
aleresults{:,3}{1}
aleresults[:,3]
aleresults(:,3)
aleresults(:,3)(1,1)
aleresults{:,3}
[aleresults{:,3}]
[aleresults{:,3}(1,1)]
aleresults{1,3}
aleresults{1,3}(1,1)
aleresults{1,3}(:,1)
aleresults{1,3}(1,:)
aleresults{:,3}(1,:)
[aleresults{:,3}](1,:)
aleresults{1,3}(1,:)
aleresults{2,3}(1,:)
aale = aleresults(:,3);
aale(:,1)
aale(:,1){1}
aale{:,1}
[aale{:,1}]
aale(:,1)
[aale(:,1)]
{aale(:,1)}
aale{:,1}
aale{:,1}(1,1)
aale(1,1){:,1}
aale{:,1}(1,1)
aale{1,1}(1,1)
aale{:,1}(:,1)
aale{:,1}
alec = zeros(53,1);
for i =1:53,
aale{1,1}(1,1)
aale{2,1}(1,1)
aale{1,1}
aale(1,1)
aale{1}
aale{1}(1,:)
aale = aleresults(:,3);
aale{1}(1,:)
aale{:}(1,:)
aale{:,1}(1,:)
aale{:,1}
[aale{:,1}]
[aale{:,1}(1,1)]
[aale{:,1}(1,:)]
[aale{:}(1,:)]
[aale(1,:)]
[aale(:,1)]
aale{:,1}
aale{:}
aale{:}(1)
aale{:}(1,:)
aale{1,1}
aale{1,1}(1)
for i =1:53,
alec(i,1) = aale{i,1}(1);
end
scatter3(alea,aleb,alec)
cpmca = cell2mat(cpmcresults(:,1));
cpmcb = cell2mat(cpmcresults(:,2));
cpmcc = zeros(43,1);
for i =1:43,
ccpmc = cpmcresults(:,3);
for i =1:43,
cpmc(i,1) = ccpmc{i,1}(1);
end
scatter3(cpmca,cpmcb,cpmcc)
ccpmc{1,1}(1)
for i =1:43,
cpmcc(i,1) = ccpmc{i,1}(1);
end
scatter3(cpmca,cpmcb,cpmcc)
scatter3(cpmca,cpmcb,cpmcc, 'r.')
hold on
scatter3(alea,aleb,alec, 'bo')
legend
cpmcd = zeros(43,1);
aled = zeros(53,1);
for i =1:43,
dcpmc = cpmcresults(:,4);
for i =1:43,
cpmcd(i,1) = dcpmc{i,1}(1);
end;
for i =1:53,
dale = aleresults(:,4);
for i =1:53,
aled(i,1) = dale{i,1}(1);
end
figure
holdon
hold on
scatter3(cpmca,cpmcb,cpmcc, 'r.')
scatter3(alea,aleb,alec, 'bo')
scatter3(cpmca,cpmcb,cpmcc, 'r.')
hold on
scatter3(alea,aleb,alec, 'bo')
hold off
scatter3(cpmca,cpmcb,cpmcd, 'r.')
hold on
scatter3(alea,aleb,aled, 'bo')
scatter3(alea,alec,aled, 'bo')
hold off
scatter3(alea,alec,aled, 'bo')
scatter3(cpmca,cpmcc,cpmcd, 'r.')
hold on
scatter3(alea,alec,aled, 'bo')
help srtrows
help sortrows
scpmcresults =sortrows(cpmcresults)
scpmcresults =sortrows(cpmcresults,1)
scpmcresults =sortrows(cpmcresults,1);
saleresults =sortrows(aleresults,1);
help linspace
linspace(1,64,64)
clear all
results = process_images_stats_dir('../VOCdevkit/VOC2012/JPEGImages_selected/', 'min_ale.txt');
cpmcresults = process_images_stats_dir('../VOCdevkit/VOC2012/JPEGImages_selected/', 'min_cpmc.txt');
alea = cell2mat(aleresults(:,1));
aleb = cell2mat(aleresults(:,2));
aale = aleresults(:,3);
alec = zeros(53,1);
for i =1:53,
alec(i,1) = aale{i,1}(1);
end
alec = zeros(51,1);
for i =1:51,
alec(i,1) = aale{i,1}(1);
end
aale = aleresults(:,4);
aled = zeros(51,1);
for i =1:51,aled(i,1) = aale{i,1}(1);
end
cpmca = cell2mat(cpmcresults(:,1));
cpmcb = cell2mat(cpmcresults(:,2));
cpmcc = zeros(43,1);
cpmcd = zeros(43,1);
ccpmc = cpmcresults(:,3);
for i =1:43,
cpmc(i,1) = ccpmc{i,1}(1);
end
dcpmc = cpmcresults(:,4);
for i =1:43,
cpmcd(i,1) = dcpmc{i,1}(1);
end;
scatter3(cpmca,cpmcb,cpmcc, 'r.')
ccpmc = cpmcresults(:,3);
for i =1:43,
cpmcc(i,1) = ccpmc{i,1}(1);
end
scatter3(cpmca,cpmcb,cpmcc, 'r.')
scatter3(alea,aleb,alec, 'bo')
hold on
scatter3(cpmca,cpmcb,cpmcc, 'r.')
scatter3(alea,alec,aled, 'bo')
hold on
scatter3(cpmca,cpmcc,cpmcd, 'r.')
hold off
scatter3(cpmca,cpmcb,cpmcc, 'r.')
scatter3(cpmca,cpmcc,cpmcd, 'r.')
scatter3(cpmca,cpmcb,cpmcc, 'r.')
hold on
scatter3(alea,aleb,alec, 'bo')
hold off
scatter3(aleb,alec,aled, 'bo')
scatter3(cpmcb,cpmcc,cpmcd, 'r.')
scatter3(aleb,alec,aled, 'bo')
hold on
scatter3(cpmcb,cpmcc,cpmcd, 'r.')
hold off
scatter3(alea,aleb,aled, 'bo')
hold on
scatter3(cpmca,cpmcb,cpmcd, 'r.')
scatter3(alea,aleb,aled, 'bo')
hold on
scatter3(cpmca,cpmcb,cpmcd, 'r.')
scatter3(aleb,alec,aled, 'bo')
scatter3(cpmcb,cpmcc,cpmcd, 'r.')
hold on
scatter3(aleb,alec,aled, 'bo')
hold off
scatter3(alea,aleb,alec, 'bo')
hold on
scatter3(cpmca,cpmcb,cpmcc, 'r.')
%-- 04/21/2014 03:05:20 PM --%
cd Recognition/
cd voc-release5/
ls
open Detect_Dir.m
pwd
cd ..
cd results/voc_release5_results/
load recognition_results;
load recognition_results.mat;
cd ..
ls -alrt
Detect_Dir('./results/');
%-- 04/24/2014 03:43:46 PM --%
ls -alrt
open process_images_stats_dir.m
open mod_images_statistics.m
process_images_stats_dir('../VOCdevkit/VOC2012/', 'ale_dark.txt');
ale_dark_results=process_images_stats_dir('../VOCdevkit/VOC2012/', 'ale_dark.txt');
cpmc_dark_results=process_images_stats_dir('../VOCdevkit/VOC2012/', 'cpmc_dark.txt');
plot(ale_dark_results(:,1)')
plot(cell2mat(ale_dark_results(:,1))')
plot(cell2mat(cpmc_dark_results(:,1))')
plot(cell2mat(ale_dark_results(:,1))')
help mean
median(cell2mat(ale_dark_results(:,1))
median(cell2mat(ale_dark_results(:,1)))
median(cell2mat(cpmc_dark_results(:,1)))
median(cell2mat(cpmc_dark_results(:,2)))
median(cell2mat(ale_dark_results(:,2)))
plot(cell2mat(ale_dark_results(:,2))')
plot(cell2mat(cpmc_dark_results(:,2))')
size(cpmc_dark_results)
x  = linespace(1,152,152);
x  = linspace(1,152,152);
plot(x, cell2mat(cpmc_dark_results(:,1))',x, cell2mat(cpmc_dark_results(:,2))')
plot(x, cell2mat(cpmc_dark_results(:,1))',x, cell2mat(cpmc_dark_results(:,1))')
plot(x, cell2mat(ale_dark_results(:,1))',x, cell2mat(ale_dark_results(:,2))')
y  = linspace(1,115,115);
plot(y, cell2mat(ale_dark_results(:,1))',y, cell2mat(ale_dark_results(:,2))')
plot(x, cell2mat(cpmc_dark_results(:,1))',x, cell2mat(cpmc_dark_results(:,2))')
plot(y, cell2mat(ale_dark_results(:,1))',y, cell2mat(ale_dark_results(:,2))')
plot(cell2mat(ale_dark_results(:,1))'.*cell2mat(ale_dark_results(:,2))')
plot(cell2mat(cpmc_dark_results(:,1))'.*cell2mat(cpmc_dark_results(:,2))')
plot(y, cell2mat(ale_dark_results(:,1))',y, cell2mat(cpmc_dark_results(:,1))')
plot(y, cell2mat(ale_dark_results(:,1))',y, cell2mat(ale_dark_results(:,2))')
figure
plot(x, cell2mat(cpmc_dark_results(:,1))',x, cell2mat(cpmc_dark_results(:,2))')
legend('Average Brightness', 'Average Cotnrast');
plot(y, cell2mat(ale_dark_results(:,1))',y, cell2mat(ale_dark_results(:,2))')
legend('Average Brightness', 'Average Cotnrast');
plot(y, cell2mat(ale_dark_results(:,1))',y, median(cell2mat(ale_dark_results(:,2)))')
plot(y, cell2mat(ale_dark_results(:,1))',y, median(cell2mat(ale_dark_results(:,1)))')
legend('Average Brightness', 'Average Brightness Median');
plot(x, cell2mat(cpmc_dark_results(:,1))',x, media(cell2mat(cpmc_dark_results(:,1)))')
plot(x, cell2mat(cpmc_dark_results(:,1))',x, median(cell2mat(cpmc_dark_results(:,1)))')
legend('Average Brightness', 'Average Brightness Median');
plot(x, cell2mat(cpmc_dark_results(:,2))',x, median(cell2mat(cpmc_dark_results(:,2)))')
legend('Average Contrast', 'Average Contrast Median');
plot(y, cell2mat(ale_dark_results(:,1))',y, median(cell2mat(ale_dark_results(:,1)))')
legend('Average Contrast', 'Average Contrast Median');
plot(y, cell2mat(ale_dark_results(:,1))',y, median(cell2mat(ale_dark_results(:,1)))')
legend('Average Brightness', 'Average Brightness Median');
plot(y, cell2mat(ale_dark_results(:,2))',y, median(cell2mat(ale_dark_results(:,2)))')
legend('Average Contrast', 'Average Contrast Median');
plot(x, cell2mat(cpmc_dark_results(:,2))',x, median(cell2mat(cpmc_dark_results(:,2)))')
legend('Average Contrast', 'Average Contrast Median');
plot(x, cell2mat(cpmc_dark_results(:,1))',x, median(cell2mat(cpmc_dark_results(:,1)))')
legend('Average Brightness', 'Average Brightness Median');
plot(x, cell2mat(cpmc_dark_results(:,1))', 'Line width', 2, x, median(cell2mat(cpmc_dark_results(:,1)))', 'Line Width', 3)
plot(x, cell2mat(cpmc_dark_results(:,1))', 'Line width', 2)
plot(x, cell2mat(cpmc_dark_results(:,1))', 'Line Width', 2)
plot(x, cell2mat(cpmc_dark_results(:,1))', 'linewidth', 2)
plot(x, cell2mat(cpmc_dark_results(:,1))', 'linewidth', 2, x, median(cell2mat(cpmc_dark_results(:,1)))', 'linewidth', 3)
plot(x, cell2mat(cpmc_dark_results(:,1))', 'linewidth', 2)
hold on
plot(x, median(cell2mat(cpmc_dark_results(:,1)))', 'linewidth', 3);
medcpmcbri = median(cell2mat(cpmc_dark_results(:,1)))';
medcpmcbri = repmat(median(cell2mat(cpmc_dark_results(:,1)))',[1  152]);
plot(x, medcpmcbri, 'linewidth', 2);
legend('Average Brightness', 'Average Brightness Median');
hold off
medcpmccrts = repmat(median(cell2mat(cpmc_dark_results(:,2)))',[1  152]);
plot(x, cell2mat(cpmc_dark_results(:,2))', 'linewidth', 2)
hold on
plot(x, medcpmccrts, 'linewidth', 2);
legend('Average Contrast', 'Average Contrast Median');
hold off
medcpmccrts = repmat(median(cell2mat(ale_dark_results(:,2)))',[1  115]);
plot(y, cell2mat(ale_dark_results(:,2))', 'linewidth', 2)
hold on
plot(y, medcpmccrts, 'linewidth', 2);
legend('Average Contrast', 'Average Contrast Median');
hold off
medcpmcbri = median(cell2mat(ale_dark_results(:,1)))';
plot(y, cell2mat(ale_dark_results(:,1))', 'linewidth', 2)
hold on
plot(y, medcpmcbri, 'linewidth', 2);
legend('Average Brightness', 'Average Brightness Median');
medcpmcbri = repmat(median(cell2mat(ale_dark_results(:,1)))', [1 115]);
plot(y, medcpmcbri, 'linewidth', 2);
legend('Average Brightness', 'Average Brightness Median');
plot(x, cell2mat(cpmc_dark_results(:,1))',x, median(cell2mat(cpmc_dark_results(:,1)))')
[suitability, im_accumulators, rules, rows, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 35);
pwd
cd Image_Understanding/
[suitability, im_accumulators, rules, rows, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 35);
clear all
[suitability, im_accumulators, rules, rows, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 35);
plot(rows(31,1:40))
plot(rows(31,1:end))
plot(cell2mat(rules{1,3}(3,2:end)))
plot(cell2mat(rules{1,3}(2,2:end)))
%-- 04/25/2014 11:55:19 PM --%
cd Image
cd Image_Understanding/
[suitability, im_accumulators, rules, rows, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 1);
[suitability, im_accumulators, rules, rows, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 60);
suit1 = suitability(:,:,1);
suit2 = suitability(:,:,2);
bar (cell2mat(suit1(16,2:end)))
bar (cell2mat(suit2(16,2:end)))
bar (cell2mat(suit1(16,2:20)))
bar(plots(:,:,1,1,2)')
bar(plots(:,:,1,2,3)')
bar(plots(:,:,1,3,4)')
bar(plots(:,:,1,2,4)')
bar(plots(:,:,1,1,2)')
bar(plots(:,:,1,1,3)')
size(plots(:,:,1,1,3)')
size(plots(:,:,1,1,3))
size(plots(1,:,1,1,3))
bar(plots(1,:,1,1,3)')
bar(plots(1,:,1,1,3))
bar(plots(:,1,1,1,3))
bar(plots(:,2,1,1,3))
bar(plots(:,3,1,1,3))
bar(plots(:,3,1,1,2))
bar(plots(:,3,1,1,1))
bar(plots(:,3,1,1,4))
bar(plots(:,3,1,1,5))
bar(plots(:,1,1,1,3))
bar(plots(:,1,1,1,1))
bar(plots(:,1,1,1,2))
bar(plots(:,1,1,1,3))
bar(plots(:,1,1,1,4))
bar(plots(:,1,1,1,5))
bar(plots(:,1,1,1,1))
bar(plots(:,1,1,1,2))
bar(plots(:,1,1,1,3))
bar(plots(:,1,1,1,4))
bar(plots(:,1,1,1,5))
%-- 04/28/2014 12:14:12 PM --%
cd Image_Understanding/
[suitability, im_accumulators, rules, rows, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 60);
bar(plots(:,1,1,1,5))
bar(plots(:,1,1,1,4))
%-- 04/29/2014 08:54:27 PM --%
cd Image_Understanding/
[suitability, im_accumulators, rules, rows, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 60);
bar(plots(:,1,1,1,5))
bar(plots(:,1,1,1,4))
size(plots(:,:,1,1,3))
bar(plots(:,:,1,1,3)')
load ./data/nobins__reduced_false_evalresult.mat
idx = cell2mat(results(2:end,7));
idx = idx == 1;
idx = [0; idx];
aleall = results(idx,:);
aleall = results(unit8(idx),:);
aleall = results(uint8(idx),:);
aleall = results(logical(idx),:);
idx = idx == 2;
idx = [0; idx];
cpmcall = results(logical(idx),:);
idx = cell2mat(results(2:end,7));
idx = logical(idx);
integer
idx = cell2mat(results(2:end,7));
idx = unint8(idx);
idx = uint8(idx);
idx = [0; idx];
alidx = idx == 1;
cpidx = idx == 2;
aleall = results(uint8(alidx),:);
aleall = results(logical(alidx),:);
cpmcall = results(logical(cpidx),:);
VOCinit
for i=1:VOCopts.nclasses
aleall(strcmp(aleall(:,3),VOCopts.classes{i}),3) = {i};
end
for i=1:VOCopts.nclasses
cpmcall(strcmp(cpmcall(:,3),VOCopts.classes{i}),3) = {i};
end
aleall1 = aleall(sleall(:,3) == 1),:)
aleall1 = aleall(aleall(:,3) == 1,:)
alleall = cell2mat(aleall);
alealldata = cell2mat(aleall(:,3:end));
cpmcalldata = cell2mat(cpmcall(:,3:end));
allaledata1 = alealldata(alealldata(:,1) == 1);
allcpmcdata1 = cpmcalldata(cpmcalldata(:,1) == 1);
allaledata1 = alealldata(alealldata(:,1) == 1,:);
allcpmcdata1 = cpmcalldata(cpmcalldata(:,1) == 1,:);
aleplanes = allcpmcdata1(allcpmcdata1(:,3) > 60,:);
cpmcplanes = allcpmcdata1(allcpmcdata1(:,3) > 60,:);
aleplanes = allaledata1(allaledata1(:,3) > 60,:);
bar(alepplanes(:,6))
bar(aleplanes(:,6))
binranges = linspace(1,10,10)
histc(aleplanes(:,6), binranges)
bar(histc(aleplanes(:,6), binranges))
figure
bar(histc(cpmcplanes(:,6), binranges))
VOCopts.classes
allaledata1 = alealldata(alealldata(:,1) == 15,:);
allcpmcdata1 = cpmcalldata(cpmcalldata(:,1) == 15,:);
alepeople = allaledata1(allaledata1(:,3) > 60,:);
cpmcpeople = allcpmcdata1(allcpmcdata1(:,3) > 60,:);
bar(histc(aleeople(:,6), binranges))
bar(histc(alepeople(:,6), binranges))
bar(histc(cpmcpeople(:,6), binranges))
bar(histc(alepeople(:,6), binranges))
figure
bar(histc(cpmcpeople(:,6), binranges))
alemins = min(alepeople(:,6:end));
alemaxs = max(alepeople(:,6:end));
[suitability, im_accumulators, rules, rows, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 60);
clear all
load ./data/analysis_output/im_accumulators_nobins__reduced_false_evalresult.mat;
clear all
[suitability, im_accumulators, rules, rows, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 60);
load ./data/analysis_output/im_accumulators_nobins__reduced_false_evalresult.mat;
clear all
[suitability, im_accumulators, rules, rows, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 60);
prof. Kameyama,
load ./data/nobins__reduced_false_evalresult.mat
only_data = results(2:end;4:end);
only_data = results(2:end,4:end);
only_labels = results(2:end, 1:3);
plot(cell2mat(only_data(:,4)))
plot(cell2mat(only_data(:,4))')
plot(cell2mat(only_data(:,8))')
plot(cell2mat(only_data(:,8))', 'ro')
ale_index = cell2mat(only_data(:,4)) == 1;
cpmc_index = cell2mat(only_data(:,4)) == 2;
plot(cell2mat(only_data(ale_index,8))', 'ro')
hold on
plot(cell2mat(only_data(cpmc_index,8))', 'bx')
hold off
plot(cell2mat(only_data(ale_index,8))', 'ro')
hold on
plot(cell2mat(only_data(cpmc_index,8))', 'bx')
legend('ALE', 'CPMC')
xlabel('Sample ID');
ylabel('Sample Intensity');
hold off
plot(cell2mat(only_data(ale_index,5))', 'ro')
hold on
plot(cell2mat(only_data(cpmc_index,5))', 'bx')
hold off
plot(cell2mat(only_data(ale_index,8))', 'ro')
plot(cell2mat(only_data(cpmc_index,8))', 'bx')
hold on
plot(cell2mat(only_data(ale_index,8))', 'ro')
%-- 05/02/2014 11:03:40 AM --%
load('/home/nabhoth/codes/vision_algorithms/matlab/Image_Understanding/data/nobins__reduced_false_evalresult_full.mat')
load('/home/nabhoth/codes/vision_algorithms/matlab/Image_Understanding/data/evalresult.mat')
load('/home/nabhoth/codes/vision_algorithms/matlab/Image_Understanding/data/bins_0_reduced_falseevalresult.mat')
load('/home/nabhoth/codes/vision_algorithms/matlab/Image_Understanding/data/Features_Hypothesis_Regions_Mapping_BN.mat')
load('/home/nabhoth/codes/vision_algorithms/matlab/Image_Understanding/data/Features_Hypothesis_Regions_Mapping_BN_NOBINS_reduced_false.mat')
load('/home/nabhoth/codes/vision_algorithms/matlab/Image_Understanding/data/Features_Hypothesis_Regions_Mapping_BN_Test.mat')
clear all
load('/home/nabhoth/codes/vision_algorithms/matlab/Image_Understanding/data/nobins__reduced_false_evalresult.mat')
load('/home/nabhoth/codes/vision_algorithms/matlab/Image_Understanding/data/Features_Hypothesis_Regions_Mapping_BN_NOBINS_reduced_false.mat')
load('/home/nabhoth/codes/vision_algorithms/matlab/Image_Understanding/data/Features_Hypothesis_Regions_Mapping_BN.mat')
load('/home/nabhoth/codes/vision_algorithms/matlab/Image_Understanding/data/nobins__reduced_false_evalresult.mat')
load('/home/nabhoth/codes/vision_algorithms/matlab/Image_Understanding/data/nobins__reduced_false_evalresult_full.mat')
clear all
cd Image_Understanding/
[suitability, im_accumulators, rules, rows, plots, ent_results,  per_results, classes_cat, c_mu, a_mu, a_cov, c_cov ] = analyze_data_for_bn(0, 'false', 60);
load ./data/analysis_output/im_accumulators_nobins__reduced_false_evalresult.mat;
only_data = results(2:end,4:end);
load ./data/nobins__reduced_false_evalresult.mat
only_data = results(2:end,4:end);
only_labels = results(2:end, 1:3);
ale_index = cell2mat(only_data(:,4)) == 1;
cpmc_index = cell2mat(only_data(:,4)) == 2;
plot(cell2mat(only_data(ale_index,8))', 'ro')
hold on
plot(cell2mat(only_data(cpmc_index,8))', 'bx')
xlabel('Sample ID');
ylabel('Sample Value');
legend('ALE', 'CPMC')
hold off
plot(cell2mat(only_data(ale_index,5))', 'ro')
hold on
plot(cell2mat(only_data(cpmc_index,5))', 'bx')
xlabel('Sample ID');
ylabel('Sample Value');
legend('ALE', 'CPMC')
for i=1:size(only_labels,1)
airplane_label =  strcmp(only_labels(:,3), 'airplane');
airplane_label =  strcmp(only_labels(:,3), 'aeroplane');
dog_label =  strcmp(only_labels(:,3), 'dog');
cat_label =  strcmp(only_labels(:,3), 'cat');
person_label =  strcmp(only_labels(:,3), 'person');
person_data_only = only_data(person_label,:);
person_data_only_thresh_60 = only_data(cell2mat(person_data_only(:,2))>60,:);
person_data_only_thresh_60 = only_data(double(cell2mat(person_data_only(:,2)))>60,:);
person_data_only_thresh_60 = only_data(double(cell2mat(person_data_only(:,2)))>0,:);
person_data_only_thresh_60 = only_data(double(cell2mat(person_data_only(:,1)))>0,:);
person_data_only_thresh_60 = person_data_only(double(cell2mat(person_data_only(:,1)))>0,:);
person_data_only_thresh_60 = person_data_only(cell2mat(person_data_only(:,1))>60,:);
person_data_only_thresh_60 = person_data_only(double(cell2mat(person_data_only(:,1)))>0,:);
double(cell2mat(person_data_only(:,1)))>0
a = double(cell2mat(person_data_only(:,2)))>0;
person_data_only_thresh_60 = person_data_only(a,:);
b = double(cell2mat(person_data_only_thresh_60(:,4)))==1;
c = double(cell2mat(person_data_only_thresh_60(:,4)))==2;
ale_person_data_only_thresh_60 = person_data_only_thresh_60(b,:);
cpmc_person_data_only_thresh_60 = person_data_only_thresh_60(c,:);
hold off
plot(ale_person_data_only_thresh_60(:,5), 'ro');
plot(cell2mat(ale_person_data_only_thresh_60(:,5))', 'ro');
plot(cell2mat(cpmc_person_data_only_thresh_60(:,5))', 'bx');
hold on
plot(cell2mat(ale_person_data_only_thresh_60(:,5))', 'ro');
legend('ALE', 'CPMC')
legend('CPMC', 'ALE')
ylabel('Sample Value');
xlabel('Sample ID');
dog_data_only = only_data(dog_label,:);
a = double(cell2mat(dog_data_only(:,2)))>0;
dog_data_only_thresh_60 = dog_data_only(a,:);
b = double(cell2mat(dogn_data_only_thresh_60(:,4)))==1;
b = double(cell2mat(dog_data_only_thresh_60(:,4)))==1;
c = double(cell2mat(dog_data_only_thresh_60(:,4)))==2;
ale_dog_data_only_thresh_60 = dog_data_only_thresh_60(b,:);
cpmc_dog_data_only_thresh_60 = dog_data_only_thresh_60(c,:);
hold off
plot(cell2mat(ale_dog_data_only_thresh_60(:,5))', 'ro');
hold on
plot(cell2mat(cpmc_dog_data_only_thresh_60(:,5))', 'bx');
hold off
plot(cell2mat(ale_dog_data_only_thresh_60(:,6))', 'ro');
hold on
plot(cell2mat(cpmc_dog_data_only_thresh_60(:,6))', 'bx');
hold off
plot(cell2mat(ale_dog_data_only_thresh_60(:,7))', 'ro');
hold on
plot(cell2mat(cpmc_dog_data_only_thresh_60(:,7))', 'bx');
hold off
plot(cell2mat(ale_dog_data_only_thresh_60(:,8))', 'ro');
hold on
plot(cell2mat(cpmc_dog_data_only_thresh_60(:,8))', 'bx');
a = double(cell2mat(dog_data_only(:,2)))>60;
dog_data_only_thresh_60 = dog_data_only(a,:);
b = double(cell2mat(dog_data_only_thresh_60(:,4)))==1;
c = double(cell2mat(dog_data_only_thresh_60(:,4)))==2;
ale_dog_data_only_thresh_60 = dog_data_only_thresh_60(b,:);
cpmc_dog_data_only_thresh_60 = dog_data_only_thresh_60(c,:);
hold off
plot(cell2mat(ale_dog_data_only_thresh_60(:,8))', 'ro');
hold on
plot(cell2mat(cpmc_dog_data_only_thresh_60(:,8))', 'bx');
h = hist(cell2mat(dog_data_only_thresh_60(:,8)));
plot (h)
bar(h)
[a,h] = hist(cell2mat(dog_data_only_thresh_60(:,8)));
help hist
help histc
min8 =min(cell2mat(dog_data_only_thresh_60(:,8))));
min8 =min(cell2mat(dog_data_only_thresh_60(:,8)));
max8 =max(cell2mat(dog_data_only_thresh_60(:,8)));
x = linspace(min8,max8,5);
[n,bins] = histc(cell2mat(dog_data_only_thresh_60(:,8))),x);
[n,bins] = histc(cell2mat(dog_data_only_thresh_60(:,8)),x);
plot(n)
plot(n')
bar(n')
plot(bins)
a = double(cell2mat(dog_data_only(:,2)))>80;
dog_data_only_thresh_80 = dog_data_only(a,:);
b = double(cell2mat(dog_data_only_thresh_80(:,4)))==1;
c = double(cell2mat(dog_data_only_thresh_80(:,4)))==2;
ale_dog_data_only_thresh_80 = dog_data_only_thresh_80(b,:);
cpmc_dog_data_only_thresh_80 = dog_data_only_thresh_80(c,:);
hold off
plot(cell2mat(ale_dog_data_only_thresh_80(:,8))', 'ro');
hold on
plot(cell2mat(cpmc_dog_data_only_thresh_80(:,8))', 'bx');
[n,bins] = histc(cell2mat(dog_data_only_thresh_60(:,8))),x);
[n,bins] = histc(cell2mat(dog_data_only_thresh_60(:,8)),x);
bar(bins)
plot(bins, 'ro')
dog_data_only_thresh_60_binned_8(:,8) = bins;
b = double(cell2mat(dog_data_only_thresh_60(:,4)))==1;
c = double(cell2mat(dog_data_only_thresh_60(:,4)))==2;
ale_dog_data_only_thresh_60_binned_8 = dog_data_only_thresh_60_binned_8(b,:);
cpmc_dog_data_only_thresh_60_binned_8 = dog_data_only_thresh_60_binned_8(c,:);
hold off
plot(cell2mat(ale_dog_data_only_thresh_60_binned_8(:,8))', 'ro');
ale_dog_data_only_thresh_60_binned_8(:,8)
plot((ale_dog_data_only_thresh_60_binned_8(:,8))', 'ro');
hold on
plot((cpmc_dog_data_only_thresh_60_binned_8(:,8))', 'bx');
legend('ALE', 'CPMC')
ylabel('Sample Value');
xlabel('Sample ID');
x a = double(cell2mat(dog_data_only(:,2)))>80;dog_data_only_thresh_80 = dog_data_only(a,:);
a = double(cell2mat(dog_data_only(:,2)))>80;dog_data_only_thresh_80 = dog_data_only(a,:);
b = double(cell2mat(dog_data_only_thresh_80(:,4)))==1;
c = double(cell2mat(dog_data_only_thresh_80(:,4)))==2;
ale_dog_data_only_thresh_80 = dog_data_only_thresh_80(b,:);
cpmc_dog_data_only_thresh_80 = dog_data_only_thresh_80(c,:);
[n,bins] = histc(cell2mat(dog_data_only_thresh_80(:,8))),x);
[n,bins] = histc(cell2mat(dog_data_only_thresh_80(:,8)),x);
dog_data_only_thresh_80_binned_8(:,8) = bins;
b = double(cell2mat(dog_data_only_thresh_80_binned_8(:,4)))==1;
b = double((dog_data_only_thresh_80_binned_8(:,4)))==1;
b = double(cell2mat(dog_data_only_thresh_80(:,4)))==1;
c = double(cell2mat(dog_data_only_thresh_80(:,4)))==2;
ale_dog_data_only_thresh_80_binned_8 = dog_data_only_thresh_80_binned_8(b,:);
cpmc_dog_data_only_thresh_80_binned_8 = dog_data_only_thresh_80_binned_8(c,:);
hold off
plot((ale_dog_data_only_thresh_80_binned_8(:,8))', 'ro');
plot((ale_dog_data_only_thresh_60_binned_8(:,8))', 'ro');
hold on
plot((cpmc_dog_data_only_thresh_60_binned_8(:,8))', 'bx');
hold off
plot((ale_dog_data_only_thresh_80_binned_8(:,8))', 'ro');
hold on
plot((cpmc_dog_data_only_thresh_80_binned_8(:,8))', 'bx');
plot((cpmc_dog_data_only_thresh_80_binned_8(:,8))', 'bx', 'width' '2');
plot((cpmc_dog_data_only_thresh_80_binned_8(:,8))', 'bx', 'width', '2');
plot((cpmc_dog_data_only_thresh_80_binned_8(:,8))', 'bx', 'line_width', '2');
plot((cpmc_dog_data_only_thresh_80_binned_8(:,8))', 'bx', 'line width', '2');
plot((cpmc_dog_data_only_thresh_80_binned_8(:,8))', 'bx', 'Line Width', '2');
plot((cpmc_dog_data_only_thresh_80_binned_8(:,8))', 'bx', 'markersize', '2');
plot((cpmc_dog_data_only_thresh_80_binned_8(:,8))', 'bx', 'markersize', 2);
plot((cpmc_dog_data_only_thresh_80_binned_8(:,8))', 'bx', 'markersize', 20);
plot((cpmc_dog_data_only_thresh_80_binned_8(:,8))', 'br', 'markersize', 20);
plot((cpmc_dog_data_only_thresh_80_binned_8(:,8))', 'b-', 'markersize', 20);
plot((cpmc_dog_data_only_thresh_80_binned_8(:,8))', 'b*', 'markersize', 20);
hold off
plot((ale_dog_data_only_thresh_80_binned_8(:,8))', 'ro',  'markersize', 20);
hold on
plot((cpmc_dog_data_only_thresh_80_binned_8(:,8))', 'b*', 'markersize', 20);
legend('ALE', 'CPMC')
ylabel('Sample Value');
xlabel('Sample ID');
hold off
plot((ale_dog_data_only_thresh_60_binned_8(:,8))', 'ro',  'markersize', 20);
hold on
plot((cpmc_dog_data_only_thresh_60_binned_8(:,8))', 'b*', 'markersize', 20);
legend('ALE', 'CPMC')
ylabel('Sample Value');
xlabel('Sample ID');
hold off

 
%plot label data for feature selected with a
 only_data = results_new(2:end,4:end);
 only_labels = results_new(2:end, 1:3);
 label = 'bottle';
 dlabel = strcmp(only_labels(:,3), label);
 ddata = only_data(dlabel,:);
 b = double(cell2mat(ddata(:,4)))==1;
 c = double(cell2mat(ddata(:,4)))==2;
 ale_ddata = ddata(b,:);
 cpmc_ddata = ddata(c,:);
 a = 32;
 plot(cell2mat(ale_ddata(:,a))', 'ro', 'markersize', 20);hold on;plot(cell2mat(cpmc_ddata(:,a))', 'bx', 'markersize', 20);hold off; legend('ALE', 'CPMC'); xlabel('Sample ID'); ylabel('Sample Values'); title([label ' on ' results_new(1, a)]);
 
 
% calculate the average of results given label at point x in the given
% space given a feature id a
% first determine the min - max of a given feature and then determine how
% wide the region of proximity should be.

 label = 'bottle';
 fval = 6;
 a = 6;
 algo1 = 5; algo2 = 7;
 only_data_results = results(2:end,:);
 label_index = strcmp(only_data_results(:,3), label);
 label_results = only_data_results(label_index,:);
 fcolumn = cell2mat(label_results(:,a+6));
 fmax = max(fcolumn);
 fmin = min(fcolumn);
 %lower and upper bound for selection
 f1 = fval - fmax/100;
 f2 = fval + fmax/100; 
 all_index = (fcolumn > f1) & (fcolumn < f2);
 region_results = label_results(all_index,:);
 both_nil_index = (cell2mat(region_results(:,5)) ==0) & (cell2mat(region_results(:,8)) == 0);
 region_results(both_nil_index,:) = [];
 [i,best_algo] = max([cell2mat(region_results(:,5)), cell2mat(region_results(:,8))]');
 region_results(:,10) = mat2cell(best_algo', ones(2,1), [1]);
 al1mean = mean(cell2mat(region_results(:,5)));
 al2mean = mean(cell2mat(region_results(:,8)));
 
 