function [cellid, i,j,k] = xyzToCellID(xyz,x_all_cellNo,y_all_cellNo,xres,yres,zres)
%function which converts xyz coordinates to cellid, i, j, and k
    j=ceil(xyz(1)/xres);
    i=ceil(xyz(2)/yres);
    k=floor(xyz(3)/zres);
    
    %need to fix cellid
    cellid=(k-1)*x_all_cellNo*y_all_cellNo+(i-1)*x_all_cellNo+j;
end

