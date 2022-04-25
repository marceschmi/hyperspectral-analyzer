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
function thickness_metrix = creat_thicknass_matrix(v,X_vector,Y_vector,x_center,y_center,circle_size,thickness)
%prelocat data
thickness_metrix = nan(numel(Y_vector),numel(X_vector));

%convert thickness vector to matrix
for i = 1 :length(v)
    [~, index_x] = min(abs(X_vector-v(1,i)));
    [~, index_y] = min(abs(Y_vector-v(2,i)));
    if sqrt((x_center-v(1,i)).^2+(y_center-v(2,i)).^2)>=circle_size
        thickness_metrix(index_y,index_x) = 0;
    else
        thickness_metrix(index_y,index_x) = thickness(i);
    end
end
thickness_metrix(thickness_metrix==0) = nan;
end