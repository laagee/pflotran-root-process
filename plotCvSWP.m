function plotCvSWP(CvP,AveP)
global nbounds_x nbounds_y nbounds_z xy_extent z_extent hr rep_root_system_ID

figure('pos',[0 0 400 300])
plot(hr, CvP,'linewidth',2)
grid on
xlabel('Hour')
ylabel('Cv SWP')

figure('pos',[0 0 400 300])
plot(AveP./1e6,CvP,'.')
grid on
xlabel('Mean SWP [MPa]')
ylabel('Cv SWP')

end

