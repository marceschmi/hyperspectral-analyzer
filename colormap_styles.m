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
classdef colormap_styles
    %everything colormaps related
    
    properties
    end
    
    methods(Static)
        function colors = compute_colarmap(map_typ,color_steps)
            switch map_typ
                case 'parula'
                    colors = parula(color_steps);
                case 'jet'
                    colors = jet(color_steps);
                case 'hsv'
                    colors = hsv(color_steps);
                case 'hot'
                    colors = hot(color_steps);
                case 'cool'
                    colors = cool(color_steps);
                case 'spring'
                    colors = spring(color_steps);
                case 'summer'
                    colors = summer(color_steps);
                case 'autumn'
                    colors = autumn(color_steps);
                case 'winter'
                    colors = winter(color_steps);
                case 'gray'
                    colors = gray(color_steps);
                case 'bone'
                    colors = bone(color_steps);
                case 'copper'
                    colors = copper(color_steps);
                case 'pink'
                    colors = pink(color_steps);
                case 'lines'
                    colors = lines(color_steps);
                case 'colorcube'
                    colors = colorcube(color_steps);
                case 'prism'
                    colors = prism(color_steps);
                case 'black'
                    colors = [0 0 0];
                case 'wbry'
                    colors = colormap_styles.wbry_colormap(color_steps);
            end
        end
        
        function colormap = wbry_colormap(steps)
            %color transition from w to b to r to y
            %w = [1 1 1];
            %b = [0 0 0];
            %r = [1 0 0];
            %y = [1 1 0];
            
            %declare piecewise-defined function sections
            mod3 = mod(steps,3);
            divider = floor(steps/3);
            
            %predefine size of the colormap
            colormap = nan(steps,3);
            
            %define the sections
            for i = 1 : divider
                colormap(i,:) = [1-i/divider 1-i/divider 1-i/divider];
            end
            for i = 1 : divider
                colormap(divider+i,:) = [i/divider 0 0];
            end
            for i = 1 : divider + mod3
                colormap(divider*2+i,:) = [1 i/(divider + mod3) 0];
            end
        end
    end
end

