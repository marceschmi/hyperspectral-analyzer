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
function thickness = grow_stop_layer(rotation_dir,theta,v,center,sf_growth_rate,growth_rate_correction_factor,time)
R = rotation.matrix(rotation_dir,theta);
vr = rotation.vector(R,v,center);
%compute local growthrates
thickness = sf_growth_rate(vr')*growth_rate_correction_factor*time;
end
