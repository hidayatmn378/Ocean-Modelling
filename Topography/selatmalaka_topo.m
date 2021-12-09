clc
clear all
 
% data Topography Selat Malaka

%%
% Display contents of a NetCDF source
ncdisp('selatmalaka.nc')

% Read variable data from a NetCDF source
% z is a variable inside the srtm.nc
s2=ncread('selatmalaka.nc','z'); 
 
% Permute array dimensions
s3=permute(s2,[2,1]);

% Assigning m with row and n with column from s3
[m n]=size(s3)
 

for i=1:m   % Latitude part
    for j=1:n   % Longitude part
        if s3(i,j)>=0;
            s3(i,j)=NaN;
        end
    end
end
for i=1:500     
    for j=1:250     
         s3(i,j)=NaN;
    end
end
for i=1:300
    for j=1:500
         s3(i,j)=NaN;
    end
end
for i=150:600
    for j=900:1141
         s3(i,j)=NaN;
    end
end
for i=100:150
    for j=1000:1141
         s3(i,j)=NaN;
    end
end

% Read variable data from a NetCDF source
lat=ncread('selatmalaka.nc','latitude'); 
lon=ncread('selatmalaka.nc','longitude'); 

% Boundaries for each layers
bts=[5:10:50 100 150 200 350 500 750 1000 2000]; 

% Visualization
figure('Name','Topography Data','NumberTitle','off');
[x,y]=meshgrid(1:n,1:m);
[c,h]=contourf(x,y,-s3,bts);
clabel(c,h)
grid on
set(gca,'xtick',10:12*10:n)
set(gca,'xticklabel',lon(10:12*10:end))
set(gca,'ytick',10:12*10:m)
set(gca,'yticklabel',lat(10:12*10:end))
xlabel('Longitude');
ylabel('Latitude');
colorbar 
caxis([0 100]);
title('Topography Malacca Strait');

