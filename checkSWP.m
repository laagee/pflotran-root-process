function checkSWP(P,datum)
global nbounds_x nbounds_y nbounds_z xy_extent z_extent hr rep_root_system_ID

maxP=zeros(length(hr),1);
minP=zeros(length(hr),1);

for ihr =1:length(hr)
   minP(ihr)= min(P{ihr}-datum);
   maxP(ihr)= max(P{ihr}-datum);
end

figure
hold all
plot(hr,maxP./1e6,'linewidth',2)
plot(hr,minP./1e6,'linewidth',2)
legend('Max SWP','Min SWP','location','southwest')
xlabel('hr'); ylabel('SWP [MPa]')
grid on
end