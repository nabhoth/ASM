function [area, pos_errors, pos_hypotheses, adj_errors, adj_hypotheses, shape_errors, shape_hypotheses, rel_size_errors, rel_size_hypotheses] = contradiction_check( path, img )
%contradiction_check() takes the set of labels, ane extracts rules for
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

%clear all;
path_init = '/media/kamila/3c82bfeb-15c9-4f45-b9d7-861e6410ad5c/';
%load the rules
%[pos_rules, adj_rules, rel_size_rules, shape_rules] = load_rules();
rules_location = [path_init 'top/1/Contradiction/'];
load([rules_location 'pos_rules.mat'], 'pos_rules');
load([rules_location 'adj_rules.mat'], 'adj_rules');
load([rules_location 'shape_rules.mat'], 'shape_rules');
load([rules_location 'rel_size_rules.mat'], 'rel_size_rules');
up_rules = pos_rules(:,:,1);
down_rules = pos_rules(:,:,2);
left_rules = pos_rules(:,:,3);
right_rules = pos_rules(:,:,4);



%%just for fun keep it close
classnames = {'aeroplane', 'bicycle', 'bird', 'boat', 'bottle', 'bus', 'car', 'cat', 'chair', ...
    'cow', 'diningtable', 'dog', 'horse', 'motorbike', 'person', ...
    'pottedplant', 'sheep', 'sofa', 'train', 'tvmonitor'};

% read in image
if ischar(img)
    gtim = imread([path '/' img '.png'])
else
    gtim = img;
end

u_labels = unique(gtim);
if u_labels(1) == 0
    u_labels = u_labels(2:end);
end
if u_labels(end) == 255
    u_labels = u_labels(1:end-1);
end
%u_labels
area = [];
[h,w] = size(gtim);
gtpixels = h*w;
min_area = gtpixels/70;
shape_props = zeros(1,8);
hyp_count = 1;
centroids = {};

for j=1:length(u_labels)
    j_gtim = (gtim == u_labels(j));
    Labs = bwlabel(gtim == u_labels(j),8);
    uniquel = unique(Labs);
    if uniquel(1) == 0
        uniquel = uniquel(2:end);
    end;
    for k = 1:length(uniquel)
%        uniquel(k)
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
        
        
        data = {double(u_labels(j)), j_area(1).Centroid(1), j_area(1).Centroid(2), j_area(1).Area, lol(1), shape_props, hyp_count, j_area(1).BoundingBox, j_area(1).PixelList};
        %        centroids = cat(1,centroids, data);
        centroids = [centroids; data];
        hyp_count = hyp_count + 1;
    end
end
centroids(:,4);
[cr,~] = size(centroids);
pos_errors = [];
pos_hypotheses = [];
adj_errors = [];
adj_hypotheses = [];
shape_errors = [];
shape_hypotheses = [];
rel_size_errors = [];
rel_size_hypotheses = [];

if cr > 1
%area = sortrows(centroids,2);
centroids = centroids(cell2mat(centroids(:,4))>min_area,:);
area = centroids;
[x,y] = size(area);
sprintf('contradiction  checking')
sums = x*x-x;
%pos_errors = zeros(sums,8);
%pos_hypotheses = zeros(sums,5);
% adj_errors = zeros(sums,5);
% adj_hypotheses = zeros(sums,5);
% shape_errors = zeros(x,9);
% shape_hypotheses = zeros(x,3);
% rel_size_errors = zeros(sums,5);
% rel_size_hypotheses = zeros(sums,5);

%%
loc = 1;
for j=1:x,
    pos_err = [];
    pos_hyp = [];
    for k=1:x,
        if (j ~= k)
            distx = area{k,2} - area{j,2};
            disty = area{k,3} - area{j,3};
            alpha = disty/distx;
            angle = atand(alpha);
            up = 0;
            down = 0;
            left = 0;
            right = 0;
            up_err = 0;
            down_err = 0;
            left_err = 0;
            right_err = 0;
            up_max = 0;
            down_max = 0;
            left_max = 0;
            right_max = 0;            
            if (distx > 0)
                if (disty > 0)
                    %upper left quadrant
                    if angle > 0 && angle < 45
                        up = up_rules(area{j,1},area{k,1});
                        left = left_rules(area{j,1}, area{k,1});
                    else if angle >= 45 && angle < 90
                            up = up_rules(area{j,1},area{k,1});
                            left = left_rules(area{j,1}, area{k,1});
                        end
                    end
                else
                    %lower left quadrant
                    if angle > 0 && angle < 45
                        down = up_rules(area{j,1},area{k,1});
                        left = left_rules(area{j,1}, area{k,1});
                    else if angle >= 45 && angle < 90
                            down = up_rules(area{j,1},area{k,1});
                            left = left_rules(area{j,1}, area{k,1});
                        end
                    end

                end
            else
                if (disty > 0)
                    %upper right quadrant
                    if angle > 0 && angle < 45
                        up = up_rules(area{j,1},area{k,1});
                        right = left_rules(area{j,1}, area{k,1});
                    else if angle >= 45 && angle < 90
                            up = up_rules(area{j,1},area{k,1});
                            right = left_rules(area{j,1}, area{k,1});
                        end
                    end
                else
                    %lower right quadrant
                    if angle > 0 && angle < 45
                        down = up_rules(area{j,1},area{k,1});
                        right = left_rules(area{j,1}, area{k,1});
                    else if angle >= 45 && angle < 90
                            down = up_rules(area{j,1},area{k,1});
                            right = left_rules(area{j,1}, area{k,1});
                        end
                    end

                end
            end




            % extract the probability of correctness
            pos = [up,down,left,right];
            pos_err = [pos_err;[area{j,1},area{k,1},up,down,left,right, area{j,7}, area{k,7}]];
            %pos_errors(loc,:) = [area{j,1},area{k,1},up,down,left,right, area{j,7}, area{k,7}];
            % find the maximum for j,* and k,* as possible hypotheses
            %  max hypothesis for j,*
            %             jmax = max(pos_rules(:,area{k,1}));
            %             [r_jhy, c_jhy] = find (pos_rules(:,area{k,1}) == jmax);
            %             kmax = max(pos_rules(:,area{j,1}));
            %             [r_khy, c_khy] = find (pos_rules(:,area{j,1}) == kmax);
            %             pos_hypotheses(loc,:) = [area{k,1},area{k,1},r_jhy];
            %             pos_hypotheses(loc,:) = [area{j,1},area{j,1},r_khy];

            %             jmax = max(pos_rules(:,area{k,1}));
            %             [r_jhy, c_jhy] = find (pos_rules(:,area{k,1}) == jmax);
            kmax = max(pos_rules(:,area{j,1}));
            [r_khy, ~] = find (pos_rules(:,area{j,1}) == kmax);
            %            pos_hypotheses(loc,:) = [area{k,1},area{k,1},r_jhy];
            %pos_hypotheses(loc,:) = [area{j,1},area{k,1},r_khy, area{j,7}, area{k,7}];
            pos_hyp = [pos_hyp; [area{j,1},area{k,1},r_khy, area{j,7}, area{k,7}]];
            loc = loc + 1;
        end
    end


%    pos_err
    %find the strongest error amd the most probable hypothesis
   pos_err
     pp = pos_err(:,3:6);

     mm = min(pp,[],2);
     [r,~] = find(mm == min(mm));
     perr = pos_err(r(1),:);
     phyp = pos_hyp(r(1),:);
     pos_errors = [pos_errors; perr];
     pos_hypotheses = [pos_hypotheses; phyp];
end
end
%%
%sprintf('proximity and relative size')
%relative proximity of objects
%relative size contradiction rules
loc = 1;
for j=1:x,
    adj_err = [];
    adj_hyp = [];
    res_err = [];
    res_hyp = [];
    
    [b1] = cell2mat(area{j,5});
    im1 = zeros(size(j_gtim));
    for y=1:length(b1),
        im1(b1(y,1), b1(y,2)) = 1;
    end
    %count the interactions between same objects
    %     for m=1:numel(B1)
    %         for n=m+1:numel(B1)
    %             b1 = cell2mat(B1(m));
    %             im1 = zeros(size(j_gtim));
    %             [h,w] = size(b1);
    %             for y=1:h,
    %                 for x=1:w,
    %                     im1(b1(y,x)) = 1;
    %                 end
    %             end
    %             b2 = cell2mat(B1(n));
    %             im2 = zeros(size(j_gtim));
    %             [h,w] = size(b2);
    %             for y=1:h,
    %                 for x=1:w,
    %                     im2(b2(y,x)) = 1;
    %                 end
    %             end
    %             region1Dilated = imdilate(im1, true(3));
    %             region2Dilated = imdilate(im2, true(3));
    %             intersectionRegions = region1Dilated & region2Dilated;
    %             adj_errors = [adj_errors; [u_labels(j), u_labels(j), abs(adj_rules(u_labels(j),u_labels(j)) - (numel(find(intersectionRegions>0))/gtpixels))]];
    %
    %
    %             [minDifferenceValue, indexAtMin] = min(abs(diag(adj_rules) - (numel(find(intersectionRegions>0))/gtpixels)));
    %             adj_hypotheses = [adj_hypotheses;[u_labels(j), u_labels(j),indexAtMin]];
    %
    %             %process relative size rules
    %             b1 = numel(find(imfill(b1, 'holes') > 0));
    %             b2 = numel(find(imfill(b2, 'holes') > 0));
    %             rel_size_errors = [rel_size_errors; [u_labels(j), u_labels(j), ((b1/gtpixels)/(b2/gtpixels) - rel_size_rules(u_labels(j),u_labels(j)))]];
    %
    %             [minDifferenceValue, indexAtMin] = min(abs(diag(rel_size_rules) - (b1/gtpixels)/(b2/gtpixels)));
    %             rel_size_hypotheses = [rel_size_hypotheses;[u_labels(j), u_labels(j),indexAtMin]];
    %
    %         end
    %     end
    
    for k=1:x,
        if (j ~= k)
            %for k=j+1:length(u_labels)
            %k_gtim = (gtim == u_labels(k));
            [b2] = cell2mat(area{k,5});
            im2 = zeros(size(j_gtim));
            for y=1:length(b2),
                im2(b2(y,1), b2(y,2)) = 1;
            end
            %count the interactions between same objects
            %         for m=1:numel(B2)
            %             for n=m+1:numel(B2)
            %                 b1 = cell2mat(B2(m));
            %                 im1 = zeros(size(k_gtim));
            %                 [h,w] = size(b1);
            %                 for y=1:h,
            %                     for x=1:w,
            %                         im1(b1(y,x)) = 1;
            %                     end
            %                 end
            %                 b2 = cell2mat(B2(n));
            %                 im2 = zeros(size(k_gtim));
            %                 [h,w] = size(b2);
            %                 for y=1:h,
            %                     for x=1:w,
            %                         im2(b2(y,x)) = 1;
            %                     end
            %                 end
            %                 region1Dilated = imdilate(im1, true(3));
            %                 region2Dilated = imdilate(im2, true(3));
            %                 intersectionRegions = region1Dilated & region2Dilated;
            %                 adj_errors = cat(1, adj_errors, u_labels(k), u_labels(k), abs(numel(find(intersectionRegions>0))/gtpixels - adj_rules(u_labels(k),u_labels(k))));
            %
            %                 [minDifferenceValue, indexAtMin] = min(abs(diag(adj_rules) - (numel(find(intersectionRegions>0))/gtpixels)));
            %                 adj_hypotheses = cat(1,pos_hypotheses,u_labels(k),u_labels(k),indexAtMin);
            %
            %                 %process relative size rules
            %                 b1 = numel(find(imfill(b1, 'holes') > 0));
            %                 []b2 = numel(find(imfill(b2, 'holes') > 0));
            %                 rel_size_errors = cat(1, rel_size_errors, u_labels(k), u_labels(k), abs((b1/gtpixels)/(b2/gtpixels) - rel_size_rules(u_labels(k),u_labels(k))));
            %
            %
            %                 [minDifferenceValue, indexAtMin] = min(abs(diag(rel_size_rules) - (b1/gtpixels)/(b2/gtpixels)));
            %                 rel_size_hypotheses = cat(1,rel_size_hypotheses,u_labels(k),u_labels(k),indexAtMin);
            %
            %             end
            %         end
            
            region1Dilated = imdilate(im1, true(3));
            region2Dilated = imdilate(im2, true(3));
            intersectionRegions = region1Dilated & region2Dilated;
            
%            adj_errors(loc,:) = [area{j,1}, area{k,1},  abs(numel(find(intersectionRegions>0))/gtpixels - adj_rules(area{j,1},area{k,1})), area{j,7}, area{k,7}];
            adj_err = [adj_err;[area{j,1}, area{k,1},  abs(numel(find(intersectionRegions>0))/gtpixels - adj_rules(area{j,1},area{k,1})), area{j,7}, area{k,7}]];
            
            [~, indexAtMin] = min(abs(adj_rules(area{j,1},:) - (numel(find(intersectionRegions>0))/gtpixels)));
%            adj_hypotheses(loc,:) = [area{j,1}, area{k,1},indexAtMin, area{j,7}, area{k,7}];
            adj_hyp = [adj_hyp; [area{j,1}, area{k,1},indexAtMin, area{j,7}, area{k,7}]];
            
            b1 = numel(find(imfill(im1, 'holes') > 0));
            b2 = numel(find(imfill(im2, 'holes') > 0));
            
%            rel_size_errors(loc,:) = [area{j,1}, area{k,1}, (abs((b1/gtpixels)/(b2/gtpixels) - rel_size_rules(area{j,1}, area{k,1}))), area{j,7}, area{k,7}];
            res_err = [res_err; [area{j,1}, area{k,1}, (abs((b1/gtpixels)/(b2/gtpixels) - rel_size_rules(area{j,1}, area{k,1}))), area{j,7}, area{k,7}]];
            [~, indexAtMin] = min(abs(rel_size_rules(area{j,1},:) - (b1/gtpixels)/(b2/gtpixels)));
%            rel_size_hypotheses(loc,:) = [area{j,1}, area{k,1},indexAtMin, area{j,7}, area{k,7}];
            res_hyp = [res_hyp; [area{j,1}, area{k,1},indexAtMin, area{j,7}, area{k,7}]];
            
%            rel_size_errors(loc,:) = [area{k,1}, area{j,1}, (abs((b2/gtpixels)/(b1/gtpixels) - rel_size_rules(area{k,1}, area{j,1}))), area{j,7}, area{k,7}];
            res_err = [res_err; [area{k,1}, area{j,1}, (abs((b2/gtpixels)/(b1/gtpixels) - rel_size_rules(area{k,1}, area{j,1}))), area{j,7}, area{k,7}]];
            [~, indexAtMin] = min(abs(rel_size_rules(area{k,1},:) - (b2/gtpixels)/(b1/gtpixels)));
%            rel_size_hypotheses(loc,:) = [area{k,1}, area{j,1},indexAtMin, area{j,7}, area{k,7}];
            res_hyp = [res_hyp; [area{j,1}, area{k,1},indexAtMin, area{j,7}, area{k,7}]];
            loc = loc + 1;
        end
    end
%      %find the strongest error amd the most probable hypothesis
      pp = adj_err(:,3);
      mm = min(pp,[],2);
      [r,~] = find(mm == min(mm));
      perr = adj_err(r(1),:);
      phyp = adj_hyp(r(1),:);
      adj_errors = [adj_errors; perr];
      adj_hypotheses = [adj_hypotheses; phyp];

      pp = res_err(:,3);
      mm = min(pp,[],2);
      [r,~] = find(mm == min(mm));
      perr = res_err(r(1),:);
      phyp = res_hyp(r(1),:);
      rel_size_errors = [rel_size_errors; perr];
      rel_size_hypotheses = [rel_size_hypotheses; phyp];
    
end
%%
%sprintf('shape')
loc = 1;
for j=1:x
    shape_errors(loc,:) =  [shape_rules(area{j,1}) - area{j,6}, area{j,7}];
    
    differs = zeros(numel(classnames),7);
    for n=1:numel(classnames),
        differs(n,:) = abs(shape_rules(n,:) - shape_errors(j,1:7));
    end
    
    norms = zeros(numel(classnames),1);
    for n=1:numel(classnames),
        norms(n,1) = norm(differs(n,1:7));
    end
    [~, indexAtMin] = min(abs(norms));
    shape_hypotheses(loc,:) = [area{j,1}, indexAtMin, area{j,7}];
    loc = loc + 1;
end
end
