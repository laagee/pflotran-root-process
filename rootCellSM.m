function [th_roots_5, th_roots_95, th_roots_min, th_roots_ave, th] = rootCellSM(S,ind_roots,th_s,th_r)
global nbounds_x nbounds_y nbounds_z xy_extent z_extent hr rep_root_system_ID
%load('R:\_PFLOTRAN_SIMULATIONS\2015_10\scaled_depth_root_ind.mat')
%Analyze soil moisture of root grid cells
%th_r=0.04;
%th_s=0.37;

for i=1:length(hr)
    th{i}=th_r+S{i}.*(th_s-th_r);
    
    %Given soil moisture vector and the root indices, isolate the sm of roots.
    th_roots{i}=th{i}(ind_roots);
    
    %Calculate the 5% and 95% percentiles of the data
    th_roots_5(i)=prctile(th_roots{i},5);
    th_roots_95(i)=prctile(th_roots{i},95);
    
    %average and minimum
    th_roots_ave(i)=mean(th_roots{i});
    th_roots_min(i)=min(th_roots{i});
end
%%
%-------------------------------------------------------------------------
%filename='rootzone_sm.png'; %FIGURE FILENAME

%Plots 5-95% percentile, ave, min soil moisture of root cells
%-------------------------------------------------------------------------
% X=[hr,fliplr(hr)];
% Y=[th_roots_5,fliplr(th_roots_95)];
% 
% figure
% h1=fill(X,Y,[99/255,99/255,99/255]);
% set(h1,'facealpha',0.5)
% set(h1,'edgealpha',0)
% hold on;
% set(gca,'fontsize',14)
% plot(hr,th_roots_5,'-k','linewidth',1.5)
% plot(hr,th_roots_95,'-k','linewidth',1.5)
% h2=plot(hr,th_roots_ave,'--b','linewidth',2);
% h3=plot(hr,th_roots_min,'-r','linewidth',2);
% ylim([0.04 0.25])
% ylabel('Soil Moisture [m^3/m^3]')
% xlabel('Hours')
% legend([h1,h2,h3],{'5-95% percentile','ave','min'},'location','northeast','edgecolor','white')
% title('Root Cell Soil Moisture')
% grid on
% 
% % paper size
% set(gcf, 'PaperPositionMode', 'auto');
% set(gcf, 'PaperUnits', 'points');
% set(gcf, 'PaperPosition', [0 0 640 480]);

% this works for png files
%print('-dpng','-r300',filename)

end
