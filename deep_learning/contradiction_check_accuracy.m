% This script checks the accuracy of contradiction check
clc;
clear;

true_negatives = 0; % no contradiction and it should be like it
false_positives = 0; % there is contradiction and it should not be like it
single_obj_images = 0;

ground_truth_path = '/media/top/2/VOC2012/SegmentationClass/';
files = dir(fullfile(ground_truth_path, '*.png'));
files = {files.name}'; 

for i = 1:length(files)
    sprintf(['Processing ' files{i}])
    is_false_pos = 0;
    imid = files{i}(1:end-4);
    inim = imread([ground_truth_path files{i}]);

    [result, ~] = imread([ground_truth_path files{i}]);
    
    %removing white color
    [x,y] = find(result==255);
    for j=1:length(x)
        result(x(j),y(j)) = 0;
    end
    
    dif_obj_num = unique(result);
    s_size = size(dif_obj_num);
       
    if s_size(1) > 2
        [area, pos_errors, pos_hypotheses, adj_errors, adj_hypotheses, shape_errors, shape_hypotheses, rel_size_errors, rel_size_hypotheses] = contradiction_check(path, result);
        
        if isempty(area)
            continue
        end
        
        dif_obj_num = dif_obj_num(2:end); %removing black color - 0
        hypo_obj = unique([area{1:end,1}]');
        
        % checking if an image and hypothesis have the same objects. if
        % they do then contradiction check was correct.
        if size(hypo_obj) == size(dif_obj_num)
            if (hypo_obj == dif_obj_num)
            	true_negatives = true_negatives + 1;
            end
        else
            false_positives = false_positives + 1;
        end 
                  

    else
        single_obj_images = single_obj_images + 1;
    end 

end

accuracy = true_negatives / (true_negatives + false_positives);
