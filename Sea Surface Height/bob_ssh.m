clc
clear all

% Better visualization using m_plot

%%
% Display contents of a NetCDF source
ncdisp('bob.nc4');

% Read variable data from a NetCDF source
surff=ncread('bob.nc4','surf_el');
surff1=surff(:,:,1,:);

% Mean value, ignoring NaNs for 4 dimension
avsurff1= nanmean(surff1,4); 

% Permute array dimensions
surff2=permute(avsurff1,[2,1]);
 
% % Visualization
% figure('Name','Surface Data','NumberTitle','off');
% [c,h]=contourf(surff2);
% clabel(c,h)
% grid on
% colorbar
% title('Surface Elevation in February 2017')
% xlabel('Longitude')
% ylabel('Latitude')

% Save into mat file
% save('surf0217.mat','surff2') %(opt.)
%%
% Load data from MAT-file into workspace
% load surf0217.mat; %(opt.)

% Read variable data from a NetCDF source
y0=ncread('bob.nc4','lat');
x0=ncread('bob.nc4','lon');

% Domain 
LONLIMS= [78.2 96.7]; 
LATLIMS= [5.5 24.6]; 
 
% Longitude and Latitude (default)
lon=[-180:5:180];
lat=[90:-5:-90];
bts=[0:0.1:2]

% Initializes map projections info
m_proj('mercator','lon',LONLIMS,'lat',LATLIMS);

% Visualization
figure('Name','Surface Data (2)','NumberTitle','off');
hold on
[c,h]=m_contourf(x0,y0,surff2,bts,'linewidth',1); 
clabel(c,h,bts,'labelspacing',1444,'fontsize',12);
colorbar
title('Surface Elevation in February BOB');
xlabel('Longitude');
ylabel('Latitude');
m_gshhs_h('patch',[0.5 0.5 0.5]);
m_grid('linewi',2,'tickdir','out');
hold off

