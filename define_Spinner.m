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
function Index = define_Spinner(spinner,vector,start_value)
lower_limit = min(vector);
upper_limit = max(vector);

if numel(vector) == 1
    step_value = 0;
else
    step_value = abs(vector(2)-vector(1));
end

if step_value == 0
    %f = errordlg('The step size is zero.','Step Error');
    spinner.Enable = 'off';
    spinner.Limits = [-inf inf];
else
    spinner.Step = step_value;
    spinner.Enable = 'on';
    spinner.Limits = [lower_limit upper_limit];
end

switch start_value
    case 'low'
        Index = find_index(vector,lower_limit,1);
        spinner.Value = lower_limit;
    case 'upper'
        Index = find_index(vector,upper_limit,1);
        spinner.Value = upper_limit;
    otherwise
        Index = find_index(vector,start_value,1);
        spinner.Value = vector(Index);
end
end