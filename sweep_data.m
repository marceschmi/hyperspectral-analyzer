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
function [spectrum,x_vector,Index_min,Index_max] = sweep_data(spectrum,x,x_min,x_max,sweep_typ)
%declare factor for indexing
switch sweep_typ
    case {'PL_Map','all','energy'}
        k = 1;
    case {'forward','backward'}
        k = 2;
end

%find the index of the beginning and the end
Index_min = find_index(x,x_min,k);
Index_max = find_index(x,x_max,k);

%change the range of x and y to the range
switch sweep_typ
    case {'PL_Map','all','energy'}
        x_vector = x(Index_min:Index_max);
        spectrum = spectrum(Index_min:Index_max);
    case 'forward'
        x_vector = x(Index_min(1):Index_max(1));
        spectrum = spectrum(Index_min(1):Index_max(1));
    case 'backward'
        x_vector = x(Index_max(2):Index_min(2));
        [x_vector,I] = sort(x_vector);
        spectrum = spectrum(Index_max(2):Index_min(2));
        spectrum = spectrum(I);
end
end