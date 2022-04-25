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
function sf = surface_fit_3d_data(x_vector,y_vector,z_matrix)
%surface fits 3d data with a poly55 fit
%surfce fit the sim data

% create vectors
j = 0;
for ix = 1 : numel(x_vector)
    for iy = 1 : numel(y_vector)
        j = j+1;
        X(j,1) = x_vector(ix);
        Y(j,1) = y_vector(iy);
        Z(j,1) = z_matrix(iy,ix);
    end
end

%fits the data
sf = fit([X, Y],Z,'poly55');
end

