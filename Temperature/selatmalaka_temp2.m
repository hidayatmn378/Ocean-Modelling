clc
clear all

% Better Visualization using m_plot package (must add to your repo packages)

%%
% Display contents of a NetCDF source
ncdisp('selatmalaka.nc4');

% Read variable data from a NetCDF source
temp_value = ncread('selatmalaka.nc4','water_temp');
subtemp_value = temp_value(:,:,1,:);

% Mean value, ignoring NaNs for 4 dimension
avsubtemp_value = nanmean(subtemp_value,4);

% Permute array dimensions
temp2_value = permute(avsubtemp_value,[2,1]);

%Cleansing 
for i=1:53
    for j=1:30
         temp2_value(i,j)=nan;
    end
end
for i=1:30
    for j=1:50
         temp2_value(i,j)=nan;
    end
end
for i=1:64
    for j=110:119
         temp2_value(i,j)=nan;
    end
end
for i=20:64
    for j=90:119
         temp2_value(i,j)=nan;
    end
end
for i=1:5
    for j=100:110
         temp2_value(i,j)=nan;
    end
end

% % Visualization (poor quality)
% figure('Name','Temperature Data','NumberTitle','off');
% [c,h] = contourf(temp2_value)
% clabel(c,h)
% grid on
% colorbar
% title('Temperature in February 2017 Malacca Strait')
% xlabel('Longitude')
% ylabel('Latitude')

% save('selatmalaka.mat','temp2_value') %(opt.)
%%
% Load data from MAT-file into workspace
% load selatmalaka.mat; %(opt.)

% Read variable data from a NetCDF source
y0=ncread('selatmalaka.nc4','lat');
x0=ncread('selatmalaka.nc4','lon');

% Domain 
LONLIMS= [95.5 105]; 
LATLIMS= [0.5  5.5]; 

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
title('Temperature in Februari 2017 Malacca Strait')
xlabel('Longitude')
ylabel('Latitude')
