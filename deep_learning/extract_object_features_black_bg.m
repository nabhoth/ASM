% extracts features of each object when its background is removed and is plain black.
% WARNING! THERE IS NO WAY OF CORRELATING THE OBJECTS WHEN THERE ARE
% SEVERAL OF THEM OF THE SAME CLASS. ALGORITHM WORKS CORRECTLY MOST
% CASES BUT IT WILL FAIL ON SOME PICTURES (it will catch the error and proceed)

p = '/home/alexandra/Documents/';
addpath(genpath([p 'libsvm-3.20']));
addpath(genpath([p 'segbench/lib/matlab']));
addpath(genpath([p 'vlfeat-0.9.17/toolbox']));
addpath(genpath ([p 'VOCdevkit/VOCcode']));
rmpath([p 'vlfeat-0.9.17/toolbox/noprefix']); 

voc_images='./images_voc2012/';
seg_objects = '/media/top/VOC/SegmentationObject/';

VOCinit;
[gtids, ~]=textread(sprintf(VOCopts.seg.imgsetpath,VOCopts.testset),'%s %d');


output_path = '../data/';
mkdir([output_path '/from_whole_images_best_analysis/']);

for n=1:length(gtids)
    imname = gtids{n};   
    im = imread([voc_images imname '.jpg']);
        
    gtfile = sprintf(VOCopts.seg.clsimgpath,imname);
    gtim = double(imread(gtfile));

    recs=PASreadrecord(sprintf(VOCopts.annopath,imname));
  
    for j=1:numel(recs.objects)
        if (j > 9)
            jgtids = strrep(imname, '_00', sprintf('_%d',j));
        else
            jgtids = strrep(imname, '_00', sprintf('_0%d',j));            
        end
                  
        % extract objects of class
        gt=struct('BB',[],'diff',[],'det',[], 'indx', []);
        gt.BB=cat(1,recs.objects(j).bbox)';
        gt.diff=[recs.objects(j).difficult];
        gt.det=false(length(j),1);
        gt.indx = find(ismember(VOCopts.classes, recs.objects(j).class));
        % recs.objects(j).class
             
        obj_im = imread([seg_objects imname '.png']);
        dif_obj = unique(obj_im);
        
        if dif_obj(1) == 0
        	dif_obj = dif_obj(2:end); % removing black color
        end
        if dif_obj(end) == 255
            dif_obj = dif_obj(1:end-1);  % removing white color
        end
        
        if ~isempty(dif_obj)
            try
                mask = (obj_im == dif_obj(j));        
                mask_im = zeros(size(gtim,1), size(gtim,2), 3);
                mask_im(:,:,1) = mask;
                mask_im(:,:,2) = mask;
                mask_im(:,:,3) = mask;
                im_to_process = im.*uint8(mask_im);
                im_to_process = im_to_process(recs.objects(j).bbox(2):recs.objects(j).bbox(4), recs.objects(j).bbox(1):recs.objects(j).bbox(3),:);
                imshow(im_to_process)

                get_cnn_features(im_to_process, jgtids, 1, 'obj_features/');
            catch exception
                getReport(exception)
                continue
            end
        end
    end    
end