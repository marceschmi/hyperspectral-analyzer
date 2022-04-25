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
classdef select_data
    %Functions to select Data Points
    
    methods(Static)
        function [roi, x, y] = selectDataLine(ax,x_steps,y_steps,snapped)
            %finds the position clicked on and snaps to point
            roi = drawline(ax);
            x = roi.Position(:,1);
            y = roi.Position(:,2);
            
            if snapped
                for i = 1 : numel(x)
                    x(i,1) = x(i,1) - mod(x(i,1),x_steps);
                    roi.Position(i,1) = x(i,1);
                    
                    y(i,1) = y(i,1) - mod(y(i,1),y_steps);
                    roi.Position(i,2) = y(i,1);
                end
            end
        end
        
        function [roi, x, y] = selectDataPoint(ax,x_steps,y_steps,snapped)
            %finds the position clicked on and snaps to point
            roi = drawpoint(ax);
            x = roi.Position(1);
            y = roi.Position(2);
            if snapped
                x = x - mod(x,x_steps);
                roi.Position(1) = x;
                
                y = y - mod(y,y_steps);
                roi.Position(2) = y;
            end
        end
        
        function [roi, x, y] = selectDataPoints(ax,x_steps,y_steps,snapped)
            %finds the position clicked on and snaps to point
            roi = drawpolyline(ax);
            x = roi.Position(:,1);
            y = roi.Position(:,2);
            if snapped
                for i = 1 : numel(x)
                    x(i,1) = x(i,1) - mod(x(i,1),x_steps);
                    roi.Position(i,1) = x(i,1);
                    
                    y(i,1) = y(i,1) - mod(y(i,1),y_steps);
                    roi.Position(i,2) = y(i,1);
                end
            end
        end
        
        function [roi, x, y, dx, dy] = selectDataRegtangle(ax,x_steps,y_steps,snapped)
            %finds the position clicked on and snaps to point
            roi = drawrectangle(ax);
            x = roi.Position(1);
            y = roi.Position(2);
            dx = roi.Position(3);
            dy = roi.Position(4);
            
            if snapped
                x = floor(x) + floor( (x-floor(x))/x_steps) * x_steps;
                roi.Position(1) = x;
                
                y = floor(y) + floor( (y-floor(y))/y_steps) * y_steps;
                roi.Position(2) = y;
                
                dx = floor(dx) + floor( (dx-floor(dx))/x_steps) * x_steps;
                roi.Position(3) = dx;
                
                dy = floor(dy) + floor( (dy-floor(dy))/y_steps) * y_steps;
                roi.Position(4) = dy;
            end
        end
        
        function [roi, x, y] = selectPointCrosshair(ax,x_steps,y_steps)
            %finds the position clicked on and snaps to point
            roi = drawcrosshair(ax,'LineWidth',1,'Color','g');
            x = roi.Position(1);
            y = roi.Position(2);
            
            %snaps to grid
            x = x - mod(x,x_steps);
            roi.Position(1) = x;
            
            y = y - mod(y,y_steps);
            roi.Position(2) = y;
        end
    end
end

