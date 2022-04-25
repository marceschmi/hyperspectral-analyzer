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
function [thickness,thickness_steps,end_angle] = grow_rotation_layer(full_rotations,partial_rotations,rotation_dir,rotation_steps,start_angle,v,size_v,center,sf_growth_rate,growth_rate_correction_factor,time,theta_step_size)
%% grows a rotation layer
if full_rotations > 0
    %prelocat temporary variable
    thickness_steps = zeros(rotation_steps+1,size_v(2));
    %grow all layer parts in parallel
    parfor i = 1:rotation_steps+1
        theta = start_angle+(i-1)*theta_step_size;
        R = rotation.matrix(rotation_dir,theta);
        vr = rotation.vector(R,v,center);
        %compute local growthrates
        thickness_steps(i,:) = sf_growth_rate(vr')*growth_rate_correction_factor*time;
    end
    %sum up every simulation step
    thickness = full_rotations .* sum(thickness_steps,1);
    
    if partial_rotations > 0
        number_of_theta_steps = round(partial_rotations*rotation_steps);
        thickness_steps_partial = thickness_steps(1:number_of_theta_steps,:);
        thickness = thickness + sum(thickness_steps_partial,1);
        %find the end angle of the rotation
        end_angle = start_angle+(number_of_theta_steps-1)*theta_step_size;
    else
        end_angle = start_angle;
    end
else
    %prelocat temporary variable
    number_of_theta_steps = round(partial_rotations*rotation_steps);
    thickness_steps = zeros(number_of_theta_steps,size_v(2));
    
    %grow all layer parts in parallel
    parfor i = 1:number_of_theta_steps
        theta = start_angle+(i-1)*theta_step_size;
        R = rotation.matrix(rotation_dir,theta);
        vr = rotation.vector(R,v,center);
        %compute local growthrates
        thickness_steps(i,:) = sf_growth_rate(vr')*growth_rate_correction_factor*time;
    end
    
    %sum up every simulation step
    thickness = sum(thickness_steps,1);
    
    %find the end angle of the rotation
    end_angle = start_angle+(number_of_theta_steps-1)*theta_step_size;
end
end