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
classdef critical_thickness
    %computation of critical thickness before dislocations
    properties
    end
    
    methods(Static)
        function hc = critical_thickness_ingaas_on_gaas(x,T,hc_start,n_iter)
            %I. J. Fritz et. al. 1985
            gaas = materials.gaas;
            inas = materials.inas;
            C11 = critical_thickness.linear_combination(inas.C11,gaas.C11,x);
            C12 = critical_thickness.linear_combination(inas.C12,gaas.C12,x);
            v = critical_thickness.poisson_ratio(C12,C11);
            a = critical_thickness.linear_combination(lattice.constant(materials.inas,T),lattice.constant(materials.gaas,T),x);
            b = critical_thickness.burgers_vector(lattice.constant(materials.gaas,T));
            f = lattice.missmatch(lattice.constant(materials.gaas,T),a);
            hc = hc_start;
            for i = 1 : n_iter
                hc = critical_thickness.h_critical(b,v,-f,hc);
            end
        end
        
        function hc = h_critical(b,v,f,hc_start)
            %I. J. Fritz et. al. 1985
            hc = b*(1-v/4)/((1+v)*2*pi*f)*(log(hc_start/b)+1);
        end
        
        function b = burgers_vector(a)
            %I. J. Fritz et. al. 1985
            b = a/sqrt(2);
        end
        
        function v = poisson_ratio(C12,C11)
            %I. J. Fritz et. al. 1985
            v = C12/(C11+C12);
        end
        
        function C = linear_combination(A,B,x)
            C = A*x+B*(1-x);
        end
    end
end