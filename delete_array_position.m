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
function new_array = delete_array_position(old_array,delete_positions)
%delets positions from the array
%delete_positions can be an vector of positions
dimensions = size(old_array);
nd = numel(dimensions);
n = numel(delete_positions);

if nd == 5
    new_array = nan(dimensions(1)-n,dimensions(2),dimensions(3),dimensions(4),dimensions(5));
    
    k = 0;
    for fit = 1 : dimensions(1)
        if ~ismember(fit, delete_positions)
            k = k+1;
            for t = 1 : dimensions(2)
                for p = 1 : dimensions(3)
                    for y = 1 : dimensions(4)
                        for x = 1 : dimensions(5)
                            new_array(k,t,p,y,x) = old_array(fit,t,p,y,x);
                        end
                    end
                end
            end
        end
    end
elseif nd == 6
    new_array = nan(dimensions(1)-n,dimensions(2),dimensions(3),dimensions(4),dimensions(5),dimensions(6));
    
    k = 0;
    for fit = 1 : dimensions(1)
        if ~ismember(fit, delete_positions)
            k = k+1;
            for t = 1 : dimensions(2)
                for p = 1 : dimensions(3)
                    for y = 1 : dimensions(4)
                        for x = 1 : dimensions(5)
                            for i = 1 : dimensions(6)
                                new_array(k,t,p,y,x,i) = old_array(fit,t,p,y,x,i);
                            end
                        end
                    end
                end
            end
        end
    end
end
new_array(new_array == 0) = nan;
end