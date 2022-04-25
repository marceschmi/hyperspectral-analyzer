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
function [x_squer,y_squer,window_x,window_y] = define_area_size(PLMap_Data,area_dim)
%gets the dimantions of the area
%area_dim(1) = x_start_point
%area_dim(2) = y_start_point
%area_dim(3) = dx
%area_dim(4) = dy
if ~isempty(area_dim)
    x_squer = find_index(PLMap_Data.X_vector,area_dim(1),1);
    y_squer = find_index(PLMap_Data.Y_vector,area_dim(2),1);
    window_x = find_index(PLMap_Data.X_vector,area_dim(1) + area_dim(3),1);
    window_y = find_index(PLMap_Data.Y_vector,area_dim(2) + area_dim(4),1);
else
    x_squer = find_index(PLMap_Data.X_vector,min(PLMap_Data.X_vector),1);
    y_squer = find_index(PLMap_Data.Y_vector,min(PLMap_Data.Y_vector),1);
    window_x = length(PLMap_Data.X_vector);
    window_y = length(PLMap_Data.Y_vector);
end
end