clc
clear all
 
% Better visualization using m_plot
 
%%
% Display contents of a NetCDF source
water_vel='selatmalaka.nc4'
ncdisp(strcat(water_vel))
 
% Read variable data from a NetCDF source
u=ncread(water_vel,'water_u');
v=ncread(water_vel,'water_v');
 
sub_u=u(:,:,1,:); 
sub_v=v(:,:,1,:); 

% Mean value, ignoring NaNs for 4 dimension
nsub_u=nanmean(sub_u,4); 
nsub_v=nanmean(sub_v,4); 

% Permute array dimensions
us=permute(nsub_u,[2,1]);
vs=permute(nsub_v,[2,1]);  

%% 
% Read variable data from a NetCDF source
r=8
x=ncread(water_vel,'lon')';
y=ncread(water_vel,'lat')';

[x0,y0]=meshgrid(x,y);
xx=x0(1:r:end,1:r:end);
yy=y0(1:r:end,1:r:end);

p=2 
uu=us(1:r:end,1:r:end);
vv=vs(1:r:end,1:r:end);

% return to norm and carefully computed to avoid underflow and overflow
w0=hypot(us,vs);
 
% domain
LONLIMS= [95.5 105]; 
LATLIMS= [0.5 5.5]; 
 
% Longitude and Latitude (default)
lon=[-180:0.125:180];
lat=[90:-0.125:-90];
bts=[0:0.1:5]; 
 
% Initializes map projections info
m_proj('mercator','lon',LONLIMS,'lat',LATLIMS);

%%
% Visualization
figure('Name','Velocity u,v Data','NumberTitle','off');
m_pcolor(x0,y0,w0)
[c,h]=m_contour(x0,y0,w0,bts,'linewidth',1);
clabel(c,h,bts)
hold on

% shading interp
colorbar
colormap('jet')
uu = uu./hypot(uu,vv);
vv = vv./hypot(uu,vv);
m_quiver(xx,yy,p*uu,p*vv,0,'k')
m_gshhs_h('patch',[0.4 0.4 0.4]);
m_grid('linewi',2,'tickdir','out');
xlabel('Longitude')
ylabel('Latitude') 
title('Current Velocity in February 2017 Malacca Strait');
