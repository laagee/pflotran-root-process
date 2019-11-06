function [Hcollar, ss1, ss2] = calcHCollar(rootsys_T,P,Kcomp,datum)
global nbounds_x nbounds_y nbounds_z xy_extent z_extent hr rep_root_system_ID
ss1 = zeros(length(hr),length(rep_root_system_ID));
ss2 = zeros(length(hr),length(rep_root_system_ID));
Hcollar = zeros(length(hr),length(rep_root_system_ID));


for j=1:length(rep_root_system_ID)
    for i=1:length(hr)
        [ind_roots,SSD]=readRootID(['root_param_',num2str(rep_root_system_ID(j)),'.h5']);
        ss1(i,j)=-sum((datum-P{i}(ind_roots)).*SSD.*0.102./1000); %[m]
        ss2(i,j)=sum(full(-rootsys_T{j,i})./1000)./Kcomp(j);
        Hcollar(i,j)=-sum((datum-P{i}(ind_roots)).*SSD*0.102d0/1000)-...
            (sum(full(-rootsys_T{j,i})./1000)./Kcomp(j)); %[m]
    end
end
end

