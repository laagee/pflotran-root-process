%Computes the individual scale cumulative transpiration (Tcum_ind) 
%and hourly time series (T_ind), both in [mm]. The original data output 
%is in [kg s-1]. There is a discrepancy in the HDF5 output files that 
%lists the output units as [kg m-2 s-1]. 
function [T_ind, HR_ind, Tcum_ind]=treeET(rootsys_T, plot_flag)
global nbounds_x nbounds_y nbounds_z xy_extent z_extent hr rep_root_system_ID

T_ind = zeros(length(rep_root_system_ID),length(hr));
HR_ind = zeros(length(rep_root_system_ID),length(hr));
Tcum_ind = zeros(length(rep_root_system_ID),length(hr));
HRcum_ind = zeros(length(rep_root_system_ID),length(hr));

if plot_flag
    figure('pos',[10 10 1000 1000])
    Tpot=cell(length(rep_root_system_ID),1);
end

for j=1:length(rep_root_system_ID)

    for ihr=1:length(hr)
        %Compute total uptake and redistribtuion [kg]
        T_ind(j,ihr)=full(sum(-rootsys_T{j,ihr}.*3600./xy_extent./xy_extent));
        HR_ind(j,ihr)=full(sum(rootsys_T{j,ihr}(rootsys_T{j,ihr}>=0).*3600./xy_extent./xy_extent));
    end
    
    HRcum_ind(j,:)=cumsum(HR_ind(j,:));
    Tcum_ind(j,:)=cumsum(T_ind(j,:));
    
    if plot_flag
       subplot(4,4,j)
       hold on
       Tpot{j}=-readRootPET(['Trans_RootSystem',num2str(rep_root_system_ID(j)),'.dat'])';
       Tpot_mm=Tpot{j}.*3600./xy_extent./xy_extent;
       plot(cumsum(Tpot_mm),'r.-','linewidth',4)
       plot(hr,Tcum_ind(j,:),'b-','linewidth',3)
       plot(hr,cumsum(T_ind(j,:)+HR_ind(j,:)),'g--','linewidth',2)
       set(gca, 'fontsize',9);
       xlabel('Simulation time [hr]');
       ylabel('Cumulative ET [mm]');
       title(num2str(rep_root_system_ID(j)))
       text(20, 1.25,['Uptake = ',num2str(Tcum_ind(j,end)),' mm',newline...
           ,'HR = ',num2str(HRcum_ind(j,end)),' mm'],'fontsize',8)
       ylim([0,1.75])
       grid on
    end
end
if plot_flag
legend('Potential','Actual','w/o HR','location','northwest')
end
end