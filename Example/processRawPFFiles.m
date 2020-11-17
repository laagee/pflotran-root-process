% processRawPFFiles.m
% Sample Matlab script that reads in PFLOTRAN-Root HDF5 output files and
% compiles them into cell arrays and then outputs them in a .mat file for
% further processing.
%
% Author: Liz Agee (ageela@ornl.gov)
% Date: original ca. 2015; revised 2020

clear
%Set the path to the folder containing the PFLOTRAN-Root processing scripts
path(path,'C:\Users\lizagee\Documents\_MATLAB_scripts\PF_POST\master_set')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   DOMAIN PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot_flag=1; %TURN PLOTTING ON/OFF
domain_flag=1;

xy_extent=100;%m
z_extent=2;%m
 
nbounds_x=20;%5m                                %num of cells in x-dir
nbounds_y=20;%5m                                %num of cells in y-dir
nbounds_z=40;%0.05m                             %num of cells in z-dir
Number_XY=nbounds_x*nbounds_y;                  %num of cells in xy plane
cell_number=nbounds_x*nbounds_y*nbounds_z;      %num of cells in domain
hr=[1:1:1989];                                  %simulation hours to process

rep_root_system_ID=[11,12,36,41,48,53,76,84,88,89,97,100,109,122,129];

%Directory location of PFLOTRAN output files
dir_fn=''
%PFLOTRAN output header
filename=[dir_fn,'pflotran_UMBS-'];

%Read in the simulated data
[rootsys_T, domain_T, P, S]= readPFData(filename, hr, rep_root_system_ID);

save([dir_fn,'all_vars.mat'],'-v7.3')
