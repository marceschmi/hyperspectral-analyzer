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
classdef global_constants
    %global constants from CODATA 2018
    
    properties
        c = 299792458; %m/s (exact)
        h=[];
        h_bar = [];
        e = 1.602176634e-19; %C (exact)
        m_e =  9.1093837015e-31; %kg uncertainty = 0.0000000028e-31 kg
        epsilon_0 =  8.8541878128e-12; %A*s/(V*m) uncertainty = 1.5e-10 A*s/(V*m)
        n_a = 6.02214076e-23 %mol^(-1) (exakt)
        k_b = 1.380649e-23 %J/K (exakt)
        mu_0 = 1.25663706212e-6 %N/A^2 uncertainty = 1.5e-10 N/A^2
        T_0 = 273.15%K to °C from https://eur-lex.europa.eu/legal-content/DE/TXT/?uri=CELEX:32019L1258
    end
    
    methods
        function obj = global_constants
            obj.h = 6.62607015e-34; %J s (exact)
            obj.h_bar = obj.h/(2*pi);
        end
    end
end

