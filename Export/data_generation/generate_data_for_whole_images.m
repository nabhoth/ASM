function [mapping] = generate_data_for_whole_images()
%
clear all;
VOCinit;
% image test set
p = '/home/kamila/Documents/';
addpath(genpath([p 'libsvm-3.20']));
addpath(genpath([p 'segbench/lib/matlab']));
addpath(genpath([p 'vlfeat-0.9.17/toolbox']));

rmpath([p 'vlfeat-0.9.17/toolbox/noprefix']);


path_init = '/media/kamila/3c82bfeb-15c9-4f45-b9d7-861e6410ad5c/';
im_path = [path_init 'top/2/VOC2012/JPEGImages/'];
%im_path = '/home/kam/Documents/Image_Understanding/data/JPEGImages/2007_010480.jpg'
[gtids,t]=textread(sprintf(VOCopts.seg.imgsetpath,VOCopts.testset),'%s %d');
output_path = './data/from_whole_images_best_analysis/';
%output_path = '/home/lukacm/matlab/Image_Understanding/data/VOC2012/Regions/JPEGImages/';
%output_path = '/home/nabhoth/codes/vision_algorithms/VOCdevkit/BN_Training_Images/';
load('./data/Grouped_Attributes_Hypothesis_Regions_Mapping.mat');
out_names = cell(10, 1);
%%just for fun keep it close
classnames = {'aeroplane', 'bicycle', 'bird', 'boat', 'bottle', 'bus', 'car', 'cat', 'chair', ...
    'cow', 'diningtable', 'dog', 'horse', 'motorbike', 'person', ...
    'pottedplant', 'sheep', 'sofa', 'train', 'tvmonitor'};

%nclass = VOCopts.classes+1;
%confcounts = zeros(num);
all_count = 1;
ids = {'prefix','postfix','object id', 'classname', 'bounding box'};

temp = cell(1,256);
for j=1:256
    temp{1,j} = sprintf('brightness %d',j);
end

feats = temp;

temp = cell(1,255);
for j=1:255
    temp{1,j} = sprintf('fft %d',j);
end
feats = [feats temp];

temp = cell(1,255);
for j=1:255
    temp{1,j} = sprintf('gabor %d',j);
end
feats = [feats temp];

temp = cell(1,256);
for j=1:256
    temp{1,j} = sprintf('wavelets1_%d',j);
end
feats = [feats temp];

temp = cell(1,255);
for j=1:255
    temp{1,j} = sprintf('wavelets2_%d',j);
end
feats = [feats temp];


temp = cell(1,255);
for j=1:255
    temp{1,j} = sprintf('wavelets3_%d',j);
end
feats = [feats temp];

temp = cell(1,255);
for j=1:255
    temp{1,j} = sprintf('wavelets4_%d',j);
end
feats = [feats temp];

feats = [feats {'contrast'} {'accutance'}];

temp = cell(1,320);
for j=1:320
    temp{1,j} = sprintf('gist_%d',j);
end
feats = [feats temp];

temp = cell(1,256);
for j=1:256
    temp{1,j} = sprintf('colorR_%d',j);
end
feats = [feats temp];

temp = cell(1,256);
for j=1:256
    temp{1,j} = sprintf('colorG_%d',j);
end
feats = [feats temp];

temp = cell(1,256);
for j=1:256
    temp{1,j} = sprintf('colorB_%d',j);
end
feats = [feats temp];

temp = cell(1,128);
for j=1:128
    temp{1,j} = sprintf('grey regions%d',j);
end
feats = [feats temp];

temp = cell(1,66);
for j=1:66
    temp{1,j} = sprintf('bw regions%d',j);
end
feats = [feats temp];


temp = cell(1,10);
for j=1:10
    temp{1,j} = sprintf('harris%d',j);
end
feats = [feats temp];


temp = cell(1,20);
for j=1:20
    temp{1,j} = sprintf('sobel%d',j);
end
feats = [feats temp];


temp = cell(1,20);
for j=1:20
    temp{1,j} = sprintf('canny%d',j);
end
feats = [feats temp];


temp = cell(1,20);
for j=1:20
    temp{1,j} = sprintf('prewitt%d',j);
end
feats = [feats temp];


temp = cell(1,510);
for j=1:510
    temp{1,j} = sprintf('covdetedgeHL%d',j);
end
feats = [feats temp];

temp = cell(1,510);
for j=1:510
    temp{1,j} = sprintf('covdetedgeDoG%d',j);
end
feats = [feats temp];


temp = cell(1,510);
for j=1:510
    temp{1,j} = sprintf('covdetedgeHes%d',j);
end
feats = [feats temp];

temp = cell(1,510);
for j=1:510
    temp{1,j} = sprintf('covdetedgeHesLap%d',j);
end
feats = [feats temp];


temp = cell(1,510);
for j=1:510
    temp{1,j} = sprintf('covdetedgeMultHes%d',j);
end
feats = [feats temp];

temp = cell(1,510);
for j=1:510
    temp{1,j} = sprintf('covdetedgeMultHar%d',j);
end
feats = [feats temp];


temp = cell(1,255);
for j=1:255
    temp{1,j} = sprintf('sift%d',j);
end
feats = [feats temp];


temp = cell(1,1209);
for j=1:1209
    temp{1,j} = sprintf('hog%d',j);
end
feats = [feats temp];


temp = cell(1,128);
for j=1:128
    temp{1,j} = sprintf('mser%d',j);
end
feats = [feats temp];

texts = cell(1,64);
for j=1:64
    texts{1,j} = sprintf('Texture %d',j);
end
feats = [feats texts];

names = cell(1,numel(ids)+numel(feats)+numel(attributes(1,2:end)));
names(all_count,1:5) = ids;
names(all_count,6:numel(feats)+5) = feats;
names(all_count,numel(feats)+6:end) = attributes(1,2:end);
mapping = cell(length(gtids),numel(names));
l = length(names);
mapping(all_count,1:l) = names(all_count:l);
all_count = all_count + 1;

temp = attributes(2:end, :);
temp = temp(:, 2:end);
temp = num2cell(mean(cell2mat(temp),1));

for n=1:length(gtids)
     try        
    imname = gtids{n};
    infile = [im_path imname '.jpg']; 
    %infile = im_path ; 
    [inim] = imread(infile);        
        try
            mapping{all_count,1} = imname(1:4);
            mapping{all_count,2} = imname(6:end);
            mapping{all_count,3} = 0;
            mapping{all_count,4} = 0;
            mapping{all_count,5} = 0;
            mapping(all_count, 6:numel(feats)+5) = get_features_bn(inim);            
            mapping(all_count, numel(feats)+6:end) = temp;
            all_count = all_count + 1;
        catch err
        getReport(err)           
        end     
    %%%%%%%%%%%%%
     catch err
        getReport(err)
    end
end

save([output_path 'Features_Hypothesis_Whole_Image_Mapping_extended.mat'], 'mapping', '-v7.3');
%save([output_path 'train.txt'], 'out_names', '-ascii');
