function [wctd] = weightedCtdUptake(hrStart,rootsys_T)
global nbounds_x nbounds_y nbounds_z xy_extent z_extent hr rep_root_system_ID

z_res = z_extent/nbounds_z;
% % (1) At each depth, sum the uptake over xy
%     T_temp = reshape(T_root,nbounds_z, nbounds_x*nbounds_y);
%     for k=1:nbounds_z
%         T_z(k) = sum(T_temp(k,:)<0);
%     end
% % (2) Calculate the "area" of transpiration
%     T_area = T_z*z_res;
% % (3) Find the moment = area*midpt
%     midpt = ([0.025:z_res:1.975]'); %TODO: VERIFY THIS PART
%     T_moment = T_area'.*midpt;        
% % (4) Calculate the centroid c = sum(moment)/sum(area)
%     centroid = sum(T_moment)/sum(T_area);

% (5) Find daily transpiration
    day_start=[hrStart:24:hr(end)];
    day_end=[(hrStart+12):24:hr(end)];

%construct daily hours (Assumes 12 hour days)
if length(day_start)>length(day_end)
    day_start=day_start(1:end-1);
end
   
for i=1:length(day_start)
    day(i,:)=[day_start(i):1:day_end(i)];
end
wctd=zeros(length(rep_root_system_ID),length(day));
for j=1:length(rep_root_system_ID)
    T_z=zeros(nbounds_z,length(hr));
    centroid=zeros(length(hr),1);
    for ihr=1:length(hr)
        %get centroid
        centroid(ihr)=full(centroidUptake(rootsys_T{j,ihr}));
        %get T_z
        T_temp=full(rootsys_T{j,ihr});
        T_temp=reshape(T_temp,nbounds_z,nbounds_x*nbounds_y);
        for k=1:nbounds_z
            ix=find(T_temp(k,:)<0);
            T_z(k,ihr)=sum(-T_temp(k,ix));
        end
    end
    %% Compute the weighted centroid of uptake.
    
    for iday=1:length(day) %number of days
        for jhr=1:length(day(iday,:)) %number of daylight hours
            %get total T for this hour
            T_day(iday,jhr)=sum(T_z(:,day(iday,jhr)));
        end
        %T*centroid
        Tctd=T_day(iday,:)'.*centroid(day(iday,:));
        %sum(T*centroid)/sum(T)
        wctd(j,iday)=sum(Tctd)/sum(T_day(iday,:));
    end
end


