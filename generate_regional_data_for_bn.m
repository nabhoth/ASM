function [] = generate_regional_data_for_bn(  )
% prepare training/testing data for training/testing of algorithms 
% for each region corresponding to a particular hypothesis represented by a
% bounding box (approximate hypothesis) features and attributes are extracted 



clear all;
VOCinit;

ale_res_path='/ale_results/%s.png';
cpmc_res_path='/cpmc_res_path/%s.png';
attributes = importdata([rule_paths 'BN-Table.csv']);
% image test set
[gtids,t]=textread(sprintf(VOCopts.seg.imgsetpath,VOCopts.trainset),'%s %d');
%output path
output_path = '/mnt/images/Contradiction/';

nclass = VOCopts.classes+1;
confcounts = zeros(num);

train_data = zeros(length(gtids),(11+69));
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
%        outfile = [output_path gtids{n} '_' sprintf('%d',counter) '-' recs.objects(j).class '.jpg'];
        gtimsub = gtim(recs.objects(j).bbox(2):recs.objects(j).bbox(4), recs.objects(j).bbox(1):recs.objects(j).bbox(3),:);

        [ho,wo] = size(gtimsub);
        hscale = 300/ho;
        wscale = 300/wo;
        if (ho <  250)
            outim = imresize(gtimsub, hscale);
        else if (wo < 250)
                outim = imresize(gtimsub, wscale);
            end
        end
        save(strcat(dir_path,'/', prefx,'_Features_Whole_Images_mapping.mat'), 'feats', '-v7.3');
           
%        imshow(outim)
        imwrite(outim,outfile, 'JPG');
        counter = counter + 1;
        all_count = all_count + 1;
    end
    
end


