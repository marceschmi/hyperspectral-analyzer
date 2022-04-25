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
classdef growth_rate
    % calculates growth rate
    
    properties
    end
    
    methods(Static)
        function growth_rate = calculate_growth_rate(d,t)
            %calculates the growthrat from the thickness and the time
            %d can be a matrix, vector or scalar
            %t has to be a scalar
            growth_rate = d./t;
        end
        
        function growth_rate_2 = calculate_ternary(p,growth_rate_1)
            %calculates the growthrat of the ternary alloy
            %growth_rate_1 is the growth rate of on part of the the ternary
            %for example GaAs in an AL_x_Ga_1-x_As ternary and can be a
            %matrix, vector or scalar
            %p is the percentage of the second part of the ternary - in
            %this example AlAs an has to be a matrix, vector or scalar with
            %values between 0 and 1. p needs to be the same size as growth_rate_1
            growth_rate_2 = (p.*growth_rate_1)./(1-p);
        end
    end
end

