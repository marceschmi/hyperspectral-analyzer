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
function pre_processed_data_map = update_fit_map(PLMap_Data,power,temperature,displayed_fit_parameter,displayed_peak)
%get the fit map
pre_processed_data_map = get_spectrum_from_fit_map(PLMap_Data,power,temperature,displayed_fit_parameter,displayed_peak);

if displayed_fit_parameter == 2
    if app.display_peak_as_energyCheckBox.Value
        app.k_minSpinner.Value = 0;
        app.k_maxSpinner.Value = 0;
        pre_processed_data_map = convert_energy_wavelength(pre_processed_data_map);
    end
end

%converts k_min smalest and k_max largest values to NaN
if app.k_minSpinner.Value >0 || app.k_maxSpinner.Value >0
    pre_processed_data_map = clean_up_map(pre_processed_data_map,app.k_minSpinner.Value,app.k_maxSpinner.Value);
end

%get info for map
label{1} = 'Map';
label{2} = 'X [mm]';
label{3} = 'Y [mm]';

%gets the correct c label
if app.displayed_fit_parameter == 2
    label{4} = 'Wavelength (nm)';
elseif app.displayed_fit_parameter == 3
    label{4} = 'FWHM (eV)';
else
    label{4} = 'Intensity (Counts/s)';
end

[pre_processed_data_map,last_fit_map,c_fit_map] = Display_Fit_Map(PLMap_Data,area_dim,pre_processed_data_map,...
    Defind_Map_Axis,MapColorsteps,map_typ_fit_data,label,MapMinCount,MapMaxCount,ContourCheck,contour_lines,contourtext,...
    locktoareaCheck);

%updates the histogram
update_histogram(Defind_Map_Axis,pre_processed_data_map,bins,show_statistcs);
end
