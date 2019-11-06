%Computes total hourly source from root systems [mm] and total hourly sink
%from root systems [mm]. Plot flag toggles plot of cumulative uptake with
%and without the source cells included.
%
%[HR,T_mm_woHR] = domainHR(domain_T,hr,xy_extent,plot_flag)

function [HR,T_mm_woHR] = domainHR(domain_T,plot_flag)
global nbounds_x nbounds_y nbounds_z xy_extent z_extent hr rep_root_system_ID
HR = zeros(length(hr),1);
T_mm=zeros(length(hr),1);
T_mm_woHR=zeros(length(hr),1);

for ihr=1:length(hr)
    %Compute hourly uptake [kg/s/m^2] -> [mm]
    T_mm(ihr)=sum(-domain_T{ihr})*3600./(xy_extent.*xy_extent);
    %Find source cells
    ix=find(domain_T{ihr}<0);
    %Compute total hourly sink cell [kg/s/m^2] -> [mm]
    T_mm_woHR(ihr)=sum(-domain_T{ihr}(ix))*3600./(xy_extent.*xy_extent);
    %Compute hourl source [mm]
    HR(ihr)=T_mm_woHR(ihr)-T_mm(ihr);
end

if plot_flag
%Plot which compares cumulative ET for domain with and without source cells
figure('position',[500 100 400 300],'paperpositionmode','auto')
hold on
plot(hr,cumsum(T_mm),'-*b','linewidth',2)
plot(hr,cumsum(T_mm_woHR),'--g','linewidth',2)
set(gca, 'fontsize',10);
xlabel('Simulation time [hr]');
ylabel('Cumulative ET [mm]');
legend('Cumulative ET [mm]','Cum. ET w/o HR [mm]','location','northwest');
grid on
end 
end