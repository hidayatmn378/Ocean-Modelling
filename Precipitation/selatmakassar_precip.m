clc
clear all

%%
% Display contents of a NetCDF source
ncdisp('selatmakassar.nc')
 
% Read variable data from a NetCDF source
prec_value=ncread('selatmakassar.nc','tp');

% Mean value, ignoring NaNs for 4 dimension
avprec_value=nanmean(prec_value,3);

% Permute array dimensions
prec2_value=permute(avprec_value,[2,1]);

% Read variable data from a NetCDF source
x=ncread('selatmakassar.nc','longitude');
y=ncread('selatmakassar.nc','latitude');

r=1
xx=x(1:r:end);
yy=y(1:r:end);
ss=prec2_value(1:r:end,1:r:end);

% Visualization
figure('Name','Precipitation Data','NumberTitle','off');
[c,h]=contour(xx,yy,ss)
clabel(c,h,'labelspacing',149,'fontsize',10)
colormap jet
grid on
colorbar
title('Precipitation in February 2017 Makassar Strait')
xlabel('Longitude')
ylabel('Latitude')
