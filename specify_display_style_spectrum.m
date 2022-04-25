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
function [Defind_Spectrum_Axis,c] = specify_display_style_spectrum(Defind_Spectrum_Axis,...
x_vector,y_vector,y_err_neg,y_err_pos,check_error,line_style,stady_ramge)

if stady_ramge
    %gets the current map range
    xl = xlim(Defind_Spectrum_Axis);
    yl = ylim(Defind_Spectrum_Axis);
end

if ~isempty(y_err_neg) && ~isempty(y_err_pos) && check_error
    y_err_neg_length = y_vector-y_err_neg;
    y_err_pos_length = y_err_pos-y_vector;
    errorbar(Defind_Spectrum_Axis,x_vector,y_vector,y_err_neg_length,y_err_pos_length,line_style);
else
    plot(Defind_Spectrum_Axis,x_vector,y_vector,line_style);
end

[xmin,xmax] = bounds(x_vector);
[ymin,ymax] = bounds(y_vector);
line(Defind_Spectrum_Axis,[xmin,xmax],[0,0],'Color','k','LineStyle','--');

if stady_ramge
    Defind_Spectrum_Axis.XLim = xl;
    Defind_Spectrum_Axis.YLim = yl;
else
    %sets the range of axis to display the full range
    Defind_Spectrum_Axis.XLim = [-inf inf];
    Defind_Spectrum_Axis.YLim = [ymin ymax];
end

%set this map as las
c = [];
end