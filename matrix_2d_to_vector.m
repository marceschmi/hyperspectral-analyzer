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
function [X,Y,Z] = matrix_2d_to_vector(x_vector,y_vector,z_matrix)
%converts a surface matrix with coordinates X and Y to a Vector
%in the form that each element of the matrix has its own index in the
%vector

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
end

