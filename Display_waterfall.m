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
function [Defind_Map_Axis,c] = Display_waterfall(Defind_Map_Axis,x,y,off_set,map_typ)
size_y = size(y);
for i = 1 : size_y(1)
    y(i,:) = y(i,:)+off_set*i;
end
color =  colormap_styles.compute_colarmap(map_typ,size_y(1));
plot(Defind_Map_Axis,x,y);
axis(Defind_Map_Axis,[min(x) max(x) min(y,[],'all') max(y,[],'all')]);
colormap(Defind_Map_Axis,color);
Defind_Map_Axis.ColorOrder = color;
c = colorbar(Defind_Map_Axis);
end