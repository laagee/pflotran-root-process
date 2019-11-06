function [th,r] = radialUptakeCentroid(T_root,center_ij)
global nbounds_x nbounds_y nbounds_z xy_extent z_extent hr rep_root_system_ID
x_res = xy_extent./nbounds_x;
y_res = xy_extent./nbounds_y;

i=center_ij(1);
j=center_ij(2);
T_root=reshape(full(T_root),nbounds_z,nbounds_x,nbounds_y);
% (1) Sum uptake over z
T_root(T_root>0)=0;
T_xy=zeros(20,20);
T_xy(:,:)=sum(T_root,1);
%%
%Calculate the "area" of the transpiration
T_area=T_xy*x_res*y_res;
%T_moment=zeros(size(T_area));

midpt_x=zeros(size(T_area));
midpt_y=zeros(size(T_area));
midpt_x(:,j)=x_res/2;
midpt_y(i,:)=y_res/2;

for m=1:20
    if (j+m)<=20
        midpt_x(:,j+m)=x_res*(m+1)-x_res/2;
    end
    if (j-m)>0
        midpt_x(:,j-m)=-(x_res*(m+1)-x_res/2);
    end
    if (i+m)<=20
        midpt_y(i+m,:)=-(y_res*(m+1)-y_res/2);
    end
    if (i-m)>0
       midpt_y(i-m,:)=(y_res*(m+1)-y_res/2); 
    end
end
        
T_moment_x=T_area.*midpt_x;
T_moment_y=T_area.*midpt_y;

cent_y = sum(sum(T_moment_y))./sum(sum(T_area));
cent_x = sum(sum(T_moment_x))./sum(sum(T_area));

[th, r]=cart2pol(cent_x,cent_y);


end

% T_moment(j,i)=T_area(j,i)*xres/2;
% for m=1:20 %nbounds_xy
%     %fourth quadrant
%     if (j+m)>0&(i+m)>0&(j+m)<=20&(i+m)<=20
%         midpt(j:j+m,i+m)=(xres*(m+1)-xres/2);
%         T_moment(j:j+m,i+m)=T_area(j:j+m,i+m).*(xres*(m+1)-xres/2);
%         T_moment(j+m,i:i+m)=T_area(j+m,i:i+m).*(xres*(m+1)-xres/2);
%     end
%     %second quadrant
%     if (j-m)>0&(i+m)>0&(j-m)<=20&(i+m)<=20
%         T_moment(j-m:j,i+m)=T_area(j-m:j,i+m).*(xres*(m+1)-xres/2);
%         T_moment(j-m,i:i+m)=T_area(j-m,i:i+m).*(xres*(m+1)-xres/2);
%     end
%     %third quadrant
%     if (j-m)>0&(i-m)>0&(j-m)<=20&(i-m)<=20
%         T_moment(j-m:j,i-m)=T_area(j-m:j,i-m).*(xres*(m+1)-xres/2);
%         T_moment(j-m,i-m:i)=T_area(j-m,i-m:i).*(xres*(m+1)-xres/2);
%     end
%     %fourth quadrant
%     if (j+m)>0&(i-m)>0&(j+m)<=20&(i-m)<=20
%         T_moment(j:j+m,i-m)=T_area(j:j+m,i-m).*(xres*(m+1)-xres/2);
%         T_moment(j+m,i-m:i)=T_area(j+m,i-m:i).*(xres*(m+1)-xres/2);
%     end
% end
% 
% centroid = sum(sum(T_moment))/sum(sum(T_area));