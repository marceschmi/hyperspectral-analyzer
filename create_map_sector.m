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
function [x,y,pre_processed_data_map,label] = create_map_sector(PLMap_Data,area_dim,pre_processed_data_map,k,label)
%get the area size
[x_squer,y_squer,window_x,window_y] = define_area_size(PLMap_Data,area_dim);

%sets the area for the data
x_temp = PLMap_Data.X_vector(x_squer:window_x);
y_temp = PLMap_Data.Y_vector(y_squer:window_y);
pre_processed_data_map = pre_processed_data_map(y_squer:window_y,x_squer:window_x);

switch k
    case 0
        label{2} = 'X [mm]';
        label{3} = 'Y [mm]';
        x = x_temp;
        y = y_temp;
    case 1
        label{3} = 'X [mm]';
        label{2} = 'Y [mm]';
        x = y_temp;
        y = x_temp;
        pre_processed_data_map = rot90(pre_processed_data_map,k);
    case 2
        label{3} = 'X [mm]';
        label{2} = 'Y [mm]';
        x = y_temp;
        y = x_temp;
        pre_processed_data_map = rot90(pre_processed_data_map,k);
    case 3
        label{3} = 'X [mm]';
        label{2} = 'Y [mm]';
        x = y_temp;
        y = x_temp;
        pre_processed_data_map = rot90(pre_processed_data_map,k);
end
end

