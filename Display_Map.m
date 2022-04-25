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
function [Defind_Map_Axis,c] = Display_Map(Defind_Map_Axis,X_Position,Y_Position,map_data,color_steps,map_typ,...
    label,lower_count_limit,upper_count_limit,contour_state,contour_lines,contour_text,lock_to_area_check)
cla(Defind_Map_Axis)
%process data in the range of the count limets
if (~isinf(lower_count_limit)) && (~isinf(upper_count_limit))
    map_data(map_data>upper_count_limit) = upper_count_limit;
    map_data(map_data<lower_count_limit) = lower_count_limit;
elseif ~isinf(upper_count_limit)
    map_data(map_data>upper_count_limit) = upper_count_limit;
elseif ~isinf(lower_count_limit)
    map_data(map_data<lower_count_limit) = lower_count_limit;
end

hold(Defind_Map_Axis,'on');
%create map
p = pcolor(Defind_Map_Axis,X_Position,Y_Position,map_data);
p.EdgeColor = 'none';

if contour_state
    %display contourlines
    [M,c_obj] = contour(Defind_Map_Axis,X_Position,Y_Position,map_data,contour_lines,'k-','ShowText',contour_text);
    c_obj.LabelSpacing = 400;
end

if lock_to_area_check
else
    % Draw wafer edge
    theta = 0:0.01:2*pi;
    r_wafer = 76.2/2;
    x_wafer = r_wafer-(1.5/2) +(r_wafer .*cos(theta));
    y_wafer = r_wafer-(3.5/2) +(r_wafer .*sin(theta));
    xy_wafer(1,:) = x_wafer(1,(y_wafer(1,:)>=0 & x_wafer(1,:)>=0));
    xy_wafer(2,:) = y_wafer(1,(y_wafer(1,:)>=0 & x_wafer(1,:)>=0));
    
    %draws the waferadges in the Graph
    line(Defind_Map_Axis,xy_wafer(1,:),xy_wafer(2,:),'color','r', 'LineWidth', 1);
end

%changes the colormap wie the number of colors in the ()
colors = colormap_styles.compute_colarmap(map_typ,color_steps);
colormap(Defind_Map_Axis,colors);
c = colorbar(Defind_Map_Axis);
caxis(Defind_Map_Axis,[lower_count_limit,upper_count_limit]);
c.Label.String = label{4};

%sets the range of the plot always to the max dimantions of the wafer so one can see the map in the right size ratio
if lock_to_area_check == 1
    axis(Defind_Map_Axis,[min(X_Position) max(X_Position) min(Y_Position) max(Y_Position)]);
else
    axis(Defind_Map_Axis,[0 76.2-(1.5/2) 0 76.2-(3.5/2)]);
end
axis(Defind_Map_Axis,'square');

% let the plot start at 0/0 - otherwise the y-axis would diracting in negativ diration
set(Defind_Map_Axis,'Ydir','normal');
hold(Defind_Map_Axis,'off');

%change the shape
title(Defind_Map_Axis, label{1});
xlabel(Defind_Map_Axis, label{2});
ylabel(Defind_Map_Axis, label{3});
end

