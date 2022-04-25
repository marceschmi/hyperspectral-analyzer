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
function d = thickness_composition_relation(t,growth_rate,x)
%calculates the thickness of a ternary layer in relation to a known shutter
%opening time t, growthrat, and an compositon x.
%t has to be a scalar
%growth_rate can be a matrix, vector or scalar
%x can ba a scalar or a matrix/vector of the same size as growth_rate
d = t.*growth_rate.*((x./(1-x))+1);
end

