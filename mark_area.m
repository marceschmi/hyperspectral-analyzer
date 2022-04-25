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
function mark_area(Defind_Map_Axis,Defind_handle,data,spectrum,lower_counter,upper_counter,y_lim_style)
delete(Defind_handle);
hold(Defind_Map_Axis,"on")
%draws range in the Graph
if lower_counter.Value == -inf
    x_low = min(data,[],'all');
else
    x_low = lower_counter.Value;
end

if upper_counter.Value == inf
    x_up = max(data,[],'all');
else
    x_up = upper_counter.Value;
end

x = [x_low, x_up];

if y_lim_style
    y = get(Defind_Map_Axis,'ylim');
else
    y = [min(spectrum),max(spectrum)];
end

Defind_handle = area(Defind_Map_Axis,x,[y(2),y(2)],'FaceColor','r','FaceAlpha',.3,'EdgeAlpha',.3);
hold(Defind_Map_Axis,"off")
end