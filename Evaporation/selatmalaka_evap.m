clc
clear all

%%
% Display contents of a NetCDF source
ncdisp('selatmalaka.nc')

% Read variable data from a NetCDF source
eva_value=ncread('selatmalaka.nc','e');

% Mean value, ignoring NaNs for 4 dimension
aveva_value=nanmean(eva_value,3);

% Permute array dimensions
eva2_value=permute(aveva_value,[2,1]);

% Read variable data from a NetCDF source
x=ncread('selatmalaka.nc','longitude');
y=ncread('selatmalaka.nc','latitude');
 
r=1
xx=x(1:r:end);
yy=y(1:r:end);
ss=eva2_value(1:r:end,1:r:end);

% Visualization
figure('Name','Evaporation Data','NumberTitle','off');
[c,h]=contour(xx,yy,ss)
clabel(c,h,'labelspacing',149,'fontsize',10)
colormap jet
grid on
colorbar
title('Evaporation in February 2017 Malacca Strait')
xlabel('Longitude')
ylabel('Latitude')

