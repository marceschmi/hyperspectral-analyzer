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
function cleaned_map = clean_up_map(pre_processed_data_map,k_min,k_max)
%defines the size of the data vor later reshape
size_data = size(pre_processed_data_map);

%converts the data in a vector
straightened_data = pre_processed_data_map(:);

%finds the in index of the k smalest values an sets them to NaN
[~,I] = mink(straightened_data,k_min);
straightened_data(I) = NaN;

%finds the in index of the k largest values an sets them to NaN
[~,I] = maxk(straightened_data,k_max);
straightened_data(I) = NaN;

%reshapes the data back to matrix
cleaned_map = reshape(straightened_data,size_data);
end