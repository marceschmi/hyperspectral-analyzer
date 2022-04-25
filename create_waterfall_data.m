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
function [spectra_x,spectra_y] = create_waterfall_data(data,parameter,t,p,x,y,x_min,x_max,sweep_typ)
%declare changing vector
switch parameter
    case 't'
        vector = data.Temperature_index;
    case 'p'
        vector = data.Power;
    case 'y'
        vector = data.Y_vector;
    case 'x'
        vector = data.X_vector;
end
n = numel(vector);

%find the index of the beginning and the end
Index_min = find_index(data.Wavelength,x_min,2);
Index_max = find_index(data.Wavelength,x_max,2);

%pre locat spectra
size_data_array = size(data.data_array);
spectra_y = nan(n,size_data_array(5));

%populate the data array
for i = 1 : n
    switch parameter
        case 't'
            t = i;
        case 'p'
            p = i;
        case 'y'
            y = i;
        case 'x'
            x = i;
    end
    spectra_y(i,:) = data.data_array(t,p,y,x,:);
end


%change the range of x and y to the range
switch sweep_typ
    case 'bidirectional'
        spectra_x = data.Wavelength([Index_min(1):Index_max(1),Index_min(2):Index_max(2)]);
        spectra_y = spectra_y(:,[Index_min(1):Index_max(1),Index_min(2):Index_max(2)]);
    case {'forward','all'}
        spectra_x = data.Wavelength(Index_min(1):Index_max(1));
        spectra_y = spectra_y(:,Index_min(1):Index_max(1));
    case 'backward'
        spectra_x = flip(data.Wavelength(Index_max(2):Index_min(2)));
        spectra_y = flip(spectra_y(:,Index_max(2):Index_min(2)));
end
end