function [] = generate_data_for_bn_training_bb(  )
%
clear all;
VOCinit;
% image test set

[gtids,t]=textread(sprintf(VOCopts.seg.imgsetpath,VOCopts.trainset),'%s %d');
%output path
output_path = '/mnt/images/2/VOC2012/Regions/JPEGImages/';
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
ids = {'prefix','postfix','object id', 'classname', 'bounding box'};
feats = {'brightness','fft','Gabor edges',...
    'wavelets1', 'wavelets2', 'wavelets3', 'wavelets4',...
    'contrast', 'accutance', 'gist', 'colorR','colorG','colorB',...
    'grey regions1','grey regions2','grey regions3','grey regions4',...
    'bw regions1','bw regions2','bw regions3','bw regions4'};
texts = cell(1,64);
%feats = {'Textures 1','Textures 2','Textures 3',...
%     'Textures 4', 'Textures 5', 'Textures 6', 'Textures 7',...
%     'Textures 8'};
for j=1:64
    texts{1,j} = sprintf('Texture %d',j);
end
names = cell(1,numel(ids)+numel(feats)+numel(texts)+numel(attributes(1,2:end)));
names(all_count,1:5) = ids;
names(all_count,6:26) = feats;
names(all_count,27:90) = texts;
names(all_count,91:end) = attributes(1,2:end);

mapping = cell(length(gtids),numel(names));
l = length(names);
mapping(all_count,1:l) = names(all_count:l);
all_count = all_count + 1;

for n=1:length(gtids)

     try
        
    imname = gtids{n}


    infile = sprintf(VOCopts.imgpath,imname);
    [inim] = imread(infile);
    [h,w] = size(inim);
    
    gtfile = sprintf(VOCopts.seg.clsimgpath,imname);
    [gtim] = imread(gtfile);
    gtim = double(gtim);

    %read salience
    sfile = sprintf(VOCopts.imgpath,imname);
    sfile =  [sfile(1:end-4) '_salience.jpg']
    [sim] = imread(sfile);
    [sh,~,~] = size(sim);
    if sh ~= h
        sim = imresize(sim, [h w]);
    end
    %sim = double(sim);
    
    %read edge image
    efile = sprintf(VOCopts.imgpath,imname);
    efile = [efile(1:end-4) '_edge.ppm'];
    [eim] = imread(efile);
    [eh,~,~] = size(eim);
    if eh ~= h
        eim = imresize(eim, [h w]);
    end    
    eim = double(eim);
    
    %get the bounding box for all objects
    % read annotation
    recs=PASreadrecord(sprintf(VOCopts.annopath,imname));

    
    for j=1:numel(recs.objects)
        if (j > 9)
            jgtids = strrep(gtids{n}, '_00', sprintf('_%d',j));
        else
            jgtids = strrep(gtids{n}, '_00', sprintf('_0%d',j));            
        end
        out_names{all_count} = jgtids;
        
        % extract objects of class
        gt=struct('BB',[],'diff',[],'det',[]);
        gt.BB=cat(1,recs.objects(j).bbox)';
        gt.diff=[recs.objects(j).difficult];
        gt.det=false(length(j),1);
        inimsub = inim(recs.objects(j).bbox(2):recs.objects(j).bbox(4), recs.objects(j).bbox(1):recs.objects(j).bbox(3),:);
        eimsub = eim(recs.objects(j).bbox(2):recs.objects(j).bbox(4), recs.objects(j).bbox(1):recs.objects(j).bbox(3),:);
        simsub = sim(recs.objects(j).bbox(2):recs.objects(j).bbox(4), recs.objects(j).bbox(1):recs.objects(j).bbox(3),:);

        try
            size(inimsub)
            mapping{all_count,1} = jgtids(1:4);
            mapping{all_count,2} = jgtids(6:end);
            mapping{all_count,3} = j;
            mapping{all_count,4} = recs.objects(j).class;
            mapping{all_count,5} = recs.objects(j).bbox;
            recs.objects(j).bbox
            %get_features_bn(inimsub)
            mapping(all_count, 6:26) = get_features_bn(inimsub);
            %get_textures
            [~,~,tmap] = detTG(inimsub);
            text_k =zeros(1,64);
            for i=1:64
               text_k(1,i) = numel(tmap(tmap == i));
            end
            mapping(all_count, 27:90) = num2cell(text_k);
            %attributes(strcmp(mapping{all_count,4},attributes(:,1))>0,2:14)
            mapping(all_count, 91:end) = attributes(strcmp(mapping{all_count,4},attributes(:,1))>0,2:end);
            %mapping(all_count,:)
            all_count = all_count + 1;
            sprintf('Hello')
        catch
            
        end 
        
        outfile = [output_path jgtids '.jpg'];
        imwrite(inimsub, outfile,'JPG');
        outfile = [output_path jgtids '_edge.jpg'];
        imwrite(eimsub, outfile,'JPG');
        outfile = [output_path jgtids '_salience.jpg'];
        imwrite(simsub, outfile,'JPG');
        outfile = [output_path jgtids '.jpg'];

    end
    catch
        
    end
end
save([output_path 'Features_Hypothesis_Regions_Mapping_BN.mat'], 'mapping');
%save([output_path 'train.txt'], 'out_names', '-ascii');

