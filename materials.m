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
classdef materials
    %definition of material paraeters
    
    properties
        name = [];
        E0_gamma = [];
        alpha_gamma = [];
        beta_gamma = [];
        E0_X = [];
        alpha_X = [];
        beta_X = [];
        E0_L = [];
        alpha_L = [];
        beta_L = [];
        a = [];
        theta = [];
        p = [];
        F = [];
        Ep = [];
        delta_so = [];
        gamma_1 = [];
        gamma_2 = [];
        epsilon_s = [];
        VBO = [];
    end
    
    methods(Static)
        function obj = gaas
            obj.name = 'gaas';
            obj.E0_gamma = 1.519; %in [eV] peassler 1999 and vurgaftman et. al. 2001
            obj.alpha_gamma = 0.0005405; %in [eV/K] vurgaftman et. al. 2001
            obj.beta_gamma = 204; %in [K] vurgaftman et. al. 2001
            obj.E0_X = 1.981; %in [eV] peassler 1999 and vurgaftman et. al. 2001
            obj.alpha_X = 0.00046; %in [eV/K] vurgaftman et. al. 2001
            obj.beta_X = 204; %in [K] vurgaftman et. al. 2001
            obj.E0_L = 1.815; %in [eV] peassler 1999 and vurgaftman et. al. 2001
            obj.alpha_L = 0.000605; %in [eV/K] vurgaftman et. al. 2001
            obj.beta_L = 204; %in [K] vurgaftman et. al. 2001
            obj.a = 0.000472;%in [eV/K] peassler 1999
            obj.theta = 230; %peassler 1999
            obj.p = 2.44; %peassler 1999
            obj.F = -1.94; %vurgaftman et. al. 2001
            obj.Ep = 28.8; %in [eV] by vurgaftman et. al. 2001
            obj.delta_so = 0.341; %in [eV]  by vurgaftman et. al. 2001
            obj.gamma_1 = 6.98; %vurgaftman et. al. 2001
            obj.gamma_2 = 2.06; %vurgaftman et. al. 2001
            obj.epsilon_s = 12.9; %ioffe.ru
            obj.VBO = -0.8; %vurgaftman et. al. 2001
            obj.C11= 1221; %in [GPa] vurgaftman et. al. 2001
            obj.C12 = 566; %in [GPa] %vurgaftman et. al. 2001
            obj.a_rt = 5.65325; %lattic constant in [Angstroem] %vurgaftman et. al. 2001
            obj.a_factor = 3.88*10^(-5); %lattice temperature corection [1/T] %vurgaftman et. al. 2001
        end
        
        function obj = alas
            obj.name = 'alas';
            obj.E0_gamma = 3.099; %in [eV] vurgaftman et. al. 2001
            obj.alpha_gamma = 0.000885; %in [eV/K] vurgaftman et. al. 2001
            obj.beta_gamma = 530; %in [K] vurgaftman et. al. 2001
            obj.E0_X = 2.24; %in [eV] vurgaftman et. al. 2001
            obj.alpha_X = 0.0007; %in [eV/K] vurgaftman et. al. 2001
            obj.beta_X = 530; %in [K] vurgaftman et. al. 2001
            obj.E0_L = 2.46; %in [eV] vurgaftman et. al. 2001
            obj.alpha_L = 0.000605; %in [eV/K] vurgaftman et. al. 2001
            obj.beta_L = 204; %in [K] vurgaftman et. al. 2001
            obj.a = 0.000362;%in [eV/K] peassler 1999
            obj.theta = 218; %peassler 1999
            obj.p = 2.32; %peassler 1999
            obj.F = -0.48; %vurgaftman et. al. 2001
            obj.Ep = 21.1; %in [eV] by vurgaftman et. al. 2001
            obj.delta_so = 0.28; %in [eV]  by vurgaftman et. al. 2001
            obj.gamma_1 = 3.76; %vurgaftman et. al. 2001
            obj.gamma_2 = 0.82; %vurgaftman et. al. 2001
            obj.epsilon_s = 10.06; %ioffe.ru
            obj.VBO = -1.33; %vurgaftman et. al. 2001
            obj.C11= 1250; %in [GPa] vurgaftman et. al. 2001
            obj.C12 = 534; %in [GPa] %vurgaftman et. al. 2001
            obj.a_rt = 5.6611; %lattic constant in [Angstroem] %vurgaftman et. al. 2001
            obj.a_factor = 2.9*10^(-5); %lattice temperature corection [1/T] %vurgaftman et. al. 2001
        end
        
        function obj = inas
            obj.name = 'inas';
            obj.E0_gamma = 0.417; %in [eV] vurgaftman et. al. 2001
            obj.alpha_gamma = 0.000276; %in [eV/K] vurgaftman et. al. 2001
            obj.beta_gamma = 93; %in [K] vurgaftman et. al. 2001
            obj.E0_X = 1.433; %in [eV] vurgaftman et. al. 2001
            obj.alpha_X = 0.000276; %in [eV/K] vurgaftman et. al. 2001
            obj.beta_X = 93; %in [K] vurgaftman et. al. 2001
            obj.E0_L = 1.133; %in [eV] vurgaftman et. al. 2001
            obj.alpha_L = 0.000276; %in [eV/K] vurgaftman et. al. 2001
            obj.beta_L = 93; %in [K] vurgaftman et. al. 2001
            obj.a = 0.000362;%in [eV/K] peassler 1999
            obj.theta = 218; %peassler 1999
            obj.p = 2.32; %peassler 1999
            obj.F = -2.9; %vurgaftman et. al. 2001
            obj.Ep = 21.5; %in [eV] by vurgaftman et. al. 2001
            obj.delta_so = 0.39; %in [eV]  by vurgaftman et. al. 2001
            obj.gamma_1 = 20; %vurgaftman et. al. 2001
            obj.gamma_2 = 8.5; %vurgaftman et. al. 2001
            obj.epsilon_s = 15.15; %ioffe.ru
            obj.VBO = -0.59; %vurgaftman et. al. 2001
            obj.C11= 832.9; %in [GPa] vurgaftman et. al. 2001
            obj.C12 = 452.6; %in [GPa] %vurgaftman et. al. 2001
            obj.a_rt = 6.0583; %lattic constant in [Angstroem] %vurgaftman et. al. 2001
            obj.a_factor = 2.74*10^(-5); %lattice temperature corection [1/T] %vurgaftman et. al. 2001
        end
    end
end

