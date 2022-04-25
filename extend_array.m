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
function new_array = extend_array(old_array,n_add_layer,add_position)
%predefine empty array for the peaks
dimensions = size(old_array);
n = numel(dimensions);

if n == 5
    a = 0;
    b = 0;
    c = 0;
    d = 0;
    e = 0;
    
    if add_position == 1
        a = n_add_layer;
    elseif add_position == 2
        b = n_add_layer;
    elseif add_position == 3
        c = n_add_layer;
    elseif add_position == 4
        d = n_add_layer;
    elseif add_position == 5
        e = n_add_layer;
    end
    
    new_array = nan(dimensions(1)+a,dimensions(2)+b,dimensions(3)+c,dimensions(4)+d,dimensions(5)+e);
    
    for fit = 1 : dimensions(1)
        for t = 1 : dimensions(2)
            for p = 1 : dimensions(3)
                for y = 1 : dimensions(4)
                    for x = 1 : dimensions(5)
                        new_array(fit,t,p,y,x) = old_array(fit,t,p,y,x);
                    end
                end
            end
        end
    end
elseif n == 6
    a = 0;
    b = 0;
    c = 0;
    d = 0;
    e = 0;
    f = 0;
    
    if add_position == 1
        a = n_add_layer;
    elseif add_position == 2
        b = n_add_layer;
    elseif add_position == 3
        c = n_add_layer;
    elseif add_position == 4
        d = n_add_layer;
    elseif add_position == 5
        e = n_add_layer;
    elseif add_position == 6
        f = n_add_layer;
    end
    
    new_array = nan(dimensions(1)+a,dimensions(2)+b,dimensions(3)+c,dimensions(4)+d,dimensions(5)+e,dimensions(6)+f);
    
    for fit = 1 : dimensions(1)
        for t = 1 : dimensions(2)
            for p = 1 : dimensions(3)
                for y = 1 : dimensions(4)
                    for x = 1 : dimensions(5)
                        for i = 1 : dimensions(6)
                            new_array(fit,t,p,y,x,i) = old_array(fit,t,p,y,x,i);
                        end
                    end
                end
            end
        end
    end
end
new_array(new_array==0) = nan;
end