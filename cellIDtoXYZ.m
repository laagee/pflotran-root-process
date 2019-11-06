function [x,y,z]=cellIDtoXYZ(cellid)
%Given a PFLOTRAN grid cell ID, this determines the midpoint x, y, z 
%coordinate of the cell. Assumes z = 0 is the bottom of the domain of 
%the domain, with values increasing towards the ground surface.

global nbounds_x nbounds_y nbounds_z xy_extent z_extent hr rep_root_system_ID

z_res=z_extent/nbounds_z;
x_res=xy_extent/nbounds_x;
y_res=xy_extent/nbounds_y;

%MAP CELL IDS TO LAYERS
zlayer = ceil(cellid/nbounds_x/nbounds_y);

if mod(cellid,nbounds_x)==0
    xlayer=nbounds_x;
else
    xlayer=mod(cellid, nbounds_x);
end

ylayer = ceil((cellid-(zlayer-1)*nbounds_x*nbounds_y)/nbounds_x);

%GET CELL COORDINATES (using midpoint)
x=xlayer*xres;
y=ylayer*yres;
z=zlayer*zres;

end


