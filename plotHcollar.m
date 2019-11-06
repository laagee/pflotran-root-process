function plotHcollar(Hcollar,ss1,ss2)
global nbounds_x nbounds_y nbounds_z xy_extent z_extent hr rep_root_system_ID

if nargin == 1
    
%% PLOT HCOLLAR1
figure('pos',[10 10 1000 1000])
for j=1:length(rep_root_system_ID)
    subplot(4,4,j)
    %plot(hr,Hcollar2(:,j),'color',[122,1,119]./255,'linewidth',2)
    plot(hr,Hcollar(:,j),'color','k','linewidth',2)
    set(gca,'fontsize',9)
    xlabel('Time [hr]')
    ylabel('Root Collar Pressure [m]')
    grid on
    ylim([-200 0])
    title(num2str(rep_root_system_ID(j)))
end
    
else
    
%% Plot SS1 ONLY
   figure('pos',[0 0 1000 1000])
for j=1:length(rep_root_system_ID)
    subplot(4,4,j)
    hold on 
    plot(hr,ss1(:,j),'color',[122,1,119]./255,'linewidth',2)
    set(gca,'fontsize',9)
    xlabel('Time [hr]')
    ylabel('SS1 [m]')
    grid on
    title(num2str(rep_root_system_ID(j)))
    ylim([-35 0])
end

%% PLOT SS1 SS2 TOGETHER
figure('pos',[0 0 1000 1000])
for j=1:length(rep_root_system_ID)
    subplot(4,4,j)
    hold on
    plot(hr,-ss2(:,j),'linewidth',2)
    plot(hr,ss1(:,j),'color',[122,1,119]./255,'linewidth',2)
    
    %plot(hr,Hcollar(:,j),'color','k','linewidth',2)
    set(gca,'fontsize',9)
    xlabel('Time [hr]')
    ylabel('Root Collar Pressure [m]')
    grid on
    %ylim([-150 0])
    title(num2str(rep_root_system_ID(j)))
    %ylim([-4 0])
end

%% PLOT HCOLLAR1
figure('pos',[100 100 1000 1000])
for j=1:length(rep_root_system_ID)
    subplot(4,4,j)
    %plot(hr,Hcollar2(:,j),'color',[122,1,119]./255,'linewidth',2)
    plot(hr,Hcollar(:,j),'color','k','linewidth',2)
    set(gca,'fontsize',9)
    xlabel('Time [hr]')
    ylabel('Root Collar Pressure [m]')
    grid on
    ylim([-150 0])
    title(num2str(rep_root_system_ID(j)))
end

end
end
    