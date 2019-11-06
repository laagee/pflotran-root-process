function plotCompiledRootZoneWtdSM(root_dir)
global nbounds_x nbounds_y nbounds_z xy_extent z_extent hr rep_root_system_ID

figure('pos',[10 10 1000 1000])
for j=1:length(rep_root_system_ID)
load([root_dir,'root_smwtd_',num2str(rep_root_system_ID(j)),'.mat'],'th_rw_95','th_rw_5','th_rw_ave','th_rw_min','th_rw_50')
subplot(4,4,j)   
    X=[hr,fliplr(hr)];
Y=[th_rw_5;flipud(th_rw_95)];


h1=fill(X,Y,[99/255,99/255,99/255]);
set(h1,'facealpha',0.5)
set(h1,'edgealpha',0)
hold on;
%set(gca,'fontsize',14)
plot(hr,th_rw_5,'-k','linewidth',1.25)
plot(hr,th_rw_95,'-k','linewidth',1.25)
h2=plot(hr,th_rw_50,'--b','linewidth',1.2);
h3=plot(hr,th_rw_min,'-r','linewidth',1.2);
ylim([0.04 0.40])
ylabel('Soil Moisture [m^3/m^3]')
xlabel('Hours')
%legend([h1,h2,h3],{'5-95% percentile','median','min'},'location','northeast','edgecolor','white')
title(num2str(rep_root_system_ID(j)))
grid on

end
legend([h1,h2,h3],{'5-95% percentile','median','min'},'location','northeast','edgecolor','white')

end