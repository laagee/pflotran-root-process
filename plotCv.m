function plotCv(Cv,AveS)
global nbounds_x nbounds_y nbounds_z xy_extent z_extent hr rep_root_system_ID

figure('pos',[0 0 400 300])
plot(hr, Cv,'linewidth',2)
grid on
xlabel('Hour')
ylabel('Cv')

figure('pos',[0 0 400 300])
plot(AveS,Cv,'.')
grid on
xlabel('Mean S')
ylabel('Cv')

end

