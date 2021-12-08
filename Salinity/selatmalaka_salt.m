clc
clear all

% Better visualization using m_plot

%%
% Read variable data from a NetCDF source
salt_value=ncread('selatmalaka.nc4','salinity');
subsalt_value=salt_value(:,:,1,:);

% Mean value, ignoring NaNs for 4 dimension
avsubsalt_value= nanmean(subsalt_value,4); 

% Permute array dimensions
salt2_value=permute(avsubsalt_value,[2,1]);

% Cleansing
for i=1:53
    for j=1:30
         salt2_value(i,j)=nan;
    end
end
for i=1:30
    for j=1:50
         salt2_value(i,j)=nan;
    end
end
for i=1:64
    for j=110:119
         salt2_value(i,j)=nan;
    end
end
for i=20:64
    for j=90:119
         salt2_value(i,j)=nan;
    end
end
for i=1:5
    for j=100:110
         salt2_value(i,j)=nan;
    end
end

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

% save('selatmalaka.mat','salt2_value') %(opt.)
%%
% Load data from MAT-file into workspace
% load selatmalaka.mat %(opt.)

% Read variable data from a NetCDF source
y0=ncread('selatmalaka.nc4','lat');
x0=ncread('selatmalaka.nc4','lon');

% Domain 
LONLIMS= [95.5 105];
LATLIMS= [0.5 5.5];

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
title('Salinity in February 2017 Malacca Strait')
xlabel('Longitude')
ylabel('Latitude')
