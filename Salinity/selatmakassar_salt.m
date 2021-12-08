clc
clear all

% Better visualization using m_plot

%%
% Read variable data from a NetCDF source
salt_value=ncread('selatmakassar.nc4','salinity');
subsalt_value=salt_value(:,:,1,:);

% Mean value, ignoring NaNs for 4 dimension
avsubsalt_value= nanmean(subsalt_value,4); 

% Permute array dimensions
salt2_value=permute(avsubsalt_value,[2,1]);

% Visualization (poor result)
% figure('Name','Salinity Data','NumberTitle','off');
% subplot(1,2,1)
% [c,h]=contourf(salt2_value)
% clabel(c,h)
% grid on
% colorbar
% title('Salinity in February 2017 BOB')
% xlabel('Longitude')
% ylabel('Latitude')

% save('selatmakassar.mat','salt2_value') %(opt.)
%%
% Load data from MAT-file into workspace 
% load selatmakassar.mat %(opt.)

% Read variable data from a NetCDF source
y0=ncread('selatmakassar.nc4','lat');
x0=ncread('selatmakassar.nc4','lon');

% Domain 
LONLIMS= [116 120.5];
LATLIMS= [-3 1];

% Longitude and Latitude (default)
lon=[-180:5:180]; 
lat=[90:-5:-90];
bts=[0:0.5:40];

% Initializes map projections info
m_proj('mercator','lon',LONLIMS,'lat',LATLIMS);

% Visualization
figure('Name','Salinity Data (2)','NumberTitle','off');
hold on
[c,h]=m_contourf(x0,y0,salt2_value,bts,'linewidth',2);
clabel(c,h)
hold on
colormap jet
clabel(c,h,bts,'labelspacing',1444,'fontsize',8)
colorbar
m_gshhs_h('patch',[0.5 0.5 0.5]);
m_grid('linewidth',2,'tickdir','out');
caxis([30 35])
title('Salinity in February 2017 Makassar Strait')
xlabel('Longitude')
ylabel('Latitude')
