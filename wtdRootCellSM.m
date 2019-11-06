function [th_rw_5, th_rw_95, th_rw_min, th_rw_50, th_rw_ave] = wtdRootCellSM(S,ind_roots,SSD,th_s,th_r)
global nbounds_x nbounds_y nbounds_z xy_extent z_extent hr rep_root_system_ID
%load('R:\_PFLOTRAN_SIMULATIONS\2015_10\scaled_depth_root_ind.mat')
%Analyze soil moisture of root grid cells
%th_r=0.04;
%th_s=0.37;

W = floor(SSD.*1e5);
x = zeros(sum(W),1);
ctr=1;
for j=1:length(W)
    x(ctr:ctr+W(j))=ind_roots(j);
    ctr=ctr+W(j);
end
th_rw_5 = zeros(length(hr),1);
th_rw_50 = zeros(length(hr),1);
th_rw_95 = zeros(length(hr),1);
th_rw_ave = zeros(length(hr),1);
th_rw_min = zeros(length(hr),1);
th = cell(length(hr),1);

for i=1:length(hr)
    th{i}=th_r+S{i}.*(th_s-th_r);
    
    %Given soil moisture vector and the root indices, isolate the sm of roots.
    %th_roots{i}=th{i}(ind_roots);
    th_roots_wtd=zeros(length(x),1);
    for j=1:length(ind_roots)
        ix = find(x==ind_roots(j));
        th_roots_wtd(ix) = th{i}(ind_roots(j));
    end
    
    %Calculate the 5% and 95% percentiles of the data
    th_rw_5(i)=prctile(th_roots_wtd,5);
    th_rw_50(i)=prctile(th_roots_wtd,50);
    th_rw_95(i)=prctile(th_roots_wtd,95);
    
    %average and minimum
    th_rw_ave(i)=mean(th_roots_wtd);
    th_rw_min(i)=min(th_roots_wtd);
end
end