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
function [spectrum,x_vector] = define_used_points(spectrum,x_vector,point_tretment,spectrometer_transition)
%define the used points
switch point_tretment
    case 'All_points'
    case 'even'
        wavelength_index = find_index(x_vector,spectrometer_transition,1);
        if mod(wavelength_index,2) == 1
            spectrum(wavelength_index+1:2:end) = [];
            x_vector(wavelength_index+1:2:end) = [];
        else
            spectrum(wavelength_index:2:end) = [];
            x_vector(wavelength_index:2:end) = [];
        end
    case 'odd'
        wavelength_index = find_index(x_vector,spectrometer_transition,1);
        if mod(wavelength_index,2) == 1
            spectrum(wavelength_index:2:end) = [];
            x_vector(wavelength_index:2:end) = [];
        else
            spectrum(wavelength_index+1:2:end) = [];
            x_vector(wavelength_index+1:2:end) = [];
        end
end
end