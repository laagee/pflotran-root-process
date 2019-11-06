function [T_img] = temporalUptakeProfile(rootsys_T,ii)
global nbounds_x nbounds_y nbounds_z xy_extent z_extent hr rep_root_system_ID
t1=hr(1);
t2=hr(end);
for ihr=t1:t2
%T_temp=reshape(full(rootsys_T{ii,ihr}),nbounds_x,nbounds_y,nbounds_z);
T_temp=reshape(full(rootsys_T{ii,ihr}),nbounds_z,nbounds_y,nbounds_x);
for k=1:nbounds_z
   T_xy(k,:)=sum(sum(T_temp(k,:,:)));
   
end
T_img(:,ihr)=T_xy(:,1);
end

T_img=flipud(T_img);
%%
figure('pos',[50 50 1000 400])
imagesc([t1:1:t2],[0.05:0.05:size(T_img,1)*0.05],-T_img(:,t1:t2))
set(gca,'fontsize',14)
xlabel('Time [hr]')
ylabel('Z [m]')
h=colorbar
ylabel(h,'Uptake','rot',-90)
%caxis([-1e-6, 10e-6])
ylim([0.05,16*0.05])
xlim([t1,t2])

end