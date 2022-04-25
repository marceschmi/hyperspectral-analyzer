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
function [Defind_Map_Axis,data,c] = Display_Gradient(Defind_Map_Axis,switch_state,Wavelenght,Position,PL_Intensity,color_steps,map_style,line_style,plot_type,offset_spinner)
if isempty(Wavelenght)
    colorbar(Defind_Map_Axis,'off');
    PL_Intensity = sum(PL_Intensity,2);
    [x_min,x_max] = bounds(Position,'all');
    [y_min,y_max] = bounds(PL_Intensity,'all');
    plot(Defind_Map_Axis,Position,PL_Intensity,line_style);
    xlim(Defind_Map_Axis,[x_min x_max]);
    ylim(Defind_Map_Axis,[y_min y_max]);
    ylabel(Defind_Map_Axis, 'counts [counts/s]');
    xlabel(Defind_Map_Axis, 'Position [mm]');
    title(Defind_Map_Axis, 'summed intensity over wavelength range');
    c = [];
else
    switch plot_type
        case 'color'
            if offset_spinner ~= 0
                offset_spinner.Enable = 'off';
            end
            [x_min,x_max] = bounds(Wavelenght,'all');
            [y_min,y_max] = bounds(Position,'all');
            contourf(Defind_Map_Axis,Wavelenght,Position,PL_Intensity,color_steps,'lineStyle','None',...
                'facecolor','flat')
            %changes the colormap wie the number of colors in the ()
            colors = colormap_styles.compute_colarmap(map_style,color_steps);
            colormap(Defind_Map_Axis,colors);
            c = colorbar(Defind_Map_Axis);
            c.Label.String = 'Intensity (Counts/s)';
            set(Defind_Map_Axis,'colorscale', switch_state);
            xlim(Defind_Map_Axis,[x_min x_max]);
            ylim(Defind_Map_Axis,[y_min y_max]);
            xlabel(Defind_Map_Axis, 'Wavelength [nm]');
            ylabel(Defind_Map_Axis, 'Position [mm]');
            title(Defind_Map_Axis, 'Gradient spectrum');
        case 'waterfall'
            if offset_spinner == 0
                off_set = 0;
            else
                offset_spinner.Enable = 'on';
                off_set = offset_spinner.Value;
            end
            [Defind_Map_Axis,c] = Display_waterfall(Defind_Map_Axis,Wavelenght,PL_Intensity,off_set,map_style);
            number_of_graphs = numel(Position);
            formatSpec = '%.1f';
            if number_of_graphs >= 5
                if rem(number_of_graphs, 2) == 0
                    c.Ticks = [0, 1/number_of_graphs*floor(number_of_graphs/4),...
                        1/number_of_graphs*floor(number_of_graphs/2),...
                        1/number_of_graphs*floor(3*number_of_graphs/4),1];
                    c.TickLabels = {num2str(Position(1),formatSpec),num2str(Position(floor(number_of_graphs/4)),formatSpec),...
                        num2str(Position(floor(number_of_graphs/2)),formatSpec), num2str(Position(floor(3*number_of_graphs/4)),formatSpec),...
                        num2str(Position(number_of_graphs),formatSpec)};
                else
                    c.Ticks = [0, 1/number_of_graphs*ceil(number_of_graphs/4),...
                        1/number_of_graphs*ceil(number_of_graphs/2),...
                        1/number_of_graphs*ceil(3*number_of_graphs/4),1];
                    c.TickLabels = {num2str(Position(1),formatSpec),num2str(Position(ceil(number_of_graphs/4)),formatSpec),...
                        num2str(Position(ceil(number_of_graphs/2)),formatSpec), num2str(Position(ceil(3*number_of_graphs/4)),formatSpec),...
                        num2str(Position(number_of_graphs),formatSpec)};
                end
            else
                c.Ticks = [0, 1];
                c.TickLabels = {num2str(Position(1),formatSpec),num2str(Position(number_of_graphs),formatSpec)};
            end
            c.Label.String = 'Position [mm]';
            xlabel(Defind_Map_Axis, 'Wavelength [nm]');
            ylabel(Defind_Map_Axis, 'counts [counts/s]');
            title(Defind_Map_Axis, 'Gradient spectrum');
    end
end
data = PL_Intensity;
end