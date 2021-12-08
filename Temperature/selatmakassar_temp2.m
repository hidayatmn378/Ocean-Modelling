clc
clear all

% Better Visualization using m_plot package (must add to your repo packages)

%%
% Display contents of a NetCDF source
ncdisp('selatmakassar.nc4');

% Read variable data from a NetCDF source
temp_value = ncread('selatmakassar.nc4','water_temp');
subtemp_value = temp_value(:,:,1,:);

% Mean value, ignoring NaNs for 4 dimension
avsubtemp_value = nanmean(subtemp_value,4);

% Permute array dimensions
temp2_value = permute(avsubtemp_value,[2,1]);

% % Visualization (poor quality)
% figure('Name','Temperature Data','NumberTitle','off');
% [c,h] = contourf(temp2_value)
% clabel(c,h)
% grid on
% colorbar
% title('Temperature in February 2017 Makassar Strait')
% xlabel('Longitude')
% ylabel('Latitude')

% save('selatmakassar.mat','temp2_value') %(opt.)
%%
% Load data from MAT-file into workspace
% load selatmakassar.mat; %(opt.)

% Read variable data from a NetCDF source
y0=ncread('selatmakassar.nc4','lat');
x0=ncread('selatmakassar.nc4','lon');

% Domain 
LONLIMS= [116 120.5]; 
LATLIMS= [-3 1]; 

% Longitude and Latitude (default)
lon=[-180:5:180]; 
lat=[90:-5:-90];
bts=[0:0.5:30];

% Initializes map projections info
m_proj('mercator','lon',LONLIMS,'lat',LATLIMS);

% Visualization
figure('Name','Temperature Data (2)','NumberTitle','off');
hold on
[c,h]=m_contourf(x0,y0,temp2_value,bts,'linewidth',1);
hold off
clabel(c,h,bts,'labelspacing',1444,'fontsize',8)
colorbar
m_gshhs_h('patch',[0.5 0.5 0.5]);
title('Temperature in Februari 2017 Makassar Strait')
xlabel('Longitude')
ylabel('Latitude')
