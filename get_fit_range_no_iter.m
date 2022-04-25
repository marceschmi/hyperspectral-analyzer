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
function [Index_of_Lower_x,Index_of_Upper_x] = get_fit_range_no_iter(x,Peak_x,number_of_points_left,number_of_points_right)
%get fit range (x has to be the displayed spectral range)
[~, Index_x_min] = min(abs(x-min(Peak_x)));
Index_of_Lower_x = Index_x_min - number_of_points_left;
[~, Index_x_max] = min(abs(x-max(Peak_x)));
Index_of_Upper_x = Index_x_max + number_of_points_right;

if numel(x) < Index_of_Upper_x
    %Index_of_Upper_x = numel(x);
    correction = numel(x)-Index_x_max-number_of_points_right;
    Index_of_Upper_x = Index_of_Upper_x + correction;
end

if Index_of_Lower_x < 1
    %Index_of_Lower_x = 1;
    correction = 1 - Index_x_min + number_of_points_left;
    Index_of_Lower_x = Index_of_Lower_x + correction;
end
end