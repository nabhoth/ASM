function [mapping] = generate_data_for_bn_training_masking(  )
%
clear all;
VOCinit;
% image test set
[gtids,t]=textread(sprintf(VOCopts.seg.imgsetpath,VOCopts.trainset),'%s %d');
%output path
output_path = '/mnt/images/2/VOC2012/Regions/';
%output_path = '/home/nabhoth/codes/vision_algorithms/VOCdevkit/BN_Training_Images/';
load('/mnt/images/2/VOC2012/Categories/Grouped_Attributes_Hypothesis_Regions_Mapping.mat');
out_names = cell(10, 1);
%%just for fun keep it close
classnames = {'aeroplane', 'bicycle', 'bird', 'boat', 'bottle', 'bus', 'car', 'cat', 'chair', ...
    'cow', 'diningtable', 'dog', 'horse', 'motorbike', 'person', ...
    'pottedplant', 'sheep', 'sofa', 'train', 'tvmonitor'};

%nclass = VOCopts.classes+1;
%confcounts = zeros(num);
all_count = 1;
mapping = cell(length(gtids)*5,10);
names ={'prefix','postfix','scale type','scale factor','classname','brightness','fft','edges','color','grey regions','bw regions', attributes(1,2:14)};
l = length(names);
mapping(all_count,1:l) = names(all_count:l);
all_count = all_count + 1;

for n=1:length(gtids)
    counter = 1;
    imname = gtids{n};

    infile = sprintf(VOCopts.imgpath,imname);
    [inim] = imread(infile);
    [h,w] = size(inim);
%    inim = double(inim);

    gtfile = sprintf(VOCopts.seg.clsimgpath,imname);
    [gtim] = imread(gtfile);
    gtim = double(gtim);
    
    %get the bounding box for all objects
    % read annotation
    recs=PASreadrecord(sprintf(VOCopts.annopath,gtids{n}));

    
    for j=1:numel(recs.objects)
        if (j > 9)
            jgtids = strrep(gtids{n}, '_00', sprintf('_%d',counter));
        else
            jgtids = strrep(gtids{n}, '_00', sprintf('_0%d',counter));            
        end
        out_names{all_count} = jgtids;
        % extract objects of class
        gt=struct('BB',[],'diff',[],'det',[]);
        gt.BB=cat(1,recs.objects(j).bbox)';
        gt.diff=[recs.objects(j).difficult];
        gt.det=false(length(j),1);
        outfile = [output_path jgtids '.jpg'];

        mask = gtim(recs.objects(j).bbox(2):recs.objects(j).bbox(4), recs.objects(j).bbox(1):recs.objects(j).bbox(3));
        maskborder = mask ~= 255;
        maskback = mask ~= 0;
        mask = im2bw(mask .* maskborder .* maskback);
        outim = im2double(inim(recs.objects(j).bbox(2):recs.objects(j).bbox(4), recs.objects(j).bbox(1):recs.objects(j).bbox(3),:));

        
        %outim = imadjust(outim,[.2 .3 0; .6 .7 1],[]);
        %outim = brighten(outim,0.2);

        outim = outim.* repmat(mask,[1,1,3]);
        mapping{all_count,1} = jgtids(1:4);
        mapping{all_count,2} = jgtids(6:end);
        mapping{all_count,5} = recs.objects(j).class;
        mapping = get_feats(outim,mask,mapping,all_count,6);
        
         [ho,wo] = size(outim);
         hscale = 300/ho;
         wscale = 300/wo;
         if (ho <  250)
             outim = imresize(outim, hscale, 'bilinear');
             mapping{all_count,3} = 'ho scale';
             mapping{all_count,4} = ho/300;
         else if (wo < 250)
                 outim = imresize(outim, wscale, 'bilinear');
                 mapping{all_count,3} = 'wo scale';
                 mapping{all_count,4} = wo/300;
             end
         end
        
        imwrite(outim,outfile, 'JPG');
        counter = counter + 1;
        all_count = all_count + 1;
    end

end
%out_names = cell2mat(out_names);
fileID = fopen([output_path 'train.txt'], 'w');
for i=1:length(out_names)
    fprintf(fileID, '%s\n',out_names{i});
end
fclose(fileID);
save([output_path 'results.mat'], 'mapping');
%save([output_path 'train.txt'], 'out_names', '-ascii');

