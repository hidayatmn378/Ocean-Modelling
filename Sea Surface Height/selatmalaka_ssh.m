clc
clear all

% Better visualization using m_plot

%%
% Display contents of a NetCDF source
ncdisp('selatmalaka.nc4');

% Read variable data from a NetCDF source
surff=ncread('selatmalaka.nc4','surf_el');
surff1=surff(:,:,1,:);

% Mean value, ignoring NaNs for 4 dimension
avsurff1= nanmean(surff1,4); 

% Permute array dimensions
surff2=permute(avsurff1,[2,1]);
 
% Cleansing
for i=1:53
    for j=1:30
         surff2(i,j)=nan;
    end
end
for i=1:30
    for j=1:50
         surff2(i,j)=nan;
    end
end
for i=1:64
    for j=110:119
         surff2(i,j)=nan;
    end
end
for i=20:64
    for j=90:119
         surff2(i,j)=nan;
    end
end
for i=1:5
    for j=100:110
         surff2(i,j)=nan;
    end
end

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
y0=ncread('selatmalaka.nc4','lat');
x0=ncread('selatmalaka.nc4','lon');

% Domain 
LONLIMS= [95.5  105]; 
LATLIMS= [0.5  5.5]; 
 
% Longitude and Latitude (default)
lon=[-180:5:180];
lat=[90:-5:-90];
bts=[0:0.01:2]

% Initializes map projections info
m_proj('mercator','lon',LONLIMS,'lat',LATLIMS);

% Visualization
figure('Name','Surface Data (2)','NumberTitle','off');
hold on
[c,h]=m_contourf(x0,y0,surff2,bts,'linewidth',1); 
clabel(c,h,bts,'labelspacing',1444,'fontsize',12);
colorbar
title('Surface Elevation in February Malacca Strait');
xlabel('Longitude');
ylabel('Latitude');
m_gshhs_h('patch',[0.5 0.5 0.5]);
m_grid('linewi',2,'tickdir','out');
hold off

