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
function [pre_processed_data_map,t,p] = get_fit_data(PLMap_Data,Fit_Data_Map,rmse_Map,p_state,t_state,displayed_fit,peak,typ,n_fitparameter)
%define indeces of power and tamperature
[~, p] = min(abs(PLMap_Data.Power-p_state));
[~, t] = min(abs(PLMap_Data.Temperature_index-t_state));

pre_processed_data_map = nan(numel(PLMap_Data.Y_vector),numel(PLMap_Data.X_vector));

if typ == 5
    for y = 1 : numel(PLMap_Data.Y_vector)
        for x = 1 : numel(PLMap_Data.X_vector)
            if ~isnan(rmse_Map(displayed_fit,t,p,y,x))
                pre_processed_data_map(y,x) = rmse_Map(displayed_fit,t,p,y,x);
            end
        end
    end
else
    for y = 1 : numel(PLMap_Data.Y_vector)
        for x = 1 : numel(PLMap_Data.X_vector)
            coeffvals(:) = Fit_Data_Map(displayed_fit,t,p,y,x,:);
            if ~all(isnan(coeffvals),'all')
                size_coeff = size(coeffvals);
                if peak <= size_coeff(2)/n_fitparameter
                    pre_processed_data_map(y,x) = coeffvals(typ+(peak-1)*n_fitparameter);
                end
            end
        end
    end
end
end