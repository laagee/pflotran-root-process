%MASS BALANCE FOR PFLOTRAN SIMULATION
function checkMassBalance(filename,numRoots)
global nbounds_x nbounds_y nbounds_z xy_extent z_extent hr rep_root_system_ID
%using the pflotran supplied mass balance which has the format:
% Time [h], dt_flow [h], Global Water Mass [kg], bottom water mass [kg],
% bottom water mass [kg/h], NetPPT water mass [kg], NetPPT water mass
% [kg/h], RootSystem1 water mass [kg], RootSystem1 water mass
% [kg/h],...,RootSystemN water mass [kg], RootSystemN water mass [kg/h]

%%
%filename='R:\_PFLOTRAN_SIMULATIONS\2015_10\scaled_depth_wo_controls\pflotran_UMBS-mas.dat';

data=importdata(filename,' ', 1);

globMass = data.data(:,3); %kg
drainage = data.data(:,4);
precip = data.data(:,6);


%numRoots=574;
for i=1:numRoots
    uptake(:,i)=data.data(:,6+2*i);
end
uptakeSum=sum(uptake,2);
%hr=[1:1:1990];
for i=2:length(hr)+1
    dm(i-1)=globMass(1)+drainage(i)+precip(i)+uptakeSum(i);
    diff(i-1)=dm(i-1)-globMass(i);
end

%%
figure
subplot(1,2,1)
plot(hr, diff,'k','linewidth',2)
set(gca,'fontsize',14)
xlabel('Hour')
ylabel('Mass Balance [kg]')
grid on

subplot(1,2,2)
plot(hr, diff./globMass(1)*100,'linewidth',2)
set(gca,'fontsize',14)
xlabel('Hour')
ylabel('Mass Balance [%]')
grid on

end