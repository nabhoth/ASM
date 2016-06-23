function [mapping] = get_features_bn_pca(im, flabels, att_data_mean, max_vals, U, B_old, min_vals)
%function [mapping] = get_features_bn_pca(im)

fnum = numel(flabels);
I = im;
IG = rgb2gray(I);
graynonzeroim = IG(IG > 0);
IBW = im2bw(I);
imgg = im2double(IG);

fprintf('processing...\n');

[f] = his(graynonzeroim);
mapping = num2cell(double(f'));


[f] = ft(imgg);
mapping = [mapping num2cell(f')];


[f] = gab(IG);
mapping = [mapping num2cell(f)];


[f] = wav(imgg);
mapping = [mapping f];


[f] = con(imgg);
mapping = [mapping num2cell(double(f))];


[f] = acu(imgg);
mapping = [mapping num2cell(double(f))];


[f] = gis(IG);
mapping = [mapping num2cell(double(f'))] ;


[f] = rgb(im);
mapping = [mapping f];


[f] = rgf(IG);
mapping = [mapping f] ;


[f] = rbf (IG);
mapping = [mapping f];


%%%%%%%%%%%%%

[f]  = harris(IG);
mapping = [mapping f];


[f]  = sobel(IG);
mapping = [mapping f];


[f]  = canny(IG);
mapping = [mapping f];


[f]  = prewitt(IG);
mapping = [mapping f];
     

[f]  = covdetHL(IG);
mapping = [mapping f];

[f]  = covdetDoG(IG);
mapping = [mapping f];

[f]  = covdetHes(IG);
mapping = [mapping f];

[f]  = covdetHesL(IG);
mapping = [mapping f];

[f]  = covdetHesM(IG);
mapping = [mapping f];

[f]  = covdetHM(IG);
mapping = [mapping f];

[f]  = sift(IG);
mapping = [mapping f];

[f]  = hog(I);
mapping = [mapping f];

[f]  = mser(IG);
mapping = [mapping f];

[f] = texture(I);
mapping = [mapping f];

%%%%%%%%%%%%%

mapping = [mapping att_data_mean];

  
for i=1:size(mapping,2)
   
    col = cell2mat(mapping(1,i));
    max_v = cell2mat(max_vals(1,i));
    min_v = cell2mat(min_vals(1:end,i));
    col = (col-min_v)/(max_v-min_v);
    
    mapping(1,i) = num2cell(col);
end


[r,c] = size(mapping)
for i = 1:r*c
    if(isnan(mapping{i}) || isinf(mapping{i}))
        mapping{i}=0;
    end
end


B = cell2mat(mapping);
B=B*U;

f_data = B(1,(end-fnum):end);
%f_data = B(1,:);
%mapping = mat2cell(f_data, ones(size(f_data, 1), 1), ones(1, size(f_data, 2)));
mapping = num2cell(f_data);
end
%%%%%%%%%%%%%

function [f] = his(imgg)
f = imhist(imgg);
end

function [f] = ft(imgg)
try
    h = abs(fft2((imgg - mean(mean(imgg)))));
    t = imhist(h);
    f = t(1:end-1);
catch
    f = zeros(255, 1);
end
end

function [f] = gab(imgg)
[G,gabout] = gaborfilter1(imgg(:,:),2,4,16,4*pi/3);
f = hist(reshape(gabout, prod(size(gabout)), 1),255);
end

function [f]=wav(imgg)
[cA,cH,cV,cD] = (dwt2(imgg,'haar'));
CH = imhist((cH));
CH = CH(2:end);
CA = imhist((cA)/max(max(cA)));
CV = imhist((cV));
CV = CV(2:end);
CD = imhist((cD));
CD = CD(2:end);
f = num2cell([CH' CA' CV' CD']);
end

function [f] = con(imgg)
f = contrast(imgg)/10^4;
end

function [f] = acu(imgg)
f = acutance(imgg)*10^4;

end
function [f] = gis(img)
f = gist_features(img);
end


function [f] = rgb(nonzeroimpix)
r= imhist(nonzeroimpix(:,:,1));
g= imhist(nonzeroimpix(:,:,2));
b= imhist(nonzeroimpix(:,:,3));
f = num2cell([r' g' b']);
end

function [f] = rgf(imggg)
regprops = regionprops(imggg,'Area');
[r,c] = size(regprops);
if r > 0
    h = [regprops.Area];
    f = num2cell(hist(h, 128));
else
    f = zeros(1, 128);
end
end

function [f] = rbf (img)
f = [];
for i = 0:0.1:1
    imgbw = im2bw(img, i);
    regprops = regionprops(imgbw,'Area');
    [r,c] = size(regprops);
    if r > 0
        h = [regprops.Area];
        l ={min(h), max(h), mean(h), std(h), median(h), mode(h)};
    else
        l = num2cell(zeros(1, 6));
    end
    f = [f l];
end
end


function [f] = harris(imgg)
C = cornermetric(imgg);
adjusted = imadjust(C);
[d,~] = imhist(adjusted,10);
f = num2cell(d');

end

function [f] = sobel(imgg)
f = cell(1,20);
for i=1:20
    C = edge(imgg,'sobel',i*0.0225);
    f{i} = numel(C(C>0));
end

end
function [f] = canny(imgg)
f = cell(1,20);
for i=1:20
    C = edge(imgg,'canny',i*0.0225);
    f{i} = numel(C(C>0));
end

end
function [f] = prewitt(imgg)
f = cell(1,20);
for i=1:20
    C = edge(imgg,'prewitt',i*0.0225);
    f{i} = numel(C(C>0));
end

end

function [f] = covdetHL(imgg)
[~, ~, info] = vl_covdet(im2single(imgg), 'method', 'HarrisLaplace');
f = num2cell(hist([info.peakScores],255));
t = num2cell(hist([info.edgeScores],255));
f = [f t];
end

function [f] = covdetDoG(imgg)
[~, ~, info] = vl_covdet(im2single(imgg), 'method', 'DoG');
f = num2cell(hist([info.peakScores],255));
t = num2cell(hist([info.edgeScores],255));
f = [f t];

end


function [f] = covdetHes(imgg)
[~, ~, info] = vl_covdet(im2single(imgg), 'method', 'Hessian');
f = num2cell(hist([info.peakScores],255));
t = num2cell(hist([info.edgeScores],255));
f = [f t];
end


function [f] = covdetHesL(imgg)
[~, ~, info] = vl_covdet(im2single(imgg), 'method', 'HessianLaplace');
f = num2cell(hist([info.peakScores],255));
t = num2cell(hist([info.edgeScores],255));
f = [f t];

end

function [f] = covdetHesM(imgg)
[~, ~, info] = vl_covdet(im2single(imgg), 'method', 'MultiscaleHessian');
f = num2cell(hist([info.peakScores],255));
t = num2cell(hist([info.edgeScores],255));
f = [f t];

end


function [f] = covdetHM(imgg)
[~, ~, info] = vl_covdet(im2single(imgg), 'method', 'MultiscaleHarris');
f = num2cell(hist([info.peakScores],255));
t = num2cell(hist([info.edgeScores],255));
f = [f t];
end


function [f] = sift(img)
[~,D] = vl_sift(im2single(img));
g = imhist(D);
f = num2cell(g(2:end, :))';
end

function [f] = hog(img)
h = vl_hog(im2single(img), 20, 'verbose') ;
k = [];
for i = 1:size(h,3)
    t = imhist(h(:,:,i));
    k = [k t(2:40)'];
end
f = num2cell(k);
end


function [f] = mser(imgg)
[r,f] = vl_mser(imgg,'MinDiversity',0.7,'MaxVariation',0.2, 'Delta',10) ;
f = num2cell(hist(r, 128));
end

function [result] = texture(inimsub)
[~,~,tmap] = detTG(inimsub);
text_k = cell(1,64);
for i=1:64
    text_k{1,i} = numel(tmap(tmap == i));
end
result = text_k;
end

