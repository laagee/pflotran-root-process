function [Cv,AveS] = rootZoneCv(S,ind_roots,d)
global nbounds_x nbounds_y nbounds_z xy_extent z_extent hr rep_root_system_ID

zres = z_extent/nbounds_z;
bottom = nbounds_z - d/zres;
rootLayers = ind_roots./nbounds_x./nbounds_y;

Cv = zeros(length(hr),1);
AveS = zeros(length(hr),1);

for ihr = 1:length(hr)
   ix = find(rootLayers >= bottom & rootLayers <= z_extent);
   Cv(ihr) = std(S{ihr}(ix))/mean(S{ihr}(ix));
   AveS(ihr) = mean(S{ihr}(ix));
end

end