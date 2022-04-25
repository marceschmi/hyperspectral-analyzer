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
function [mesh_size_v,v,size_v] = create_v(X_vector,Y_vector,X_Steps,Y_Steps)
%define the step size of the vector to be rotated
[Sx,Lx] = bounds(X_vector);
[Sy,Ly] = bounds(Y_vector);
Xq = Sx : X_Steps : Lx;
Yq = Sy : Y_Steps : Ly;
[X,Y] = meshgrid(Xq,Yq);
mesh_size_v = size(X);

%prelocat the new vectors
v = zeros(2,mesh_size_v(1)*mesh_size_v(2));

%sort the mash of points in a vector for easymatrix
%multiplication operations
j = 0;
for i = 1 : mesh_size_v(1)
    for ii = 1 : mesh_size_v(2)
        j = j+1;
        v(1,j) = X(i,ii);
        v(2,j) = Y(i,ii);
    end
end
size_v = size(v);
end