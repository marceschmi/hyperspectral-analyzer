%--------------------------------------------------------------------------
% Copyright (c) 2022 Marcel Schmidt
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU Affero General Public License as published
% by the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU Affero General Public License for more details.
%
% You should have received a copy of the GNU Affero General Public License
% along with this program.  If not, see <https://www.gnu.org/licenses/>.
%--------------------------------------------------------------------------
function [gaas_growth_rate_raw,gaas_growth_rate,gaas_growth_rate_rot,qw_growth_rate,sf_gaas,x_qw,sf_qw,gaas_a_map,qw_a_map] = create_rates_from_pl_data(data_pl_map,fit_data,Fit_Data_function_parameter,file_qw,t,p,peak_gaas,peak_qw,fit_gaas,fit_qw,t_growth_gaas,t_growth_qw,center,degr)
% file_gaas and file_qw have to be in the same folder -> path_sim
% for the fit_data peak positions have do be saved as energy
tic

%% Import Sim Data InGaAs
%read values from the file
Data_temp = load('GaAs');
data_GaAs = Data_temp.data;
clear Data_temp

%% Import Sim Data AlGaAs
%read values from the file
Data_temp = load('AlGaAs');
data_AlGaAs = Data_temp.data;
clear Data_temp

%% Import Sim Data InGaAs
%read values from the file
Data_temp = load('InGaAs');
data_InGaAs = Data_temp.data;
clear Data_temp

%% get temperature values
tamperature_map = creat_temp_Map(data_pl_map.Temperature_array,1,1,1,length(data_pl_map.X_vector),1,length(data_pl_map.Y_vector));
T_min = min(tamperature_map,[],'all');
T_max = max(tamperature_map,[],'all');

%% interpolate GaAs nextnano data in temperature range
interp_GaAs_wavelength = data_GaAs.hhole_transistion_wavelength;
interp_GaAs_d_QW = data_GaAs.d_QW;
interp_GaAs_T = data_GaAs.T;

% iterpolate temperature Dim
steps = 0.1;
xq = [T_min : steps : T_max];

size_interp = size(interp_GaAs_wavelength);
interp_wavelength_temp = nan(size_interp(1),size_interp(2),numel(xq));

for i = 1 : numel(interp_GaAs_d_QW)
    wavlength_temp = interp_GaAs_wavelength(i,1,:);
    yq = makima(interp_GaAs_T,wavlength_temp,xq);
%     wavlength_blub(:) = wavlength_temp(:);
%     plot(xq,yq,'*',interp_GaAs_T,wavlength_blub,'*')
    interp_wavelength_temp(i,1,:) = yq; 
end
interp_GaAs_T = xq;
interp_GaAs_wavelength = interp_wavelength_temp;

%% interpolate AlGaAs nextnano data in temperature range
interp_AlGaAs_wavelength = data_AlGaAs.hhole_transistion_wavelength;
interp_AlGaAs_d_QW = data_AlGaAs.d_QW;
interp_AlGaAs_x_QW = data_AlGaAs.x_QW;
interp_AlGaAs_T = data_AlGaAs.T;

% iterpolate temperature Dim
steps = 0.1;
xq = [T_min : steps : T_max];

size_interp = size(interp_AlGaAs_wavelength);
interp_wavelength_temp = nan(size_interp(1),size_interp(2),numel(xq));

for i = 1 : numel(interp_AlGaAs_d_QW)
    for j = 1 : numel(interp_AlGaAs_x_QW)
        wavlength_temp = interp_AlGaAs_wavelength(i,j,:);
        yq = makima(interp_AlGaAs_T,wavlength_temp,xq);
%         wavlength_blub(:) = wavlength_temp(:);
%         plot(xq,yq,'*',interp_AlGaAs_T,wavlength_blub,'*')
        interp_wavelength_temp(i,j,:) = yq;
    end
end
interp_AlGaAs_T = xq;
interp_AlGaAs_wavelength = interp_wavelength_temp;

%% interpolate InGaas nextnano data in temperature range
interp_InGaAs_wavelength = data_InGaAs.hhole_transistion_wavelength;
interp_InGaAs_d_QW = data_InGaAs.d_QW;
interp_InGaAs_x_QW = data_InGaAs.x_QW;
interp_InGaAs_T = data_InGaAs.T;

% iterpolate temperature Dim
steps = 0.1;
xq = [T_min : steps : T_max];

size_interp = size(interp_InGaAs_wavelength);
interp_wavelength_temp = nan(size_interp(1),size_interp(2),numel(xq));

for i = 1 : numel(interp_InGaAs_d_QW)
    for j = 1 : numel(interp_InGaAs_x_QW)
        wavlength_temp = interp_InGaAs_wavelength(i,j,:);
        yq = makima(interp_InGaAs_T,wavlength_temp,xq);
%         wavlength_blub(:) = wavlength_temp(:);
%         plot(xq,yq,'*',interp_InGaAs_T,wavlength_blub,'*')
        interp_wavelength_temp(i,j,:) = yq;
    end
end
interp_InGaAs_T = xq;
interp_InGaAs_wavelength = interp_wavelength_temp;

%% get statistics
%get the raw data into matrix
parameter_array(:,:) = Fit_Data_function_parameter(fit_gaas,t,p,:,:);
n_fitparameter = [];
n_fitparameter = max(parameter_array,[],'all');

[gaas_peak_wavelength,~,~] = get_fit_data(data_pl_map,fit_data,fit_data,p,t,fit_gaas,peak_gaas,2,n_fitparameter);

parameter_array = [];
parameter_array(:,:) = Fit_Data_function_parameter(fit_qw,t,p,:,:);
n_fitparameter = [];
n_fitparameter = max(parameter_array,[],'all');
[qw_peak_wavelength,~,~] = get_fit_data(data_pl_map,fit_data,fit_data,p,t,fit_qw,peak_qw,2,n_fitparameter);


%transforms enegies to wavelength
if any((gaas_peak_wavelength < 10),'all')
    gaas_peak_wavelength = converter.energy_wavelength(gaas_peak_wavelength);
end

if any((qw_peak_wavelength < 10),'all')
    qw_peak_wavelength = converter.energy_wavelength(qw_peak_wavelength);
end

size_of_gaas_map = size(gaas_peak_wavelength);
size_of_qw_map = size(qw_peak_wavelength);

%get middle point
x_mid = find_index(data_pl_map.X_vector,38,1);
y_mid = find_index(data_pl_map.Y_vector,38,1);
gaas_midd_wavelength = gaas_peak_wavelength(y_mid,x_mid);
qw_midd_wavelength = qw_peak_wavelength(y_mid,x_mid);

%wavlength differece
wavelength_differece_gaas = gaas_peak_wavelength-gaas_midd_wavelength;
wavelength_differece_qw = qw_peak_wavelength-qw_midd_wavelength;

%% get gaas qw sizes
gaas_peak_wavelength_V = gaas_peak_wavelength(:);

tamperature_map_V = tamperature_map(:);
gaas_a_map = nan(length(gaas_peak_wavelength_V),1);

for i = 1 : length(gaas_peak_wavelength_V)
    if ~isnan(gaas_peak_wavelength_V(i))
        index_T = find_index(interp_AlGaAs_T,tamperature_map_V(i),1);
        wavelength_for_T = interp_GaAs_wavelength(:,index_T);
        
        %interpolat the data at the correct temperature
        %and find the value 
        pp = makima(wavelength_for_T,interp_GaAs_d_QW);
        gaas_a_map(i) = ppval(pp,gaas_peak_wavelength_V(i));
        %display the result to convinice people of a nice fit
%         wavelength_test = gaas_peak_wavelength_V(i)
%         gaas_a_map_test = gaas_a_map(i)
%         [wavelength_test_min,wavelength_test_max] = bounds(wavelength_for_T);
%         wavelength_test_steps = wavelength_for_T(2)-wavelength_for_T(1);
%         wavelength_test_range = wavelength_test_min : wavelength_test_steps/100 : wavelength_test_max;
%         d_test_precise = ppval(pp,wavelength_test_range);
%         if index_T == 7
%             if (7.4968 < gaas_a_map_test) && (gaas_a_map_test < 7.505)
%                 figure
%                 ax1 = axes('Position',[0.2 0.1 0.7 0.8]);
%                 ax2 = axes('Position',[0.25 0.65 0.15 0.2]);
%                 plot(ax1,wavelength_for_T,interp_GaAs_d_QW,'.',gaas_peak_wavelength_V(i),gaas_a_map(i),'*');
%                 plot(ax2,wavelength_for_T,interp_GaAs_d_QW,'.',gaas_peak_wavelength_V(i),gaas_a_map(i),'*');
%             end
%         end
        %plot(wavelength_test_range,d_test_precise,gaas_peak_wavelength_V(i),gaas_a_map(i),'*');
    end
end
%plot(wavelength_for_T,interp_GaAs_d_QW,'.',gaas_peak_wavelength_V,gaas_a_map,'*');
gaas_a_map = reshape(gaas_a_map,size_of_gaas_map);

%% get gaas growth rate matrix
gaas_growth_rate = growth_rate.calculate_growth_rate(gaas_a_map,t_growth_gaas);

% create vectors
j = 0;
for ix = 1 : numel(data_pl_map.X_vector)
    for iy = 1 : numel(data_pl_map.Y_vector)
        j = j+1;
        x(j,1) = data_pl_map.X_vector(ix);
        y(j,1) = data_pl_map.Y_vector(iy);
        z(j,1) = gaas_growth_rate(iy,ix);
        qw_vector(j,1) = qw_peak_wavelength(iy,ix);
    end
end

z_fit = z;

%correct the position to center of growth
x_center = x - center(1,1);
y_center = y - center(1,2);
coords = [x_center,y_center];

TF = isnan(z);
x_center(TF) = [];
y_center(TF) = [];
z_fit(TF) = [];

sf_gaas = fit([x_center, y_center],z_fit,'poly55');
%plot(sf_gaas,[x_center,y_center],z_fit);

Z = sf_gaas(coords);
Z(sqrt((coords(:,1)).^2+(coords(:,2)).^2)>=38,:) = nan;
Z = reshape(Z,numel(data_pl_map.X_vector),numel(data_pl_map.Y_vector));
%surf(data_pl_map.X_vector,data_pl_map.Y_vector,Z);

%define the raw rates and the fitted rates
gaas_growth_rate_raw = gaas_growth_rate;
gaas_growth_rate = Z;

%% center average
% i_center_average = 0;
% for x_center_average = -0.5 : 0.5 : 0.5
%     for y_center_average = -0.5 : 0.5 : 0.5
%         i_center_average = i_center_average + 1;
%         x_center_average_full(i_center_average,1) = x_center_average;
%         y_center_average_full(i_center_average,1) = y_center_average;
%     end
% end
% coords_center_average = [x_center_average_full,y_center_average_full];
% Z_center_average = sf_gaas(coords_center_average);
% center_average = mean(Z_center_average)

%% rotate ga growthrate
rad = degr*pi/180;
R = [cos(rad) -sin(rad); sin(rad) cos(rad)];
vr =  R*coords';

%evaluat the rotatet points at the fit fuction
%as the points have the same index as before and are compared with the
%not rotated data at the same index it is the same as if the wafer had been
%rotated in the MBE
gaas_growth_rate_rot_temp = sf_gaas(vr');
gaas_growth_rate_rot_temp(sqrt((coords(:,1)).^2+(coords(:,2)).^2)>=38,:) = nan;

%% define composition range and prelocate matrix
size_of_gaas_growth_rate_rot = size(gaas_growth_rate_rot_temp);
qw_growth_rate_temp = nan(size_of_gaas_growth_rate_rot);
x_qw_temp = nan(size_of_gaas_growth_rate_rot);
qw_a_map_temp = nan(size_of_gaas_growth_rate_rot);

%% define the qw
switch file_qw
    case 'algaas'
        Yq = interp_AlGaAs_x_QW;
        Xq = interp_AlGaAs_d_QW;
        Vq = interp_AlGaAs_wavelength;
        Tq = interp_AlGaAs_T;
    case 'ingaas'
        Yq = interp_InGaAs_x_QW;
        Xq = interp_InGaAs_d_QW;
        Vq = interp_InGaAs_wavelength;
        Tq = interp_InGaAs_T;
end

x_pl = data_pl_map.X_vector;
y_pl = data_pl_map.Y_vector;

%% interpolate the qw
parfor i = 1 : size_of_gaas_growth_rate_rot(1,1)
    if ~isnan(gaas_growth_rate_rot_temp(i))
        %get the temperature for the point
        index_T_x = find_index(x_pl,x(i),1);
        index_T_y = find_index(y_pl,y(i),1);
        index_T = find_index(Tq,tamperature_map(index_T_y,index_T_x),1);
        
        %get the wavlength for all coresponding thicknesses and
        %compositions
        d = thickness_composition_relation(t_growth_qw,gaas_growth_rate_rot_temp(i),Yq);
        
        %interpolate the wavelength coresponding to the thicknesses at
        %the relativ compositions
        wavelength_at_point = nan(1,length(Yq));
        for k = 1:length(d)
            wavelength_temp = Vq(:,k,index_T);
            %interpolat the data and find the value
            pp = makima(Xq,wavelength_temp);
            wavelength_at_point(k) = ppval(pp,d(k));
            %plot the curve for checking
            %plot(Xq,wavelength_temp,'*',d(k),wavelength_at_point(k),'*');
        end
        
        %interpolate the wavelength at the coresponding compositions and
        %find the measured value on the curve
        pp = makima(wavelength_at_point,Yq);
        x_qw_temp(i) = ppval(pp,qw_vector(i));
        
        %plot the value for checking
%         test_a = qw_vector(i);
%         test_b = x_qw_temp(i);
%         if ~isnan(test_a)
%             blub = 1;
%         end
        %plot the curve for checking
        %plot(wavelength_at_point,Yq,'*',test_a,test_b,'*');
        
        qw_growth_rate_temp(i) = growth_rate.calculate_ternary(x_qw_temp(i),gaas_growth_rate_rot_temp(i));
        qw_a_map_temp(i) = t_growth_qw*(qw_growth_rate_temp(i)+gaas_growth_rate_rot_temp(i));
    end
end

%% reshape the qw to matrix form
x_qw = reshape(x_qw_temp,numel(data_pl_map.X_vector),numel(data_pl_map.Y_vector));
qw_growth_rate = reshape(qw_growth_rate_temp,numel(data_pl_map.X_vector),numel(data_pl_map.Y_vector));
qw_a_map = reshape(qw_a_map_temp,numel(data_pl_map.X_vector),numel(data_pl_map.Y_vector));
gaas_growth_rate_rot = reshape(gaas_growth_rate_rot_temp,numel(data_pl_map.X_vector),numel(data_pl_map.Y_vector));

%% fit qw growthrate
j = 0;
for ix = 1 : numel(data_pl_map.X_vector)
    for iy = 1 : numel(data_pl_map.Y_vector)
        j = j+1;
        x(j,1) = data_pl_map.X_vector(ix);
        y(j,1) = data_pl_map.Y_vector(iy);
        z(j,1) = qw_growth_rate(iy,ix);
    end
end

%correct the position to center of growth
x = x - center(1,1);
y = y - center(1,2);

coords = [x,y];

TF = isnan(z);
x(TF) = [];
y(TF) = [];
z(TF) = [];

%fit
sf_qw = fit([x, y],z,'poly55');
%plot(sf_qw,[x,y],z);

% Z = sf_qw(coords);
% Z(sqrt((coords(:,1)).^2+(coords(:,2)).^2)>=38,:) = nan;
% Z = reshape(Z,numel(data_pl_map.X_vector),numel(data_pl_map.Y_vector));
% surf(unique(coords(:,1)),unique(coords(:,2)),Z);
toc
end