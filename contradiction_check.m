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

    pos_errors=[];pos_hypotheses=[];adj_errors=[];adj_hypotheses=[];rel_size_errors=[];rel_size_hypotheses=[];shape_errors=[];shape_hypotheses=[];

    %load the rules
    rules_location = '/media/top/1/Contradiction/';
    load([rules_location 'pos_rules.mat'], 'pos_rules');
    load([rules_location 'adj_rules.mat'], 'adj_rules');
    load([rules_location 'shape_rules.mat'], 'shape_rules');
    load([rules_location 'rel_size_rules.mat'], 'rel_size_rules');
  
    classnames = {'aeroplane', 'bicycle', 'bird', 'boat', 'bottle', 'bus', 'car', 'cat', 'chair', ...
        'cow', 'diningtable', 'dog', 'horse', 'motorbike', 'person', ...
        'pottedplant', 'sheep', 'sofa', 'train', 'tvmonitor'};

    % read in image
    if ischar(img)
        gtim = imread([path '/' img '.png']);
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
        end
        for k = 1:length(uniquel)
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
            centroids = [centroids; data];
            hyp_count = hyp_count + 1;
        end
    end
    [cr,~] = size(centroids);
   

      
    if cr > 1
        centroids = centroids(cell2mat(centroids(:,4))>min_area,:);
        area = centroids;
        sprintf('contradiction checking')
        [pos_errors, pos_hypotheses] = position_check(pos_rules, area);
        [adj_errors, adj_hypotheses, rel_size_errors, rel_size_hypotheses] = size_proximity_check (area, j_gtim, adj_rules, gtpixels, rel_size_rules);
        [shape_errors, shape_hypotheses] = shape_check(shape_rules, area, classnames);
    end

end

function [pos_errors, pos_hypotheses] = position_check(pos_rules, area)
	pos_errors = [];
    pos_hypotheses = [];
    [x,~] = size(area);
    up_rules = pos_rules(:,:,1);
    down_rules = pos_rules(:,:,2);
    left_rules = pos_rules(:,:,3);
    right_rules = pos_rules(:,:,4);
    for j=1:x,
        pos_err = [];
        pos_hyp = [];
        for k=1:x,
            if (j ~= k)
                distx = area{k,2} - area{j,2};
                disty = area{k,3} - area{j,3};
                angle = atand(disty/distx);
                up = 0;
                down = 0;
                left = 0;
                right = 0;
                              
                if (distx > 0)
                    if (disty > 0)
                        up = up_rules(area{j,1},area{k,1});
                        right = right_rules(area{j,1}, area{k,1});
                    else                       
                        down = down_rules(area{j,1},area{k,1});
                        right = right_rules(area{j,1}, area{k,1});
                    end                        
                else
                    if (disty > 0)
                        up = up_rules(area{j,1},area{k,1});
                        left = left_rules(area{j,1}, area{k,1});                        
                    else
                        down = down_rules(area{j,1},area{k,1});
                        left = left_rules(area{j,1}, area{k,1});                            
                    end                    
                end
                
%                 if (distx > 0)
%                     if (disty > 0)
%                         %upper left quadrant
%                         if angle > 0 && angle < 45
%                             up = up_rules(area{j,1},area{k,1});
%                             left = left_rules(area{j,1}, area{k,1});
%                         else if angle >= 45 && angle < 90
%                             up = up_rules(area{j,1},area{k,1});
%                             left = left_rules(area{j,1}, area{k,1});
%                             end
%                         end
%                     else
%                         %lower left quadrant
%                         if angle > 0 && angle < 45
%                             down = up_rules(area{j,1},area{k,1});
%                             left = left_rules(area{j,1}, area{k,1});
%                         else if angle >= 45 && angle < 90
%                                 down = up_rules(area{j,1},area{k,1});
%                                 left = left_rules(area{j,1}, area{k,1});
%                             end
%                         end
%                     end
%                 else
%                     if (disty > 0)
%                         %upper right quadrant
%                         if angle > 0 && angle < 45
%                             up = up_rules(area{j,1},area{k,1});
%                             right = left_rules(area{j,1}, area{k,1});
%                         else if angle >= 45 && angle < 90
%                                 up = up_rules(area{j,1},area{k,1});
%                                 right = left_rules(area{j,1}, area{k,1});
%                             end
%                         end
%                     else
%                         %lower right quadrant
%                         if angle > 0 && angle < 45
%                             down = up_rules(area{j,1},area{k,1});
%                             right = left_rules(area{j,1}, area{k,1});
%                         else if angle >= 45 && angle < 90
%                             down = up_rules(area{j,1},area{k,1});
%                             right = left_rules(area{j,1}, area{k,1});
%                             end
%                         end
%                     end
%                 end

                % extract the probability of correctness
                pos = [up,down,left,right];
                pos_err = [pos_err;[area{j,1},area{k,1},up,down,left,right, area{j,7}, area{k,7}]];               
                kmax = max(pos_rules(:,area{j,1}));
                [r_khy, ~] = find (pos_rules(:,area{j,1}) == kmax);
                pos_hyp = [pos_hyp; [area{j,1},area{k,1},r_khy, area{j,7}, area{k,7}]];
            end
        end

        % find the strongest error amd the most probable hypothesis        
        % pos_err
        
        if (size(pos_err,2) > 5)
            pp = pos_err(:,3:6);
            mm = min(pp,[],2);
            [r,~] = find(mm == min(mm));
            perr = pos_err(r(1),:);
            phyp = pos_hyp(r(1),:);
            pos_errors = [pos_errors; perr];
            pos_hypotheses = [pos_hypotheses; phyp];
        end
    end
end

function [adj_errors, adj_hypotheses, rel_size_errors, rel_size_hypotheses] = size_proximity_check (area, j_gtim, adj_rules, gtpixels, rel_size_rules)
    %relative proximity of objects
    %relative size contradiction rules
    adj_errors = [];
    adj_hypotheses = [];
    rel_size_errors = [];
    rel_size_hypotheses = [];
    
    [x, ~] = size(area);
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
       
        for k=1:x,
            if (j ~= k)               
                [b2] = cell2mat(area{k,5});
                im2 = zeros(size(j_gtim));
                for y=1:length(b2),
                    im2(b2(y,1), b2(y,2)) = 1;
                end
               
                region1Dilated = imdilate(im1, true(3));
                region2Dilated = imdilate(im2, true(3));
                intersectionRegions = region1Dilated & region2Dilated;

                adj_err = [adj_err;[area{j,1}, area{k,1},  abs(numel(find(intersectionRegions>0))/gtpixels - adj_rules(area{j,1},area{k,1})), area{j,7}, area{k,7}]];

                [~, indexAtMin] = min(abs(adj_rules(area{j,1},:) - (numel(find(intersectionRegions>0))/gtpixels)));
                adj_hyp = [adj_hyp; [area{j,1}, area{k,1},indexAtMin, area{j,7}, area{k,7}]];

                b1 = numel(find(imfill(im1, 'holes') > 0));
                b2 = numel(find(imfill(im2, 'holes') > 0));

                res_err = [res_err; [area{j,1}, area{k,1}, (abs((b1/gtpixels)/(b2/gtpixels) - rel_size_rules(area{j,1}, area{k,1}))), area{j,7}, area{k,7}]];
                [~, indexAtMin] = min(abs(rel_size_rules(area{j,1},:) - (b1/gtpixels)/(b2/gtpixels)));
                res_hyp = [res_hyp; [area{j,1}, area{k,1},indexAtMin, area{j,7}, area{k,7}]];

                res_err = [res_err; [area{k,1}, area{j,1}, (abs((b2/gtpixels)/(b1/gtpixels) - rel_size_rules(area{k,1}, area{j,1}))), area{j,7}, area{k,7}]];
                [~, indexAtMin] = min(abs(rel_size_rules(area{k,1},:) - (b2/gtpixels)/(b1/gtpixels)));
                res_hyp = [res_hyp; [area{j,1}, area{k,1},indexAtMin, area{j,7}, area{k,7}]];
            end
        end
        %find the strongest error amd the most probable hypothesis
        if (size(adj_err,2) > 2)
            pp = adj_err(:,3);
            mm = min(pp,[],2);
            [r,~] = find(mm == min(mm));
            perr = adj_err(r(1),:);
            phyp = adj_hyp(r(1),:);
            adj_errors = [adj_errors; perr];
            adj_hypotheses = [adj_hypotheses; phyp];
        end
        
        if (size(res_err,2) > 2)
            pp = res_err(:,3);
            mm = min(pp,[],2);
            [r,~] = find(mm == min(mm));
            perr = res_err(r(1),:);
            phyp = res_hyp(r(1),:);
            rel_size_errors = [rel_size_errors; perr];
            rel_size_hypotheses = [rel_size_hypotheses; phyp];
        end

    end
end


function [shape_errors, shape_hypotheses] = shape_check(shape_rules, area, classnames)
    %shape contradition rules
    shape_errors = [];
    shape_hypotheses = [];
    loc = 1;
    [x, ~] = size(area);
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