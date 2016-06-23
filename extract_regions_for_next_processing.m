function [] = extract_regions_for_next_processing( path, img, level, blur, divide)
%Takes the result of one processing and extract regions based on their
%unique lable and generates bounding boxes and masks the background

%clear all;

%load the rules
%[pos_rules, adj_rules, rel_size_rules, shape_rules] = load_rules();

image_path = '/home/nabhoth/codes/vision_algorithms/VOCdevkit/VOC2012/JPEGImages/';
if blur 
    out_path = [path '_blur_level_' sprintf('%d',level)];
else
    out_path = [path '_mask_level_' sprintf('%d',level)];
end
% read in image
gtim = imread([path '/' img '.png']);
original = imread([image_path img '.jpg']);
result = imread([image_path img '.jpg']);
[h,w,z] = size(original);
u_labels = unique(gtim);
%if u_labels(1) == 0
%    u_labels = u_labels(2:end);
%end
if u_labels(end) == 255
    u_labels = u_labels(1:end-1);
end
for j=1:length(u_labels)
    j_gtim = (gtim == u_labels(j));
    gcount = sum(sum(j_gtim));
    cj_gtim = imcomplement(j_gtim);
    result_path = [out_path '_hypothesis_' sprintf('%d%',j)]; 
    mkdir(result_path);
    im = result;
    if (blur)
        H = fspecial('disk',30);
        result = imfilter(result,H,'replicate');
        for a=1:h
            for b=1:w
                if j_gtim(a,b) == 1
                    result(a,b,:) = original(a,b,:);
                end
            end
        end
        
        %newim = imnoise(newim,'salt & pepper',0.8);
    else
        goriginal = rgb2gray(original);
        result = im2double(original).*repmat(j_gtim,[1,1,3]);
        ggoriginal = im2double(goriginal).*j_gtim;
        gsum =  sum(sum(ggoriginal))
%         gsum = 0;
%         gcount = 0;
%         for a=1:h
%             for b=1:w
%                 if j_gtim(a,b) == 1
%                     gsum = gsum + goriginal(a,b);
%                     gcount = gcount + 1;
%                 end
%             end
%         end
        gsum = gsum / gcount;
        if (gsum < 0.5)
            result = im2double(result)+repmat(cj_gtim,[1,1,3]);
        end
    end
%    newim(y1:y2,x1:x2,:) = im2double(im);
    [hh,ww] = size(result);
    if (hh > 50 && ww > 50)
    imshow(result)
    imwrite(result, [result_path '/' img '.jpg']);
    end
    end
end
