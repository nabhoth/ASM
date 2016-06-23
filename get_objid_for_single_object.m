function [ obj_id ] = get_objid_for_single_object( path, img )

% read in image
if ischar(img)
    gtim = imread([path '/' img '.png']);
else
    gtim = img;
end

u_labels = unique(gtim);

if length(u_labels) == 1
    obj_id = 0;
    return;
end

if u_labels(1) == 0
    u_labels = u_labels(2:end);
end
if u_labels(end) == 255
    u_labels = u_labels(1:end-1);
end

obj_id = u_labels;

end

