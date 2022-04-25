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
function set_matrix = transfer_nan_between_arrayes(transfer_matrix,set_matrix)
%transfers the nan values from the transfer_matrix to the set_matrix
%both matrix need to have the same size

size_data = size(transfer_matrix);
v_transfer_matrix = transfer_matrix(:);
v_set_matrix = set_matrix(:);

TF = isnan(v_transfer_matrix);

v_set_matrix(TF) = nan;

set_matrix = reshape(v_set_matrix,size_data);
end

