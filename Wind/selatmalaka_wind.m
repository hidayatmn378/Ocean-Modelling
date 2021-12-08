close all
clc
clear all

%%
% Display contents of a NetCDF source
ncdisp('selatmalaka.nc') 

% Read variable data from a NetCDF source
u0=ncread('selatmalaka.nc','x_wind'); 
v0=ncread('selatmalaka.nc','y_wind'); 
lat=ncread('selatmalaka.nc','latitude'); 
lon=ncread('selatmalaka.nc','longitude'); 

% Permute array dimensions
u0_02=permute(u0,[2,1,4,3]); 
v0_02=permute(v0,[2,1,4,3]);

p=0.25;D=2;
uu=u0_02(:,:,1);
vv=v0_02(:,:,1);
 
[x0 y0]=meshgrid(lon,lat);

w0=hypot(uu,vv);

uu_02=uu./sqrt(uu.^2+vv.^2);
vv_02=vv./sqrt(uu.^2+vv.^2);

uu02=uu_02(1:D:end);
vv02=vv_02(1:D:end);

x00=x0(1:D:end);
y00=y0(1:D:end);

LONLIMS= [95.5  105]; 
LATLIMS= [0.5  5.5];

lon=[-180:0.125:180];
lat=[90:-0.125:-90];
bts=[0:0.5:5]; 

% Initializes map projections info
m_proj('mercator','lon',LONLIMS,'lat',LATLIMS); 

% Visualization
figure('Name','Wind Data','NumberTitle','off');
hold on
[c,h]=m_contour(x0,y0,w0,bts,'linewidth',1.2)
clabel(c,h)
hold on
%  shading interp
colormap('jet')
caxis([0 5])
colorbar
m_quiver(x00,y00,p*uu02,p*vv02,0,'k')
m_gshhs_h('patch',[0.5 0.5 0.5]);
m_grid('linewi',2,'tickdir','out');
xlabel('Longitude')
ylabel('Latitude')
title('Wind in February Malacca Strait')

