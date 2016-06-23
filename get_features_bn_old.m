function [ mapping] = get_features_bn_old(im,mapping,index,counter)
%computes features for images - whole images 
%
%parameters:
%           dir_path - path to the directories containing the images 
%output:
%           mapping - array of features 

            
            %read the image from which to compute the features
            I = im;
            %sum of non zero pixels
%            nonzero = sum(sum(I > 0));

            rgbnonzeroim = I(I > 0);
%            nonzeroimpix = I(I.* repmat(mask,[1,1,3]) > 0);
            
            IG = rgb2gray(I);
            graynonzeroim = IG(IG > 0);

            IBW = im2bw(I);
            imBW = im2double(IBW);
            imgg = im2double(IG);
            [h,w] = size(IG);
            
            
            fprintf('processing...\n');
            count = counter;

            [lh, f] = his(graynonzeroim);
            mapping{index, count} = f(1,1);
            count = count + lh;
            
            [lg, f] = ft(imgg);
            mapping{index, count} = f;
            count = count + lg(2);

            [lg, f] = gab(IG);
            mapping{index, count} = f;
            count = count + lg(2);

            [lb, f] = rgb(rgbnonzeroim);
            mapping{index, count} = f(1,1);
            count = count + lb(2);

            [lr, f] = rgf(IG);
            mapping{index, count} = f(1,1);
            count = count + lr(2);
            
            [lrr, f] = rbf (imBW);
            mapping{index, count} = f;
            count = count + lrr(2);
            
%             [lo, f] = ogr(img);            
%             mapping(index, count:count+lo(2)-1) = f(1,1:40);
%             count = count + lo(2);
            

            
%            mapping(index, 3:counter+2) = mapping(index, 1:counter);
%            mapping(1,1) = str2double(id);
end

function [l, f] = his(imgg)
            %sum of gray histogram
            H = (hist(imgg, 10)'); %min-max
            avg = (abs(H - mean(H)));
            [i,f] = (min(avg));
            l = 1;
end            
            
function [l, f] = ft(imgg)           
            %sum of fft
            try
            histo = imhist(fft(imgg,10),10);
            avg = (abs(histo - mean(histo)));
            [i,f] = (min(avg));
            catch
                f = 0;
            end
            l = size(f);
end

function [l, f] = gab(imgg)         
            %gabor filter
            [G,gabout] = gaborfilter1(imgg(:,:,1),2,4,16,4*pi/3);
            histo = hist(reshape(gabout, prod(size(gabout)), 1),10);
            avg = (abs(histo - mean(histo)));
            [i,f] = (min(avg));
            l = size(f);
end

function [l, f]=wav(imgg)          
            %wavelet
            [cA,cH,cV,cD] = (dwt2(imgg,'haar'));
            CH = imhist(cH,100);
            CH = (abs(CH - mean(CH)));
            CA = imhist(cA,100);
            CH = (abs(CA - mean(CA)));
            CV = imhist(cV,100);
            CH = (abs(CV - mean(CV)));
            CD = imhist(cD,100);
            CH = (abs(CD - mean(CD)));
            f = zeros(1,4);
            f(1,1) = CH;
            f(1,2) = CA;
            f(1,3) = CV;
            f(1,4) = CD;
            l = size(f);
end

function [l, f] = con(imgg)
            %contrast
            f = contrast(imgg)/10^4;
            l = size(f);
end

function [l, f] = acu(imgg)
            %acutance
            f = acutance(imgg)*10^4;
            l = size(f);
end
function [l, f] = gis(img) 
            %Gist
            h = gist_features(img);
            h = (abs(h - mean(h)));
            f = h;
            l = size(f);
end

function [l, f] = ogr(img)
            %Orient Gradient
            [h,w] = size(img);
            [BGa,BGb] = detBG(img);
            [TGa,TGb] = detTG(img);
            [CGa,pbhist] = detCG(img);
            f = cell(1,40);
            cou = 1;
            for dr = 1:8,
                BGA = mean(sum(hist(BGa(:,:,dr),128)'));
                f{1,cou} = BGA;
                cou = cou + 1;
                
                
                TGA = mean(sum(hist(TGa(:,:,dr),128)'));
                f{1,cou} = TGA;
                cou = cou + 1;
                                
                for color = 1:3,
                    COLRS = mean(sum(hist(CGa(:,:,color,dr),128)'));
                    f{1,cou} = COLRS;
                    cou = cou + 1;
                end
            end            
            l = size(f);
end
function [l, f] = lsf(iis, iie)            
            %line feature 2069-2188 from Saliency 1
            f = zeros(1,133);
            [m,n,l] = size(iis);
            %m = abs(mapping(i,3)-mapping(i,4));
            %n = abs(mapping(i,5)-mapping(i,6));
            offset = 0;
            linecou = 0;
            %line feature
           
            for linei = 17:17:80
                for linej = 3:--2:-1
                    for lineK = 0:20:40
                        if(lineK == 0)
                            linek = 10;
                        else
                            linek = lineK;
                        end
                        
                        %i,j,k = thresh,radius,length
                        [lines,pixels] = longlines(iis,iie,linei,linej,linek);
                        
                        binarypix = pixels/128;
                        Lpx = sum(sum(binarypix));
                        
                        if(Lpx == 0)
                            f(1, offset+linecou : offset+5+linecou) = 0;
                        else
                            %linepixels saliency nomalize
                            f(1, offset   + linecou) = sum(sum(lines(:,:,3)))/Lpx;
                            %sum linepixels
                            f(1, offset+1 + linecou) = Lpx;
                            %linepixels/allpixels
                            f(1, offset+2 + linecou) = Lpx/(n*m);
                            %linepixels(i,j,k)/linepixels(20,3,10)
                            f(1, offset+3 + linecou) = Lpx/f(1, offset + 1);
                            %different
                            dif = line_distinct(lines,iis,1,m,1,n);
                            f(1, offset+4 + linecou) = dif;
                        end
                        linecou = linecou + 5;
                    end
                end
            end
            %stats
            f(1,128) = std(f(1,1:120));
            f(1,129) = mean(f(1,1:120));
            f(1,130) = var(f(1,1:120));
            f(1,131) = cov(f(1,1:120));
            f(1,132) = median(f(1,1:120));
            l = size(f);
end

function [l, f] = lif(iis, iie)            
             %line feature 2189-2307 from Saliency Itty
            [m,n,l] = size(iis);
            f = zeros(1,125);
            %n = abs(mapping(i,5)-mapping(i,6));
            offset = 0;
            linecou = 0;
            for linei = 17:17:80
                for linej = 3:--2:-1
                    for lineK = -3:17:40
                        if(lineK == 0)
                            linek = 10;
                        else
                            linek = lineK;
                        end
                        
                        %i,j,k = thresh,radius,length
                        [lines,pixels] = longlines(iisi,iie,linei,linej,linek);
                        
                        binarypix = pixels/128;
                        Lpx = sum(sum(binarypix));
                        
                        if(Lpx == 0)
                            f(1, offset+linecou : offset+5+linecou) = 0;
                        else
                            %linepixels saliency nomalize
                            f(1, offset   + linecou) = sum(sum(lines(:,:,3)))/Lpx;
                            %sum linepixels
                            f(1, offset+1 + linecou) = Lpx;
                            %linepixels/allpixels
                            f(1, offset+2 + linecou) = Lpx/(n*m);
                            %linepixels(i,j,k)/linepixels(20,3,10)
                            f(1, offset+3 + linecou) = Lpx/f(1, offset + 1);
                            %different
                            dif = line_distinct(lines,iis,1,m,1,n);
                            f(1, offset+4 + linecou) = dif;
                        end
                        linecou = linecou + 5;
                    end
                end
            end
            %stats
            f(1,121) = std(f(1,1:120));
            f(1,122) = mean(f(1,1:120));
            f(1,123) = var(f(1,1:120));
            f(1,124) = cov(f(1,1:120));
            f(1,125) = median(f(1,1:120));            
            l = size(f);
end

function [l, f] = lgf(iis, iie)          
            %line feature 2308-2427 from Saliency GBVS
            [m,n,l] = size(iis);
            f = zeros(1,125);
            %m = abs(mapping(i,3)-mapping(i,4));
            %n = abs(mapping(i,5)-mapping(i,6));
            offset = 0;
            linecou = 0;
            for linei = 17:17:80
                for linej = 3:--2:-1
                    for lineK = -3:17:40
                        if(lineK == 0)
                            linek = 10;
                        else
                            linek = lineK;
                        end
                        
                        %i,j,k = thresh,radius,length
                        [lines,pixels] = longlines(iisg,iie,linei,linej,linek);
                        
                        binarypix = pixels/128;
                        Lpx = sum(sum(binarypix));
                        
                        if(Lpx == 0)
                            f(1, offset+linecou : offset+5+linecou) = 0;
                        else
                            %linepixels saliency nomalize
                            f(1, offset   + linecou) = sum(sum(lines(:,:,3)))/Lpx;
                            %sum linepixels
                            f(1, offset+1 + linecou) = Lpx;
                            %linepixels/allpixels
                            f(1, offset+2 + linecou) = Lpx/(n*m);
                            %linepixels(i,j,k)/linepixels(20,3,10)
                            f(1, offset+3 + linecou) = Lpx/f(1, offset + 1);
                            %different
                            dif = line_distinct(lines,iis,1,m,1,n);
                            f(counter, offset+4 + linecou) = dif;
                        end
                        linecou = linecou + 5;
                    end
                end
            end
            %stats
            f(1,121) = std(f(1,1:120));
            f(1,122) = mean(f(1,1:120));
            f(1,123) = var(f(1,1:120));
            f(1,124) = cov(f(1,1:120));
            f(1,125) = median(f(1,1:120));
            l = size(f);
end

function [l, f] = rgb(nonzeroimpix)
            %RGBhistogram  2427-2626
            h= (hist(nonzeroimpix, 10));
            avg = (abs(h - mean(h)));
            [i,f] = min(avg);
            l = size(f);
end

function [l, f] = rgf(imggg)
            %region properties
            try
            regprops = regionprops(imggg,'all');
            elements = numel(regprops);
            %number of regions from BW level image
            f = double(elements);%/nonzerosum;
            catch
                f = 0;
            end
            l = size(f);
end

function [l, f] = rbf (imgbw)
            %region properties
            try
            regprops = regionprops(imgbw,'all');
            elements = numel(regprops);
            %number of regions from grey level image
            f = double(elements);%/nonzerosum;
            catch
                f = 0;
            end
            l= size(f);

end
