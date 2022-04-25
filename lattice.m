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
classdef lattice
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods(Static)
        function a = constant(material,T)
            %vurgaftman et. al. 2001 in nm
            a = (material.a_rt+material.a_factor*(T-300))*10^(-10);
        end

        function a = composition(a_a,a_b,x)
            a = (1-x)*a_b+x*a_a;
        end
        
        function e = missmatch(a_s,a_l)
            %a_s is the material on which the new layer is grown
            %a_l ist the new layer
            e = (a_s-a_l)/a_s;
        end
        
        function ML = calculate_ML(material,x_matrix,T_growth)
            %gets the ML thickness for a defined composition
            %calculate lsttice constant
            constants = global_constants;
            a_gaas = lattice.constant(materials.gaas,T_growth+constants.T_0);
            a_alas = lattice.constant(materials.alas,T_growth+constants.T_0);
            a_inas = lattice.constant(materials.inas,T_growth+constants.T_0);
            
            if isempty(x_matrix)
                switch material
                    case 'GaAs'
                        ML = a_gaas/2;
                    case 'AlAs'
                        ML = a_alas/2;
                    case 'InAs'
                        ML = a_inas/2;
                end
            else
                switch material
                    case 'AlGaAs'
                        ML = (a_alas*x_matrix + a_gaas*(1-x_matrix))/2;
                    case 'InGaAs'
                        ML = (a_inas*x_matrix + a_gaas*(1-x_matrix))/2;
                end
            end
        end
    end
end