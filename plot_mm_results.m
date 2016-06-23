function [ pdata ] = plot_mm_results(algoid, label, mm_results )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

data = mm_results(strcmp(mm_results(:,1), label),:);
labels = data(1,:);
mmx = 0;
for i=2:numel(data)
    if size(data{1,i},1) > mmx
        mmx = size(data{1,i},1);
    end
end

pdata = zeros(mmx, numel(labels));

for i=2:numel(data)
    if size(data{1,i},1) > 3
        cols = cell2mat(data{1,i});
        cols = cols(4:end,:)./cols(1,1);
        r = size(cols,1);
        pdata(1:r,i-1) = cols(:,algoid);
    end
end
end

