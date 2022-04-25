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
function [LowerWavelengthSpinner,UpperWavelengthSpinner,TemperatureSpinner,PowerSpinner,data_map,c] = update_map(PLMap_Data,...
    temperature,power,Wavelength_Value_start,Wavelength_Value_end,Defind_Map_Axis,color_steps,map_typ,...
    min_counts,max_counts,label,map_state,contour_state,n_contour_lines,contourtext,area_dim,lock_to_area_check)
%define start end end Wavelength index
start_wavelength_index = find_index(PLMap_Data.Wavelength,Wavelength_Value_start,1);
end_wavelength_index = find_index(PLMap_Data.Wavelength,Wavelength_Value_end,1);
power_index = find_index(PLMap_Data.Power,power,1);
temperature_index = find_index(PLMap_Data.Temperature_index,temperature,1);

%Sets Spinner Values to the Limets
LowerWavelengthSpinner = PLMap_Data.Wavelength(start_wavelength_index);
UpperWavelengthSpinner = PLMap_Data.Wavelength(end_wavelength_index);
TemperatureSpinner = PLMap_Data.Temperature_index(temperature_index);
PowerSpinner = PLMap_Data.Power(power_index);

[x_squer,y_squer,window_x,window_y] = define_area_size(PLMap_Data,area_dim);

%creats integrated Map
pre_processed_data_map = creat_Plot_Map(PLMap_Data.data_array,temperature_index,power_index,...
    x_squer,window_x,y_squer,window_y,start_wavelength_index,end_wavelength_index,map_state);

%allocat the data map for coppy to clipboard
data_map = pre_processed_data_map;

%displayes the map
[~,c] = Display_Map(Defind_Map_Axis,PLMap_Data.X_vector(x_squer:window_x),PLMap_Data.Y_vector(y_squer:window_y),...
    pre_processed_data_map,color_steps,map_typ,label,min_counts,...
    max_counts,contour_state,n_contour_lines,contourtext,lock_to_area_check);
end
