function [CvS, AveS] = coeffVariation(S,d)
global nbounds_x nbounds_y nbounds_z xy_extent z_extent hr rep_root_system_ID

zres = z_extent/nbounds_z;
bottom = nbounds_z - d/zres;

CvS = zeros(length(hr),1);
AveS = zeros(length(hr),1);
for ihr = 1:length(hr)
    Stemp=reshape(S{ihr}(bottom:nbounds_z,:,:),(nbounds_z-bottom+1)*nbounds_x*nbounds_y,1);
   %Cv(ihr) = std(S{ihr}(bottom:nbounds_z,:,:))/mean(mean(mean(S{ihr}(bottom:nbounds_z,:,:))));
   CvS(ihr) = std(Stemp)/mean(Stemp);
   AveS(ihr) = mean(Stemp);
end

end