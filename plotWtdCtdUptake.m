function plotWtdCtdUptake(wctd)

global nbounds_x nbounds_y nbounds_z xy_extent z_extent hr rep_root_system_ID
%%
figure('pos',[0 0 1000 1000])
for j=1:length(rep_root_system_ID)
    subplot(4,4,j)
   plot(wctd(j,:)-wctd(j,1),'linewidth',2)
   title(num2str(rep_root_system_ID(j)))
   ylim([-0.1,0.1])
   xlim([0,83])
   ylabel('Wtd Ctd Uptake\newline Deviation [m]','fontsize',8)
   grid on
end
%%


figure('pos',[0,0,1000,400])
hold all
for j=1:length(rep_root_system_ID)
   plot(wctd(j,:)-wctd(j,1),'linewidth',1.5)
   labels{j}=num2str(rep_root_system_ID(j));
end
 ylim([-0.1,0.1])
   xlim([0,83])
   ylabel('Wtd Ctd Uptake Deviation [m]')
   xlabel('Simulation Days')
   grid on
   legend(labels,'location','eastoutside')
   
end