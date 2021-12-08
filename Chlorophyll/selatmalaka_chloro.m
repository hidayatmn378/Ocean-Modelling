clc
clear all

% Better visualization using m_map

%%
% Display contents of a NetCDF source
ncdisp('selatmalaka.nc');

% Read variable data from a NetCDF source
chloro_value = ncread('selatmalaka.nc','chlorophyll');
subchloro_value = chloro_value(:,:,1,:);

% Mean value, ignoring NaNs for 4 dimension
avsubchloro_value = nanmean(subchloro_value,4);

% Permute array dimensions
chloro2_value = permute(avsubchloro_value,[2,1]);
[m n] = size(chloro2_value); 
%Cleansing 
for i=1:m
    for j=1:10
         chloro2_value(i,j)=nan;
    end
end
for i=25:m
    for j=1:50
         chloro2_value(i,j)=nan;
    end
end
for i=50:m
    for j=1:90
         chloro2_value(i,j)=nan;
    end
end
for i=1:70
    for j=150:n
         chloro2_value(i,j)=nan;
    end
end
for i=70:90
    for j=200:n
         chloro2_value(i,j)=nan;
    end
end

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
y0=ncread('selatmalaka.nc','latitude');
x0=ncread('selatmalaka.nc','longitude');

% Domain 
LONLIMS= [95.5  105];
LATLIMS= [0.5  5.5]; 

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
title('Chlorophyll-a Malacca Strait')
% print('gambar','-dpng')

