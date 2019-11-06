function [ss1_dly, ss2_dly, ssRatio_dly]= plotSSDaily(ss1,ss2,hrStart)
global nbounds_x nbounds_y nbounds_z xy_extent z_extent hr rep_root_system_ID
day_start=[hrStart:24:hr(end)];
day_end=[(hrStart+12):24:hr(end)];

if length(day_start)>length(day_end)
    day_start=day_start(1:end-1);
end

%Construct daily hours (Assumes 12 hour days)
for i=1:length(day_start)
    day(i,:)=[day_start(i):1:day_end(i)];
end

ss2_dly = zeros(length(rep_root_system_ID),length(day));
ss1_dly = zeros(length(rep_root_system_ID),length(day));

for iday=1:length(day)
    ss2_dly(:,iday)=mean(ss2(day(iday,:),:));
    ss1_dly(:,iday)=mean(ss1(day(iday,:),:));
end

ssRatio_dly=ss2_dly./ss1_dly;

figure('pos',[0 0 1000 1000])
for j=1:length(rep_root_system_ID)
    subplot(4,4,j)
    hold on
    plot([1:length(day)],log10(-ssRatio_dly(j,:)),'-o','markersize',5,'markerfacecolor','none')
    plot([1:length(day)],zeros(length([1:length(day)]),1),'-k','linewidth',2)
    set(gca,'fontsize',9)
    xlabel('Days')
    ylabel('log(SS2/SS1) [-]')
    grid on
    title(num2str(rep_root_system_ID(j)))
    ylim([-2 2])
    xlim([0 length(day)])
end
end