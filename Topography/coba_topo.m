clc; clear all ;
ncfile = 'selatmalaka.nc' ;
ncdisp(ncfile)
long = ncread(ncfile,'longitude') ;nx = length(long) ;
lat = ncread(ncfile,'latitude') ; ny = length(lat) ;
z = ncread(ncfile,'z') ; nt = length(z) ;
% TCO = ncread(ncfile,'TCO') ;
[X,Y] = meshgrid(long,lat) ;
for i = 1:nt
    pcolor(X,Y,z') ;
    shading interp ;
%     title(sprintf('time = %f',time(i)))
%     pause(1)
end