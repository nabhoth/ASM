function [ target_im ] = merge_hypothesis_image(target_im, bb, update_im)
% function [ output_args ] = merge_hypothesis_image(target_im, target_props, update_im)
% y0 = bb(2);
% x0 = bb(1);
% if bb(2) == 0
% 	y0 = 1;
% end
% if bb(1) == 0
% 	x0 = 1;
% end

% [r c] = size(bb);
%target_im(y0:floor(bb(2)+bb(4)),x0:floor(bb(1)+bb(3)),:) = update_im(y0:floor(bb(2)+bb(4)),x0:floor(bb(1)+bb(3)),:);
[x y] = size(target_im)



% for i = 1:r  
%     target_im(bb(i, 2), bb (i, 1)) = update_im(bb(i, 2), bb (i,1));
% end

%color = target_im(bb(1, 1), bb (1, 2));
color = bb

k = unique(update_im);
t = find(k==color);

size(t,1)

for i = 1:x
    for j = 1:y       
       if color == update_im(i, j)
          target_im(i, j) = update_im(i, j);          
       end 
       if color == target_im(i, j) & ~color == update_im(i, j) & size(t)>0
          target_im(i, j) = 0;
       end    
    end
end


% for i = 1:x
%     for j = 1:y
%         if color == target_im(i, j) & size(t)>0
%             target_im(i, j) = 0;
%         end
%         if color == update_im(i, j) & target_im(i, j)==0
%            target_im(i, j) = update_im(i, j);
%         end
%     end
% end