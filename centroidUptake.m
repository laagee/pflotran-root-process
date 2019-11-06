%function that calculates centroid of uptake for the current timestep given
%a vector taken from the actual_T_root cell array
function [centroid] = centroidUptake(T_root)
global nbounds_x nbounds_y nbounds_z xy_extent z_extent hr rep_root_system_ID
z_res = z_extent/nbounds_z;
T_z = zeros(length(nbounds_z),1);

% (1) At each depth, sum the uptake over xy
    T_temp = reshape(T_root,nbounds_z, nbounds_x*nbounds_y);
    for k=1:nbounds_z
        T_z(k) = sum(T_temp(k,:)<0);
    end
% (2) Calculate the "area" of transpiration
    T_area = T_z*z_res;
% (3) Find the moment = area*midpt
    midpt = ([0.025:z_res:1.975]'); %TODO: VERIFY THIS PART
    T_moment = T_area'.*midpt;        
% (4) Calculate the centroid c = sum(moment)/sum(area)
    centroid = sum(T_moment)/sum(T_area);
    
end