function [ gtids, pos_rules, adj_rules, rel_size_rules, shape_rules ] = create_rules(  )
%create_rules() takes the set of labels, ane extracts rules for
%contradiction detection based on statistical evidence of proximity and
%position
%   Outputs:
%       rules - a set of symbolic rules organized in a tabular format
%       pos_rules: contradiction generation rules using relative position
%       of different classes
%       adj_rules: contradiction generation rules using relative adjacency
%       of different regions
%       rel_size_rules: contradiction generation rules using relative size
%       of different classes
%       shape_rules: contradiction generation rules using shape properties
%       of class

clear all;
VOCinit;

%%just for fun keep it close
% classnames = {'aeroplane', 'bicycle', 'bird', 'boat', 'bottle', 'bus', 'car', 'cat', 'chair', ...
%     'cow', 'diningtable', 'dog', 'horse', 'motorbike', 'person', ...
%     'pottedplant', 'sheep', 'sofa', 'train', 'tvmonitor'};

%output path
output_path = '/mnt/images/1/Contradiction/';

% image test set
[gtids,t]=textread(sprintf(VOCopts.seg.imgsetpath,VOCopts.trainset),'%s %d');

nclass = numel(VOCopts.classes);

%the occurences of each objects
[occurences{1:VOCopts.nclasses}] = deal([]);
 occurences
% rule set
up_rules = zeros(nclass,nclass);
down_rules = zeros(nclass,nclass);
left_rules = zeros(nclass,nclass);
right_rules = zeros(nclass,nclass);
pos_rules = zeros(nclass,nclass,4);
rel_size_rules = zeros(nclass,nclass);
adj_rules = zeros(nclass,nclass);
shape_rules = zeros(nclass,7);


for n=1:length(gtids)
    
    imname = gtids{n};
    %relative position contradiction rules
    sprintf(VOCopts.seg.clsimgpath,imname)
    gtfile = sprintf(VOCopts.seg.clsimgpath,imname);
    [gtim] = imread(gtfile);
    [h,w] = size(gtim);
    gtpixels = h*w;
    area = [];
    u_labels = unique(gtim);
    if u_labels(1) == 0
        u_labels = u_labels(2:end);
    end
    if u_labels(end) == 255
        u_labels = u_labels(1:end-1);
    end
    
        centroids = {};
    for j=1:length(u_labels)
%        u_labels
        j_gtim = (gtim == u_labels(j));
        Labs = bwlabel(gtim == u_labels(j),8);
        uniquel = unique(Labs);
        uniquel = uniquel(2:end);
        for k = 1:numel(uniquel)
            
            lol = bwboundaries(Labs == uniquel(k));
            for u=2:numel(lol)
                if numel(lol(u)) > numel(lol(1))
                    lol(1) = lol(u);
                end
            end
            j_area =  regionprops(Labs == uniquel(k), 'All');
            
            shape_props(1) = j_area(1).Area/gtpixels;
            %relative bounding box
            bb = j_area(1).BoundingBox(3)*j_area(1).BoundingBox(4);
            shape_props(2) = bb/gtpixels;
            %relative convex area pixels
            shape_props(3) = j_area(1).ConvexArea/gtpixels;
            %relative eccentricity
            shape_props(4) = j_area(1).Eccentricity/gtpixels;
            %Euler number
            shape_props(5) = j_area(1).EulerNumber/gtpixels;
            %Extent number
            shape_props(6) = j_area(1).Extent;
            %Solidity
            shape_props(7) = j_area(1).Solidity;
            %Solidity
            shape_props(7) = j_area(1).Solidity;
            
            if shape_props(1) > 0.00005
                data = {double(u_labels(j)), j_area(1).Centroid(1), j_area(1).Centroid(2), j_area(1).Area, lol(1), shape_props};
                occurences{u_labels(j)} = occurences{u_labels(j)} + 1;
                centroids = cat(1,centroids, data);
            end
            %         centroids = [];
%         j_gtim = (gtim == u_labels(j));
%         j_area =  regionprops(j_gtim, 'All');
%         for i=1:numel(j_area)
%             centroids = cat(1,centroids, j_area(i).Centroid);
%         end
%         centroids =  round(padarray(centroids,[0 1],u_labels(j), 'pre'));
%         area = cat(1,area,centroids);
        end
    end
    
%   area = sortrows(centroids,2);
   area = centroids;
    [x,y] = size(area);
    sprintf('position')
    for j=1:x,
        for k=1:x,
            if (j ~= k)
                distx = area{j,2} - area{k,2};
                disty = area{j,3} - area{k,3};
                alpha = disty/distx;
                angle = abs(atand(alpha));
                if (distx > 0)
                    if (disty > 0)
                        %upper left quadrant
                        if angle > 0 && angle < 45
                            up_rules(area{j,1},area{k,1}) = (up_rules(area{j,1},area{k,1}) + 0.5);%/2;
                            left_rules(area{j,1},area{k,1}) = (left_rules(area{j,1}, area{k,1}) + 1);%/2;
                        else if angle >= 45 && angle < 90
                                up_rules(area{j,1},area{k,1}) = (up_rules(area{j,1},area{k,1}) + 1);%/2;
                                left_rules(area{j,1},area{k,1}) = (left_rules(area{j,1}, area{k,1}) + 0.5);%/2;
                            end
                        end
                    else
                        %lower left quadrant
                        if angle > 0 && angle < 45
                            down_rules(area{j,1},area{k,1}) = (up_rules(area{j,1},area{k,1}) + 0.5);%/2;
                            left_rules(area{j,1},area{k,1}) = (left_rules(area{j,1}, area{k,1}) + 1);%/2;
                        else if angle >= 45 && angle < 90
                                down_rules(area{j,1},area{k,1}) = (up_rules(area{j,1},area{k,1}) + 1);%/2;
                                left_rules(area{j,1},area{k,1}) = (left_rules(area{j,1}, area{k,1}) + 0.5);%/2;
                            end
                        end
                        
                    end
                else
                    if (disty > 0)
                        %upper right quadrant
                        if angle > 0 && angle < 45
                            up_rules(area{j,1},area{k,1}) = (up_rules(area{j,1},area{k,1}) + 0.5);%/2;
                            right_rules(area{j,1},area{k,1}) = (left_rules(area{j,1}, area{k,1}) + 1);%/2;
                        else if angle >= 45 && angle < 90
                                up_rules(area{j,1},area{k,1}) = (up_rules(area{j,1},area{k,1}) + 1);%/2;
                                right_rules(area{j,1},area{k,1}) = (left_rules(area{j,1}, area{k,1}) + 0.5);%/2;
                            end
                        end
                    else
                        %lower right quadrant
                        if angle > 0 && angle < 45
                            down_rules(area{j,1},area{k,1}) = (up_rules(area{j,1},area{k,1}) + 0.5);%/2;
                            right_rules(area{j,1},area{k,1}) = (left_rules(area{j,1}, area{k,1}) + 1);%/2;
                        else if angle >= 45 && angle < 90
                                down_rules(area{j,1},area{k,1}) = (up_rules(area{j,1},area{k,1}) + 1);%/2;
                                right_rules(area{j,1},area{k,1}) = (left_rules(area{j,1}, area{k,1}) + 0.5);%/2;
                            end
                        end
                        
                    end
                end
            end
        end
    end
    
    sprintf('proximity and relative size')
    %relative proximity of objects
    %relative size contradiction rules
    for j=1:x,
        [b1] = cell2mat(area{j,5});
        im1 = zeros(size(j_gtim));
        for y=1:length(b1),
            im1(b1(y,1), b1(y,2)) = 1;
        end
        
        %     for j=1:length(u_labels)
        %
        %         j_gtim = (gtim == u_labels(j));
        %         [B1] = bwboundaries(j_gtim);
        %         %count the interactions between same objects
        %         for m=1:numel(B1)
        %             for n=m+1:numel(B1)
        %                 b1 = cell2mat(B1(m));
        %                 im1 = zeros(size(j_gtim));
        %                 [h,w] = size(b1);
        %                 for y=1:h,
        %                     for x=1:w,
        %                         im1(b1(y,x)) = 1;
        %                     end
        %                 end
        %                 b2 = cell2mat(B1(n));
        %                 im2 = zeros(size(j_gtim));
        %                 [h,w] = size(b2);
        %                 for y=1:h,
        %                     for x=1:w,
        %                         im2(b2(y,x)) = 1;
        %                     end
        %                 end
        %                 region1Dilated = imdilate(im1, true(3));
        %                 region2Dilated = imdilate(im2, true(3));
        %                 intersectionRegions = region1Dilated & region2Dilated;
        %                 adj_rules(u_labels(j),u_labels(j)) = (adj_rules(u_labels(j),u_labels(j)) + (numel(find(intersectionRegions>0)/gtpixels))/2;
        %
        %                 %process relative size rules
        %                 b1 = numel(find(imfill(b1, 'holes') > 0));
        %                 b2 = numel(find(imfill(b2, 'holes') > 0));
        %                 rel_size_rules(u_labels(j),u_labels(j)) = (rel_size_rules(u_labels(j),u_labels(j)) + (b1/gtpixels)/(b2/gtpixels))/2;
        %
        %             end
        %         end
        for k=1:x,
            if (j ~= k)
                [b2] = cell2mat(area{k,5});
                im2 = zeros(size(j_gtim));
                for y=1:length(b2),
                    im2(b2(y,1), b2(y,2)) = 1;
                end
                %         for k=j+1:length(u_labels)
                %             k_gtim = (gtim == u_labels(k));
                %             [B2] = bwboundaries(k_gtim);
                %             %count the interactions between same objects
                %             for m=1:numel(B2)
                %                 for n=m+1:numel(B2)
                %                     b1 = cell2mat(B2(m));
                %                     im1 = zeros(size(k_gtim));
                %                     [h,w] = size(b1);
                %                     for y=1:h,
                %                         for x=1:w,
                %                             im1(b1(y,x)) = 1;
                %                         end
                %                     end
                %                     b2 = cell2mat(B2(n));
                %                     im2 = zeros(size(k_gtim));
                %                     [h,w] = size(b2);
                %                     for y=1:h,
                %                         for x=1:w,
                %                             im2(b2(y,x)) = 1;
                %                         end
                %                     end
                %                     region1Dilated = imdilate(im1, true(3));
                %                     region2Dilated = imdilate(im2, true(3));
                %                     intersectionRegions = region1Dilated & region2Dilated;
                %                     adj_rules(u_labels(k),u_labels(k)) = adj_rules(u_labels(k),u_labels(k)) + (numel(find(intersectionRegions>0)/gtpixels))/2;
                %
                %                     %process relative size rules
                %                     b1 = numel(find(imfill(b1, 'holes') > 0));
                %                     b2 = numel(find(imfill(b2, 'holes') > 0));
                %                     rel_size_rules(u_labels(k),u_labels(k)) = (rel_size_rules(u_labels(k),u_labels(k)) + (b1/gtpixels)/(b2/gtpixels))/2;
                %
                %                 end
                %             end
                
                region1Dilated = imdilate(im1, true(3));
                region2Dilated = imdilate(im2, true(3));
                intersectionRegions = region1Dilated & region2Dilated;
                adj_rules(area{j,1},area{k,1}) = (adj_rules(area{j,1},area{k,1}) + numel(find(intersectionRegions>0)/gtpixels));%/2;
                
                b1 = numel(find(im1 > 0));
                b2 = numel(find(im2 > 0));
                
                rel_size_rules(area{j,1},area{k,1}) = (rel_size_rules(area{j,1},area{k,1}) + (b1/gtpixels)/(b2/gtpixels));%/2;
                rel_size_rules(area{k,1},area{j,1}) = (rel_size_rules(area{k,1},area{j,1}) + (b2/gtpixels)/(b1/gtpixels));%/2;
            end
        end
    end
    
    sprintf('shape')
    %shape
    %Learn models of boundaries
    for j=1:size(area,1)
        shape_rules(area{j,1},:) = (shape_rules(area{j,1},:) + area{j,6})/2;
    end
end
occurences
for i=1:nclass
   up_rules(:,i) = up_rules(:,i)/occurences{i};
   down_rules(:,i) = up_rules(:,i)/occurences{i};
   left_rules(:,i) = up_rules(:,i)/occurences{i};
   right_rules(:,i) = up_rules(:,i)/occurences{i};
   adj_rules(:,i) = up_rules(:,i)/occurences{i};
   rel_size_rules(:,i) = up_rules(:,i)/occurences{i};
end
pos_rules(:,:,1) = up_rules;
pos_rules(:,:,2) = down_rules;
pos_rules(:,:,3) = left_rules;
pos_rules(:,:,4) = right_rules;

save([output_path 'pos_rules.mat'], 'pos_rules');
save([output_path 'adj_rules.mat'], 'adj_rules');
save([output_path 'rel_size_rules.mat'], 'rel_size_rules');
save([output_path 'shape_rules.mat'], 'shape_rules');

end

function id = create_index(i,j,max)
    id = (i-1)*max +j;
end
