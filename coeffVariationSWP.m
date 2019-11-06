function [CvP, AveP] = coeffVariationSWP(P,d)
global nbounds_x nbounds_y nbounds_z xy_extent z_extent hr rep_root_system_ID

zres = z_extent/nbounds_z;
bottom = nbounds_z - d/zres;

CvP = zeros(length(hr),1);
AveP = zeros(length(hr),1);
for ihr = 1:length(hr)
    Ptemp2=reshape(P{ihr},nbounds_z,nbounds_x,nbounds_y)-101325;
    Ptemp=reshape(Ptemp2(bottom:nbounds_z,:,:),(nbounds_z-bottom+1)*nbounds_x*nbounds_y,1);
   %Cv(ihr) = std(S{ihr}(bottom:nbounds_z,:,:))/mean(mean(mean(S{ihr}(bottom:nbounds_z,:,:))));
   CvP(ihr) = std(Ptemp)/mean(Ptemp);
   AveP(ihr) = mean(Ptemp);
end

end