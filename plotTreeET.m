function plotTreeET(T_ind)
global nbounds_x nbounds_y nbounds_z xy_extent z_extent hr rep_root_system_ID

figure('position',[500,300,1100,300],'paperpositionmode','auto')
plot(hr,T_ind,'linewidth',2)
set(gca,'fontsize',10)
xlabel('Hour'); ylabel('Uptake [mm/hr]');
grid on

end