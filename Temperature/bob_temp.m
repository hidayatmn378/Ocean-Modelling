clc
clear all

% data Temperature BOB

%%
% Display contents of a NetCDF source
ncdisp('bob.nc4');

% Read variable data from a NetCDF source
temp_value = ncread('bob.nc4','water_temp');
subtemp_value = temp_value(:,:,1,:);

% Mean value, ignoring NaNs for 4 dimension
avsubtemp_value = nanmean(subtemp_value,4);

% Permute array dimensions
temp2_value = permute(avsubtemp_value,[2,1]);

% Visualization
figure('Name','Temperature Data','NumberTitle','off');
[c,h] = contourf(temp2_value)
clabel(c,h)
grid on
colorbar
title('Temperature in February 2017 BOB')
xlabel('Longitude')
ylabel('Latitude')

save('bob.mat','temp2_value')
