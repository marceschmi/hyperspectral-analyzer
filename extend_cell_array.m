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
function new_array = extend_cell_array(old_array,number_of_different_fits)
%predefine empty array for the peaks
dimensions = size(old_array);

tf = isa(old_array,'cell');
if tf
    new_array = cell(dimensions(1)+number_of_different_fits,dimensions(2),dimensions(3),dimensions(4),dimensions(5));
else
    new_array = nan(dimensions(1)+number_of_different_fits,dimensions(2),dimensions(3),dimensions(4),dimensions(5));
end

for fit = 1 : dimensions(1)
    for t = 1 : dimensions(2)
        for p = 1 : dimensions(3)
            for y = 1 : dimensions(4)
                for x = 1 : dimensions(5)
                    if tf
                        new_array{fit,t,p,y,x} = old_array{fit,t,p,y,x};
                    else
                        new_array(fit,t,p,y,x) = old_array(fit,t,p,y,x);
                    end
                end
            end
        end
    end
end
end