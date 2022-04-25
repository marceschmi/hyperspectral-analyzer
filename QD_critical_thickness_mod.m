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
function ct_mod = QD_critical_thickness_mod(ct,delta_R,nue,R_0,d_PDL,R,mode)
%calculat the roughness modulatet critical thickness for QD formation
switch mode
    case 'standard'
        ct_mod = ct*(1-R);
    case 'expand'
        ct_mod = ct*(1 - (delta_R/(nue-R_0))*sin(pi * d_PDL).^2);
end
end

