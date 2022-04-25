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
function [spectrum,x_vector,Defind_Spectrum_Axis,c] = Display_Spectrum(Defind_Spectrum_Axis,x_vector,data_map,...
    temperature_index,power_index,y,x,x_min,x_max,point_tretment,method,window,degree,...
    spectrometer_transition,sweep_typ,stady_ramge)
%gets the spectrum from the data array
spectrum = get_spectrum_from_data_map(data_map,temperature_index,power_index,y,x);

%change the used Points
switch point_tretment
    case {'even','odd'}
        [spectrum,x_vector] = define_used_points(spectrum,x_vector,point_tretment,spectrometer_transition);
end

%reduse the points to the specified range if the rang is smaler
if (x_min ~= x_vector(1)) || (x_max ~= x_vector(end))
    [spectrum,x_vector,~,~] = sweep_data(spectrum,x_vector,x_min,x_max,sweep_typ);
end

%smoothing the data if necessary
if window >1
    spectrum = smooth_data(spectrum,method,window,degree);
end

%sets the error bars to empty because they are not measured
y_err_neg = [];
y_err_pos = [];

%displayes the processed spectrum
[~,c] = specify_display_style_spectrum(Defind_Spectrum_Axis,x_vector,spectrum,y_err_neg,y_err_pos,0,'-',stady_ramge);
end