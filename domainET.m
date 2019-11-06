% [Tcum_mm, T_mm]=domainET(domain_T,hr,xy_extent,plot_flag)
% 
% Description: Computes the domain scale cumulative transpiration (Tcum_mm) 
% and hourly time series, both in [mm]. The original data output is in 
% [kg s-1]. There is a discrepancy in the HDF5 output files that lists 
% the output units as [kg m-2 s-1]. Note: the current plot is specific to 
% the UMBS 2010 simulation domain.
function [Tcum_mm, T_mm]=domainET(domain_T,plot_flag)
global nbounds_x nbounds_y nbounds_z xy_extent z_extent hr rep_root_system_ID
    T_mm = zeros(length(hr),1);
    
    for i=1:length(hr)
        Ttemp=domain_T{i};
        %sum domain transpiration and convert from [kg/s] -> [mm/hr]
        T_mm(i)=sum(-Ttemp)*3600./(xy_extent.*xy_extent);
    end
    
    %compute cumulative transpiration
    Tcum_mm = cumsum(T_mm);
    
    %NOTE: THIS IS SPECIFIC TO THE 2010 UMBS GROWING SEASON
    if plot_flag
        %Load PET and Big Leaf responses.
        load potential_ET.txt %unit [mm/s]
        potential_ET_mmh=potential_ET(:,3)*3600;
        load LH_one_big_leaf_mmh.mat

        %Plot which compares cumulative ET for PET, Bigleaf, and Microscopic
        figure('position',[10 100 400 300],'paperpositionmode','auto')
        plot(cumsum(-potential_ET_mmh(1:1990)),'r.-','linewidth',4);hold on;
        plot(hr,Tcum_mm,'-b','linewidth',2)
        plot(cumsum(LH_one_big_leaf_mmh(1:1990)),'c-','linewidth',3);
        set(gca, 'fontsize',10);
        xlabel('Simulation time [hr]');
        ylabel('Cumulative ET [mm]');
        legend('potential','microscopic','big leaf','location','northwest');
        grid on;
        xlim([0 1990]);
    end

end