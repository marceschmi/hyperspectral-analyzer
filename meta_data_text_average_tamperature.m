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
function text = meta_data_text_average_tamperature(temp_map,n,p)
A(:,:) = temp_map(n,p,:,:);
average = mean(A,'all','omitnan');
maximum = max(A,[],'all');
minimum = min(A,[],'all');
text = join(['minimum temperature: ',replace(num2str(minimum),'.',','),', K; average temperature: ',replace(num2str(average),'.',','),' K; maximum temperature: ',replace(num2str(maximum),'.',','),' K']);
end