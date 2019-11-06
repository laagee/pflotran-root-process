%given cell, map (x,y) all root systems who occupy that space
%NEEDS TO BE GENERALIZED AND OVERHAULED
function plotCelltoRootMap(p)
%generate list of root cells
% maxnumcells=0;
% 
% for j=1:numRoots
%     temp=find(SSD(:,j));
%     ind_roots{j}=unique(temp);
%     maxnumcells=max(maxnumcells,length(temp));
% end
% 
% map=zeros(maxnumcells,numRoots);
% %%
% for i=1:numRoots
%     map(1:length(ind_roots{i}),i)=ind_roots{i};
% end
%%
load('R:\_PFLOTRAN_SIMULATIONS\2015_10\scaled_depth_root_ind.mat','map');
numRoots=574;
%cell to find
%p=12910;

for i=1:numRoots
   [r,c]=find(map==p);
   systems_exist=unique(c);
   
end
%%
%TODO: mark where the cell is within the domain

%%
load('C:\users\lizagee\Documents\_PFLOTRAN_simulations\_INPUTS\XYDBH100m_allroots_574.mat')
%%
% b=num2str(systems_exist);
% txt=cellstr(b);
% dx=1;

figure
scatter(X_allRoot(systems_exist),Y_allRoot(systems_exist),DBH_allRoot(systems_exist)*4,'filled','markeredge','k')
set(gca,'fontsize',14)
%text(X_allRoot(systems_exist)+dx,Y_allRoot(systems_exist)+dx,txt)
set(gca,'xtick',0:10:100)
set(gca,'ytick',0:10:100)
ylabel('Y [m]')
xlabel('X [m]')
title(['Cell Number: ',num2str(p)])
xlim([0 100])
ylim([0 100])
grid on

end
