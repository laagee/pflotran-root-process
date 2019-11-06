%reference script for pflotran-root plots

%%
%TITLE: deviation from mean, root zone saturation
%X-AXIS: mean root zone saturation [m3/m3 %]
%Y-AXIS: std dev root zone saturation [m3/m3 %]

figure
plot(mean_S_rootzone*100,std_S_rootzone*100,'b.');
xlabel('mean [m3 m-3 %]');ylabel('std [m3 m-3 %]');
ylim([0 3.5]);
title('root zone');
saveas(gcf,[pflotran_dir,'mean_std_rootzone.fig']);

%%
%TITLE: deviation from mean, top 20cm saturation
%X-AXIS: mean saturation, top 20cm
%Y-AXIS: std dev saturation, top 20cm

figure
plot(mean_S_20cm*100,std_S_20cm*100,'b.');
xlabel('mean [m3 m-3 %]');ylabel('std [m3 m-3 %]');
ylim([0 3.5]);
title('top 0-20 cm');
saveas(gcf,[pflotran_dir,'mean_std_20cm.fig']);

%%
%TITLE: transpiration time series
%X-AXIS: hours
%Y-AXIS: actual transpiration [kg/s], potential transpiration [kg/s]

for j=1:length(To_read_system_ID) %for every representative root system
    figure
    plot(hours, -T_sum(hours,j), 'b.-');hold on;
    plot(hours, -T_potential(hours,j), 'b*-');
    xlabel('Hour'); ylabel('Transpiration [kg/s]');
    legend('Actual', 'Potential'); title(['root system: ',num2str(j)]);
    saveas(gcf, ['T',num2str(j)], 'fig');
end

%%
%TITLE: cumulative transpiration time series
%X-AXIS: hours
%Y-AXIS: cumulative actual transpiration [m^3], cumulative potential
%transpiration [m^3}

for j=1:length(To_read_system_ID)   %for every representative root system
    figure
    plot(hours, -cumsum(T_sum(hours,j))/3.6, 'b.-');hold on;
    plot(hours, -cumsum(T_potential(hours,j))/3.6, 'b*-');  
    xlabel('Hour'); ylabel('Cumulative Transpiration [m^3]');
    legend('Actual', 'Potential'); title(['root system: ',num2str(j)]);
    saveas(gcf, ['T',num2str(j)], 'fig');
end

%%
%TITLE: Water potential at the root collar
%X-AXIS: hours
%Y-AXIS: water potential at root collar, potential threshold (constant)

for j=1:length(To_read_system_ID) %for every representative root system
    figure
    plot(hours, Hcollar(hours,j), 'b.-');hold on;
    plot(hours,H_threshold(hours),'k--');
    xlabel('Hour'); ylabel('Water potential at Root Collar [m]');
    legend('Root');title(['root system: ',num2str(j)]);
    saveas(gcf, ['Hcollar',num2str(j)], 'fig');
end


%%
%TITLE: Domain scale cumulative evapotranspiration
%X-AXIS: 
%Y-AXIS:

load potential_ET.txt %unit [mm/s]
potential_ET_mmh=potential_ET(:,3)*3600;
load LH_one_big_leaf_mmh.mat

figure
plot(cumsum(-potential_ET_mmh(1:1990)),'r.-','linewidth',4);hold on;
plot(cumsum(-Total_T_sum/2.78),'b-','linewidth',2);
plot(cumsum(LH_one_big_leaf_mmh(1:1990)),'c-','linewidth',3);
set(gca, 'fontsize',14);
xlabel('Simulation time [hr]','fontsize',14);
ylabel('Cumulative ET [mm]','fontsize',14);
legend('potential','microscopic','big leaf');
grid off;
xlim([0 1990]);
saveas(gcf, ['Cumulative_T_domain_scale',num2str(j)], 'fig');

%%
%TITLE: hourly root zone saturation; XY plane
%X-AXIS: X [m]
%Y-AXIS: Y [m]
%MAP: root zone saturation [m^3/m^3]

hours=[2:1:1990]

for i=hours
i_str=sprintf('%3.3d',i);    
    
h=figure
imagesc([99:-2:1],[99:-2:1],reshape(Cell_S_XY_Zroot,50,50));
set(gca,'YDir','normal');
colormap(flipud(colormap))
colorbar('location','eastoutside');
xlabel('\bf X [m]','fontsize',14); ylabel('\bf Y [m]','fontsize',14); 
caxis([min(Cell_S_XY_Zroot)-0.01,max(Cell_S_XY_Zroot)+0.01])
title(['root zone: ',i_str, 'hr'],'fontsize',14);
%scatter([AF_X_inside+25;outside_XY(:,1)], [AF_Y_inside+25;outside_XY(:,2)],[Actual_insideDBH;outside_DBH],'k');
saveas(gcf,[pflotran_dir,i_str,'.jpg']);
saveas(gcf,[pflotran_dir,i_str,'.fig']);
end

%%
%TITLE: hourly saturation, top 20cm; XY plane
%X-AXIS: X [m]
%Y-AXIS: Y [m]
%MAP: saturation, top 20cm

hours=[2:1:1990]

for i=hours
i_str=sprintf('%3.3d',i);

figure
imagesc([1:5:99],[1:5:99],s_20cm_mat');
set(gca,'YDir','normal');
colormap(flipud(colormap))
colorbar('location','eastoutside');
xlabel('\bf X [m]','fontsize',14); ylabel('\bf Y [m]','fontsize',14); 
hold on;
title(['top 0-20 cm: ',i_str, 'hr'],'fontsize',14);
saveas(gcf,[pflotran_dir,i_str,'_20cm.jpg']);
saveas(gcf,[pflotran_dir,i_str,'_20cm.fig']);
mean_S_20cm(i)=mean(s_20cm);
std_S_20cm(i)=std(s_20cm);

end

%%
%TITLE: transpiration sink, top 20cm; XY plane
%X-AXIS:
%Y-AXIS:

figure
imagesc([1:5:99],[1:5:99],Total_T_20cm_mat');
set(gca,'YDir','normal');
colormap(flipud(colormap))
colorbar('location','eastoutside');
xlabel('\bf X [m]','fontsize',14); ylabel('\bf Y [m]','fontsize',14); 
hold on;
title(['Sink of top 0-20 cm: ',i_str, 'hr'],'fontsize',14);
saveas(gcf,[pflotran_dir,i_str,'_20cm_Sink.jpg']);

%%
%TITLE:
%X-AXIS:
%Y-AXIS:

%%
%TITLE:
%X-AXIS:
%Y-AXIS:
