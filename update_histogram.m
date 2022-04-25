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
function update_histogram(Defind_Map_Axis,pre_processed_data_map,bins,show_statistcs)
%bins = number of bars in histogram
%show_statistcs has to be 1 or 0
%create a vector for the histogramm appearance of the data
pre_processed_data_vector = pre_processed_data_map(:);

%get statistics
min_data = min(pre_processed_data_vector);
median_data = median(pre_processed_data_vector,'omitnan');
max_data = max(pre_processed_data_vector);

%displayes it
formatSpec = '%.1f';
cla(Defind_Map_Axis)
hold(Defind_Map_Axis,'on');
h = histogram(Defind_Map_Axis,pre_processed_data_vector,bins);
if show_statistcs
    line(Defind_Map_Axis,[min_data, min_data], [0, max(h.BinCounts)], 'LineWidth', 2,'LineStyle','--', 'Color', 'r');
    text(Defind_Map_Axis,min_data,max(h.BinCounts)-1,num2str(min_data,formatSpec),'FontSize',14);
    line(Defind_Map_Axis,[median_data, median_data], [0, max(h.BinCounts)], 'LineWidth', 2,'LineStyle','--', 'Color', 'r');
    text(Defind_Map_Axis,median_data,max(h.BinCounts)-1,num2str(median_data,formatSpec),'FontSize',14);
    line(Defind_Map_Axis,[max_data, max_data], [0, max(h.BinCounts)], 'LineWidth', 2,'LineStyle','--', 'Color', 'r');
    text(Defind_Map_Axis,max_data,max(h.BinCounts)-1,num2str(max_data,formatSpec),'FontSize',14);
end
hold(Defind_Map_Axis,'off');
end

