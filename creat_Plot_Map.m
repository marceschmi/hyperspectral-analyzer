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
function pre_processed_data_map = creat_Plot_Map(data_map,temperature_index,power_index,start_x,window_x,start_y,window_y,start_index,end_index,state)
pre_processed_data_map(:,:) = sum(data_map(temperature_index,power_index,start_y:window_y,start_x:window_x,start_index:end_index),5);
switch state
    case 'averaged'
        pre_processed_data_map = pre_processed_data_map ./ (end_index-start_index);
end
end

