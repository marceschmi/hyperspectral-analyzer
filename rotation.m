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
classdef rotation
    % evering related to rotations
    
    properties
    end
    
    methods(Static)
        function R = matrix(rotation_dir,theta)
            %theta is given in rad
            %finds the rotation direaction
            % - rotation_dir = 1 -> clockwise
            % - rotation_dir = 0 -> counter clockwise
            
            if rotation_dir
                %rotates the 2D Matrix clockwise by theta
                R = [cos(theta) sin(theta); -sin(theta) cos(theta)];
            else
                %rotates the 2D Matrix counter clockwise by theta
                R = [cos(theta) -sin(theta); sin(theta) cos(theta)];
            end
        end
        
        function vr = vector(R,v,center)
            %rotates the 2D Matrix v bei R around a center
            vr =  R*(v - center);
        end
        
        function [full_rotations,partial_rotations,partial_rotations_rad] = parameters(rotations)
            full_rotations = floor(rotations);
            partial_rotations = rotations-full_rotations;
            partial_rotations_rad = partial_rotations*2*pi;
        end
        
        function steps_per_time = during_time(t,time_per_step)
            steps_per_time = round(t/time_per_step);
        end
        
        function tps = time_per_step(t_tot,rotation_steps)
            %computes the rotation time
            tps = t_tot/rotation_steps;
        end        
    end
end

