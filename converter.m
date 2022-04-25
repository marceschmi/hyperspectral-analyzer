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
classdef converter
    %Mediator functions between units
    
    properties
    end
    
    methods(Static)
        function wavelength = energy_wavelength(energy)
            %vonverts an energy aray in eV to a wavelength array in nm
            %define constants
            constants = global_constants;
            energy_factor = constants.c*constants.h/(1e-9*constants.e);
            
            wavelength = energy_factor./energy;
        end
        
        function thickness_metrix_nm = ML_to_nm(material,thickness_metrix,x_matrix,T_growth)
            ML = lattice.calculate_ML(material,x_matrix,T_growth);
            ML = ML/10^(-9); %m to nm
            thickness_metrix_nm = thickness_metrix.*ML;
        end
        
        function thickness_metrix_ML = nm_to_ML(material,thickness_metrix,x_matrix,T_growth)
            ML = lattice.calculate_ML(material,x_matrix,T_growth);
            ML = ML/10^(-9); %m to nm
            thickness_metrix_ML = thickness_metrix./ML;
        end
        
        function R = thickness_to_roughness(thickness_metrix,gamma)
            %converts a thickness in ML to a roughness
            R = gamma * sin(pi .* thickness_metrix).^2;
        end
        
        function FWHM = FWHM_sigma(Sigma_x,fit_mode)
            % Sigma_x = ci for the fits
            %FWHM = 2*sqrt(2*log(2))*c from https://en.wikipedia.org/wiki/Gaussian_function
            %https://de.mathworks.com/help/curvefit/gaussian.html gives for the c
            %another value. Following this the ci in matlab is equel to sqrt(2)*c from wikipedia
            %so for the FWHM on has to use Sigma_x/sqrt(2) insted of Sigma_x
            
            %for the pseudo-voigt fit the FWHM is:
            %FWHM = 2*Sigma_x; from https://de.wikipedia.org/wiki/Voigt-Profil
            switch fit_mode
                case 'gauss'
                    FWHM = 2*sqrt(2*log(2))*(Sigma_x/sqrt(2));
                case 'pseudo-voigt'
                    FWHM = 2*Sigma_x;
            end
        end
        
        function degr = rad2degr(rad)
            %converts rad to degree
            degr = rad*180/pi;
        end
        
        function rad = degr2rad(degr)
            %rconverts degree to rad
            rad = degr*pi/180;
        end
        
        %         function number_of_theta_steps = rad2steps(rotations_rad,theta_step_size)
        %             %converts radial units in steps
        %             number_of_theta_steps = round(rotations_rad/theta_step_size + 1);
        %         end
        
        function theta_step_size = theta_steps(rotation_steps)
            theta_step_size = 2*pi/rotation_steps;
        end
    end
end

