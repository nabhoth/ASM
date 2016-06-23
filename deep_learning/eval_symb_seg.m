function [ det, segm, rawsegm ] = eval_symb_seg(resfile, mask, obj_index )
%U
masksum = sum(sum(mask));

allresfile = (resfile > 0);
allresfilesum = sum(sum(allresfile));
allresult = allresfile.*mask;

resfile = (resfile == obj_index);
resfilesum = sum(sum(resfile));
result = resfile.*mask;

resnum = sum(sum(result));
overlap = 100*resnum/(resfilesum+masksum-resnum);
if(resfilesum > 0)
    det = 1;
else
    det = 0;
end

segm = overlap;

allresnum = sum(sum(allresult));
overlap = 100*allresnum/(allresfilesum+masksum-allresnum);
rawsegm = overlap;
end

