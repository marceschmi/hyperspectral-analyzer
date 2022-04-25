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
function [pre_processed_data_map,last_fit_map,c_fit_map] = Display_Fit_Map(PLMap_Data,area_dim,pre_processed_data_map,k,...
    Defind_Map_Axis,MapColorsteps,map_typ_fit_data,label,MapMinCount,MapMaxCount,ContourCheck,contour_lines,contourtext,...
    locktoareaCheck)
%reduce the area to the desierd size or rotate the area
[x,y,pre_processed_data_map,label] = create_map_sector(PLMap_Data,area_dim,pre_processed_data_map,k,label);

%displayes the map
[last_fit_map,c_fit_map] = Display_Map(Defind_Map_Axis,x,y,...
    pre_processed_data_map,MapColorsteps,map_typ_fit_data,label, ...
    MapMinCount,MapMaxCount,ContourCheck,contour_lines,contourtext,locktoareaCheck);
end

