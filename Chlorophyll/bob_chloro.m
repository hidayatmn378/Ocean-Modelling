clc
clear all

% Better visualization using m_map

%%
% Display contents of a NetCDF source
ncdisp('bob.nc');

% Read variable data from a NetCDF source
chloro_value = ncread('bob.nc','chlorophyll');
subchloro_value = chloro_value(:,:,1,:);

% Mean value, ignoring NaNs for 4 dimension
avsubchloro_value = nanmean(subchloro_value,4);

% Permute array dimensions
chloro2_value = permute(avsubchloro_value,[2,1]);

% % Visualization
% figure('Name','Chlorophyll-a Data','NumberTitle','off');
% [c,h] = contourf(chloro2_value)
% clabel(c,h)
% grid on
% colorbar
% title('Chlorophyll-a in February 2017')
% xlabel('Longitude')
% ylabel('Latitude')

% save('chloro0217.mat','chloro2_value') %(opt.)
%%
% Load data from MAT-file into workspace
% load chloro0217.mat %(opt.)

% Read variable data from a NetCDF source
y0=ncread('bob.nc','latitude');
x0=ncread('bob.nc','longitude');

% Domain 
LONLIMS= [78.2 96.7];
LATLIMS= [5.5 24.6]; 

% Longitude and Latitude (default)
lon=[-180:5:180]; 
lat=[90:-5:-90];
bts=[0:1:15];

% Initializes map projections info
m_proj('mercator','lon',LONLIMS,'lat',LATLIMS);

% Visualization
figure('Name','Chlorophyll-a Data (2)','NumberTitle','off');
shading interp
hold on
[c,h]=m_contour(x0,y0,chloro2_value,bts,'linewidth',2)
m_pcolor(x0,y0,log10(chloro2_value));
hold on
clabel(c,h,bts,'labelspacing',1444,'fontsize',12)
caxis([-1 1]) 
colorbar('EastOutside','XTick',[-1 0  0.3010 0.4771  0.669  1],'XTickLabel',{'0.1','1','2','3','5','10'})
m_gshhs_h('patch',[0.5 0.5 0.5]);
m_grid('linewidth',1,'tickdir','out');
title('Chlorophyll-a BOB')
% print('gambar','-dpng')

