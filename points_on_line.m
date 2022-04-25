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
function [Position,x_Position,y_Position,y_label_text] = points_on_line(start_position,...
    x_vector,y_vector,mode,steps_width,fixed_spinner,startSpinner,endSpinner,jump_steps,direction,...
    line_distance)
% start_position is a matrix with (x1 y1)
%                                 (x2 y2)
Position = [];

%comput m an b
m = (start_position(2,2) - start_position(1,2)) / (start_position(2,1) - start_position(1,1));
b = start_position(1,2) - m * start_position(1,1);

%creats the vectors of all coordinates
[x,y,~] = matrix_2d_to_vector(x_vector,y_vector,zeros(length(y_vector),length(x_vector)));

switch mode
    case 'exactly'
        %points on the line
        y_line = x * m + b;
        
        %clears all points not on the line
        x(~(y == y_line)) = [];
        y(~(y == y_line)) = [];
        TF = sqrt((x - 37.5).^2+(y - 37).^2)>=39;
        x(TF) = [];
        y(TF) = [];
        % error if there is no match
        if isempty(x)
            f = errordlg('There was no point touched by the line. Try close_to for better results.','No point error');
            return
        end
    case 'close_to'
        all_points = [x,y];
        x_line = x_vector(1) : steps_width : x_vector(end);
        y_line = x_line * m + b;
        
        line_points = [x_line',y_line'];
        line_points(sqrt((x_line - 37.5).^2+(y_line - 37).^2)>=39,:) = [];
        
        %clears all points not near the line
        [Idx,~] = knnsearch(all_points,line_points);
        x = nan(numel(Idx),1);
        y = nan(numel(Idx),1);
        for i = 1:numel(Idx)
            x(i) = all_points(Idx(i),1);
            y(i) = all_points(Idx(i),2);
        end
        if isempty(x)
            f = errordlg('There was no point touched by the line. Try smaler steps width for better results.','No point error');
            return
        end
end

% sorts the vaectors
[x,I] = sort(x);
y = y(I);

if fixed_spinner
    [~, start_index_rang] = min(abs(x-startSpinner.Value));
    [~, end_index_rang] = min(abs(x-endSpinner.Value));
else
    start_index_rang = define_Spinner(startSpinner,x,'low');
    end_index_rang = define_Spinner(endSpinner,x,'upper');
end

j = 0;
for i = start_index_rang : jump_steps : end_index_rang
    j = j+1;
    x_Position(j,1) = x(i);
    y_Position(j,1) = y(i);
end

switch direction
    case 'right'
        x_Position = flipud(x_Position);
        y_Position = flipud(y_Position);
end

if line_distance
    y_label_text = 'position [mm]';
    Position = sqrt((x_Position-x_Position(1)).^2+(y_Position-y_Position(1)).^2);
else
    y_label_text = 'x position [mm]';
    Position = x_Position;
end
end