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
function [f,gof] = Fit_data(x,Spectrum,peak_x_temp, ...
    Display_mode,accuracy,n_iter,start_values,Index_of_Lower_x,Index_of_Upper_x,sweep,excluded,fit_mode)
%make sure that there are no zero elements
[~,~,Peak_x] = find(peak_x_temp);

if isempty(Peak_x) == 0
    %gets the intensity at the position of the peak as a start fit
    %parameter
    for i = 1 : numel(Peak_x)
        %find the index of the peak in the x vector
        [~, peak_index(i)] = min(abs(x-Peak_x(i)));
    end
    Peak_Intensity = abs(Spectrum(peak_index));
    
    %define fittype
    case_switch_n = numel(Peak_x);
    fitType = define_fittype(case_switch_n,fit_mode);
    
    switch sweep
        case {'PL_Map','all'}
            x = converter.energy_wavelength(x);
            if ~isempty(excluded)
                excluded = converter.energy_wavelength(excluded);
            end
    end
    
    fitOptions = fitoptions(fitType);
    
    switch fit_mode
        case 'gauss'
            if ~isempty(start_values)
                %define start points
                coeff_names = coeffnames(fitType);
                for ii = 1 : numel(coeff_names)/3
                    switch sweep
                        case {'PL_Map','all'}
                            fitOptions.Startpoint(2+(ii-1)*3) = converter.energy_wavelength(Peak_x(ii));
                        otherwise
                            fitOptions.Startpoint(2+(ii-1)*3) = Peak_x(ii);
                    end
                end
                
                for ii = 1 : numel(coeff_names)/3
                    fitOptions.Startpoint(1+(ii-1)*3) = Peak_Intensity(ii);
                end
                
                for ii = 1 : numel(coeff_names)/3
                    fitOptions.Startpoint(3+(ii-1)*3) = start_values(5,ii);
                end
                
                for ii = 1 : numel(coeff_names)/3
                    switch sweep
                        case {'PL_Map','all'}
                            fitOptions.Lower(2+(ii-1)*3) = converter.energy_wavelength(start_values(2,ii));
                        otherwise
                            fitOptions.Lower(2+(ii-1)*3) = Peak_x(ii) - start_values(1,ii);
                    end
                end
                
                for ii = 1 : numel(coeff_names)/3
                    fitOptions.Lower(1+(ii-1)*3) = start_values(3,ii);
                end
                
                for ii = 1 : numel(coeff_names)/3
                    fitOptions.Lower(3+(ii-1)*3) = start_values(6,ii);
                end
                
                for ii = 1 : numel(coeff_names)/3
                    switch sweep
                        case {'PL_Map','all'}
                            fitOptions.Upper(2+(ii-1)*3) = converter.energy_wavelength(start_values(1,ii));
                        otherwise
                            fitOptions.Upper(2+(ii-1)*3) = start_values(2,ii);
                    end
                end
                
                for ii = 1 : numel(coeff_names)/3
                    fitOptions.Upper(1+(ii-1)*3) = start_values(4,ii);
                end
                
                for ii = 1 : numel(coeff_names)/3
                    fitOptions.Upper(3+(ii-1)*3) = start_values(7,ii);
                end
            end
        case 'pseudo-voigt'
            if ~isempty(start_values)
                %define start points
                coeff_names = coeffnames(fitType);
                for ii = 1 : numel(coeff_names)/4
                    fitOptions.Startpoint(1+(ii-1)*4) = Peak_Intensity(ii);
                end
                
                for ii = 1 : numel(coeff_names)/4
                    switch sweep
                        case {'PL_Map','all'}
                            fitOptions.Startpoint(2+(ii-1)*4) = converter.energy_wavelength(Peak_x(ii));
                        otherwise
                            fitOptions.Startpoint(2+(ii-1)*4) = Peak_x(ii);
                    end
                end
                
                for ii = 1 : numel(coeff_names)/4
                    fitOptions.Startpoint(3+(ii-1)*4) = start_values(5,ii)/2;
                end
                
                for ii = 1 : numel(coeff_names)/4
                    fitOptions.Startpoint(4+(ii-1)*4) = 0.5;
                end
                
                for ii = 1 : numel(coeff_names)/4
                    fitOptions.Lower(1+(ii-1)*4) = start_values(3,ii);
                end
                
                for ii = 1 : numel(coeff_names)/4
                    switch sweep
                        case {'PL_Map','all'}
                            fitOptions.Lower(2+(ii-1)*4) = converter.energy_wavelength(start_values(2,ii));
                        otherwise
                            fitOptions.Lower(2+(ii-1)*4) = Peak_x(ii) - start_values(1,ii);
                    end
                end
                
                for ii = 1 : numel(coeff_names)/4
                    if start_values(6,ii) == 0
                        fitOptions.Lower(3+(ii-1)*4) = start_values(6,ii);
                    else
                        fitOptions.Lower(3+(ii-1)*4) = start_values(6,ii)/2;
                    end
                end
                
                for ii = 1 : numel(coeff_names)/4
                    fitOptions.Lower(4+(ii-1)*4) = 0;
                end
                
                for ii = 1 : numel(coeff_names)/4
                    fitOptions.Upper(1+(ii-1)*4) = start_values(4,ii);
                end
                
                for ii = 1 : numel(coeff_names)/4
                    switch sweep
                        case {'PL_Map','all'}
                            fitOptions.Upper(2+(ii-1)*4) = converter.energy_wavelength(start_values(1,ii));
                        otherwise
                            fitOptions.Upper(2+(ii-1)*4) = start_values(2,ii);
                    end
                end
                
                for ii = 1 : numel(coeff_names)/4
                    fitOptions.Upper(3+(ii-1)*4) = start_values(7,ii);
                end
                
                for ii = 1 : numel(coeff_names)/4
                    fitOptions.Upper(4+(ii-1)*4) = 1;
                end
            end
    end
    
    fitOptions.Display = Display_mode; %'iter' , 'off'
    fitOptions.TolFun = accuracy;
    fitOptions.TolX = accuracy;
    fitOptions.MaxIter =  n_iter;
    fitOptions.MaxFunEvals = n_iter;
    
    Spectrum = Spectrum';
    
    %prelocat variables
    f = [];
    gof = [];
    
    try
        if isempty(excluded)
            [f,gof] = fit(x(Index_of_Lower_x:Index_of_Upper_x),Spectrum(Index_of_Lower_x:Index_of_Upper_x),fitType,fitOptions);
        else
            x_fit = x(Index_of_Lower_x:Index_of_Upper_x);
            Spectrum_fit = Spectrum(Index_of_Lower_x:Index_of_Upper_x);
            for i = 1 :numel(excluded)
                Spectrum_fit((excluded(i)-0.0001 < x_fit) & (x_fit < excluded(i)+0.0001)) = [];
                x_fit((excluded(i)-0.0001 < x_fit) & (x_fit < excluded(i)+0.0001)) = [];
            end
            [f,gof] = fit(x_fit,Spectrum_fit,fitType,fitOptions);
        end
    catch exception
        disp(exception)
        %continue
    end
    
    %check if there was a fit
    if isempty(f)
        return
    end
end
end