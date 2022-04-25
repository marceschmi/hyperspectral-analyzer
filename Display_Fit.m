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
function [fit_spectra,npeaks] = Display_Fit(Fit_Data_Map_Display,fit_mode,x,datatype)
%tranforms the x data to the correct format
switch datatype
    case {'PL_Map','all'}
        %define constants
        x = converter.energy_wavelength(x);
end

size_data = size(Fit_Data_Map_Display);
spectra = zeros(1,numel(x));

k = 0;
for s = 1 : size_data(1)
    %get the parameters
    coeffvals = coeffvalues(Fit_Data_Map_Display{s});
    
    %define the model parameters
    switch fit_mode
        case 'gauss'
            parameters = 3;
            fitfun = @(a,x0,w,x) a.*exp(-((x-x0)./w).^2);
        case 'pseudo-voigt'
            parameters = 4;
            fitfun = @(a,x0,w,n,x) a.*(n.*exp(-log(2).*((x-x0)./w).^2)+(1-n)./(1+((x-x0)./w).^2));
    end
    
    %gets the number of individuell peaks
    npeaks(s)= numel(coeffvals)/parameters;
    
    for i = 1 : npeaks(s)
        k = k+1;
        switch fit_mode
            case 'gauss'
                spectra(k,:) = fitfun(coeffvals(1+(i-1)*3),coeffvals(2+(i-1)*3),coeffvals(3+(i-1)*3),x);
            case 'pseudo-voigt'
                spectra(k,:) = fitfun(coeffvals(1+(i-1)*4),coeffvals(2+(i-1)*4),coeffvals(3+(i-1)*4),coeffvals(4+(i-1)*4),x);
        end
    end
    
end
y_combined_fit = sum(spectra,1);
fit_spectra = [y_combined_fit;spectra];
end

