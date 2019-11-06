function [actual_T_root, domain_T, P, S] = readPFData(filehead)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CONSTRUCT FILE NAMES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global nbounds_x nbounds_y nbounds_z xy_extent z_extent hr rep_root_system_ID
cell_number=nbounds_x*nbounds_y*nbounds_z;
filetail='.h5';

filemid=cell(length(hr),1);
filename=cell(length(hr),1);
for m=1:length(hr)
    if hr(m)<1000
        filemid{m}=num2str(hr(m),'%03d');
    else
        filemid{m}=num2str(hr(m));
    end
    filename{m}=[filehead, filemid{m}, filetail];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% READ IN DATA FOR SPECIFIED HOUR RANGE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ~isempty(rep_root_system_ID)
actual_T_root=cell(length(rep_root_system_ID),length(hr));
else
    actual_T_root=[];
end
h=waitbar(0,'Reading in PFLOTRAN output files...');
for m=1:length(hr)
    if ~isempty(rep_root_system_ID)
    for n=1:length(rep_root_system_ID)
        %Read in actual transpiration for the root system [kg/s]
        actual_T_root{n,m}=sparse(reshape(hdf5read(filename{m},['/Time:  ', num2str(hr(m),'%0.5E'),...
            ' h/T_RootSystem',num2str(rep_root_system_ID(n)),' [kg_m^2_s]']),cell_number,1));
    end
    end
    %Read in domain actual transpiration [kg/s]
    domain_T{m}=reshape(hdf5read(filename{m},['/Time:  ', num2str(hr(m),'%0.5E'),...
        ' h/Actual_Transpiration [kg_m^2_s]']),cell_number,1); 
    %Read in liquid pressure (matric) for the domain [Pa]
    P{m}=reshape(hdf5read(filename{m},['/Time:  ', num2str(hr(m),'%0.5E'),...
        ' h/Liquid_Pressure [Pa]']),cell_number,1); 
    %Read in relative saturation for the domain [-]
    S{m}=hdf5read(filename{m},['/Time:  ', num2str(hr(m),'%0.5E'),...
        ' h/Liquid_Saturation']);
    %display(['Hour ',num2str(m),' recorded.']);
    waitbar(m./length(hr))
end
close(h)
display(['Data read in for ',filehead])
end