% Function to read in PET data from TransRootSystem.dat file.
function [PET] = readRootPET(filename)
    raw=importdata(filename);
    PET=raw.data(:,2);
end