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
function pre_processed_data_map = get_spectrum_from_fit_map(PLMap_Data,Fit_Data_Map,power,temperature,displayed_fit_parameter,displayed_peak)
%define indeces of power and tamperature
[~, p] = min(abs(PLMap_Data.Power-power));
[~, t] = min(abs(PLMap_Data.Temperature_index-temperature));

pre_processed_data_map(:,:) = Fit_Data_Map(t,p,:,:,displayed_fit_parameter,displayed_peak);
end

