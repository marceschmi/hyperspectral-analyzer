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
classdef critical_coverage

    properties
    end
    
    methods(Static)
        function hc = critical_coverage_total(x)
            %Ch. Heyn et. al. 2007
            %for InGaAs on GaAs at T<= 420 °C
            %Wachstumsrate F_InAs = 0.1 ML/s
            constants = global_constants;
            c = 0.024; %in (s/eV)
            F = 0.1/x; %in (ML/s)
            p = 1/3;
            E0 = 3; %in (eV)
            EN = 0.7; %in (eV)
            gamma = 0.0029; %in (eV/K)
            T = 420 + constants.T_0; %in (°C)
            hWL = 0.8; %in (ML)
            
            h_isl = critical_coverage.critical_coverage_island(c,F,p,E0,gamma,T,x,EN);
            hc = h_isl + hWL;
        end
        
        function h_isl = critical_coverage_island(c,F,p,E0,gamma,T,x,EN)
            %Ch. Heyn et. al. 2007
            constants = global_constants;
            h_isl = c*F^(p)*((E0-gamma*T)/(x^(2)))*exp(p*EN/((constants.k_b/constants.e)*T));
        end
    end
end