% [ind_roots, SSD] = readRootID(filename)
%Load the root indices and SSD using the root_param file
function [ind_roots, SSD] = readRootID(filename)
ind_roots=hdf5read(filename,'/Cell Ids');
SSD=hdf5read(filename,'/StandardWaterUpdateDensity');
end