function [ gen_rules, min_rules] = generalize_mm_results( mm_results,algoid )

p =  find ((strcmpi(mm_results(1,:), 'Area')));
mm_results = mm_results(:,1:p-1);

[r,c] = size(mm_results);
p_rules = cell(20,1);
for j=2:r
    data = mm_results(j,:);
    labels = data(1,:);
    mmx = 0;
    for i=2:numel(data)
        if size(data{1,i},1) > mmx
            mmx = size(data{1,i},1);
        end
    end
    
    pdata = zeros(mmx, numel(labels));
    %normalize the input data
    for i=2:numel(data)
        if size(data{1,i},1) > 3
            cols = cell2mat(data{1,i});
            cols = cols(4:end,:)./cols(1,1);
            r = size(cols,1);
            pdata(1:r,i-1) = cols(:,algoid);
        end
    end
    p_rules{j-1,1} = {pdata};
end

%analyze the rules - minimize if they are redundant
gen_rules = [];
[r,c] = size(mm_results);
for j=5:19
    for i=2:numel(data)-1
        clabel = mm_results{j+1,1};
        sett = p_rules{j,1}{1,1}(:,i);
        for k=j+1:20
            inters = intersect(sett, p_rules{k,1}{1,1}(:,i));
            inters = inters(inters > 0);
            if numel(inters) > 0
                sett = inters;
                clabel = [clabel, ',',mm_results{k+1,1}];
            end
        end
        if numel(strfind(clabel, ',')) > 0
            gen_rules = [gen_rules; clabel, mm_results{1,i+1}, {sett}];
        end
    end
end
%reorganize the rules in a label->Feature order and reduce redundancies
min_rules = [];
s = unique(gen_rules(:,1));
for l=1:numel(s)
    r = gen_rules(strcmp(s(l),gen_rules(:,1)),:);
    a = strjoin(r(:,2)', ',');
%     a = cellfun(@(x) strsplit(x, ','),([r(:,1)]), 'UniformOutput', false);
%     a = cellfun(@(x) strjoin(x, ','),(a), 'UniformOutput', false);
%     a = strjoin(unique(strsplit(strjoin(a', ','),',')),',');
    min_rules = [min_rules; r(1,1), a, {unique(cell2mat(r(:,3)))}];
end

end

