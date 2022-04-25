%--------------------------------------------------------------------------------------------------------------------
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
%--------------------------------------------------------------------------------------------------------------------
classdef band_gap
    %computation of bandgaps
    
    properties
    end
    
    methods(Static)
        function Eg = peassler(material,T)
            %by peassler 1999
            %material is an object with all the material properties
            %T in K
            switch material.name
                case 'gaas'
                E0 = material.E0_gamma;
                case 'alas'
                E0 = material.E0_X;
                case 'inas'
                E0 = material.E0_gamma;
            end
            Eg = E0-((material.a.*material.theta./2)).*(((1+(2.*T/material.theta).^material.p).^(1./material.p))-1);
        end
        
        function Eg = varshnie(material,T)
            %by vurgaftman et. al. 2001
            %material is an object with all the material properties
            %T in K
            switch material.name
                case 'gaas'
                    E0 = material.E0_gamma;
                    alpha = material.alpha_gamma;
                    beta = material.beta_gamma;
                case 'alas'
                    E0 = material.E0_X;
                    alpha = material.alpha_X;
                    beta = material.beta_X;
                case 'inas'
                    E0 = material.E0_gamma;
                    alpha = material.alpha_gamma;
                    beta = material.beta_gamma;
            end
            
            %Varshni 1967
            Eg = E0-((alpha.*T.^2)./(T+beta));
        end
        
        function Eg = composition(Eg_a,Eg_b,x,material)
            %by vurgaftman et. al. 2001
            %Eg_b is the material for with the x composition
            switch material.name
                case 'alas'
                C = -0.127+1.310*x;
                case 'inas'
                C = 0.477;
            end
            
            Eg = (1-x)*Eg_b+x*Eg_a-x*(1-x)*C;
        end
        
        function Eg = composition_varshnie(x,T,material_1,material_2)
            %by vurgaftman et. al. 2001
            Eg_a = band_gap.varshnie(material_1,T);
            Eg_b = band_gap.varshnie(material_2,T);
            Eg = band_gap.composition(Eg_a,Eg_b,x,material_1);
        end
        
        function Eg = composition_peassler(x,T,material_1,material_2)
            %by vurgaftman et. al. 2001
            Eg_a = band_gap.peassler(material_1,T);
            Eg_b = band_gap.peassler(material_2,T);
            Eg = band_gap.composition(Eg_a,Eg_b,x,material_1);
        end
    end
end

