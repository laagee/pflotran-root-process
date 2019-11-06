function plotKcompMap(Kcomp)

load('C:\users\lizagee\Documents\_PFLOTRAN_simulations\_INPUTS\XYDBH100m_allroots_574.mat')
%%
filename='umbs_domain_map_rel_kcomp.png';
S=DBH_allRoot*4;

figure
scatter(X_allRoot,Y_allRoot,S,Kcomp,'filled','markeredge','k')
set(gca,'fontsize',14)
set(gca,'xtick',0:10:100)
set(gca,'ytick',0:10:100)
ylabel('Y [m]')
xlabel('X [m]')
h=colorbar;
cmap=get(gcf,'colormap');
set(gcf,'colormap',flipud(cmap));
ylabel(h,'K_c_o_m_p','rot',-90)
grid on

% paper size
set(gcf, 'PaperPositionMode', 'auto');
set(gcf, 'PaperUnits', 'points');
set(gcf, 'PaperPosition', [0 0 640 480]);

% this works for png files
print('-dpng','-r300',filename)
end