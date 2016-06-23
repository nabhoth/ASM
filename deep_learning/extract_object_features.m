% extracts features of each object within its bounding box
% the object ids are the same as in database

p = '/home/alexandra/Documents/';
addpath(genpath([p 'libsvm-3.20']));
addpath(genpath([p 'segbench/lib/matlab']));
addpath(genpath([p 'vlfeat-0.9.17/toolbox']));
addpath(genpath ([p 'VOCdevkit/VOCcode']));
rmpath([p 'vlfeat-0.9.17/toolbox/noprefix']); 

voc_images='./images_voc2012/';

VOCinit;
[gtids, ~]=textread(sprintf(VOCopts.seg.imgsetpath,VOCopts.testset),'%s %d');


output_path = '../data/';
mkdir([output_path '/from_whole_images_best_analysis/']);

for n=1:length(gtids)
    imname = gtids{n};   
    im = imread([voc_images imname '.jpg']);
   
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
        if ((recs.objects(j).bbox(4) - recs.objects(j).bbox(2) > 20) && (recs.objects(j).bbox(3)-recs.objects(j).bbox(1) > 20))
            try
                obj_im = im(recs.objects(j).bbox(2):recs.objects(j).bbox(4), recs.objects(j).bbox(1):recs.objects(j).bbox(3),:);
                % imshow(obj_im)

                get_cnn_features(obj_im, jgtids, 1, 'obj_features/');
            catch exception
                getReport(exception)
                continue
            end
        end
    end
end
