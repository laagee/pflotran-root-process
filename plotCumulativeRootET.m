function plotCumulativeRootET(T_ind)
global nbounds_x nbounds_y nbounds_z xy_extent z_extent hr rep_root_system_ID
figure('pos',[10 10 1000 1000])
for j=1:length(rep_root_system_ID)
   PET = readRootPET(['Trans_RootSystem',num2str(rep_root_system_ID(1)),'.dat'])...
       .*3600./xy_extent;
   PET_cum(j,:) = cumsum(PET(1:length(hr)));
   Tcum_ind(j,:)=cumsum(T_ind(j,:));
   
   subplot(4,4,j)
   hold on
   

        %Load PET and Big Leaf responses.
        
        %Plot which compares cumulative ET for PET, Bigleaf, and Microscopic
        subplot(4,4,j)
        plot(hr,PET_cum(j,:),'r.-','linewidth',4);hold on;
        plot(hr,Tcum_ind(j,:),'-*b','linewidth',2)
end

        set(gca, 'fontsize',14);
        xlabel('Simulation time [hr]','fontsize',14);
        ylabel('Cumulative ET [mm]','fontsize',14);
        legend('potential','microscopic','location','northwest');
        grid off;
        xlim([0 1990]);
end