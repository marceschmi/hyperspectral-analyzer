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
function fitType = define_fittype(n,fit_mode)
%defines the correct fit model for n peaks of the defined fit model
switch n
    case 1
        switch fit_mode
            case 'gauss'
                fitType = fittype('gauss1');
            case 'pseudo-voigt'
                fitType = fittype(@(a1,x0_1,w1,n1,x) a1.*(n1.*exp(-log(2).*((x-x0_1)./w1).^2)+(1-n1)./(1+((x-x0_1)./w1).^2)));
        end
    case 2
        switch fit_mode
            case 'gauss'
                fitType = fittype('gauss2');
            case 'pseudo-voigt'
                fitType = fittype(@(a1,x0_1,w1,n1,a2,x0_2,w2,n2,x) a1.*(n1.*exp(-log(2).*((x-x0_1)./w1).^2)+(1-n1)./(1+((x-x0_1)./w1).^2))...
                    +a2.*(n2.*exp(-log(2).*((x-x0_2)./w2).^2)+(1-n2)./(1+((x-x0_2)./w2).^2)));
        end
    case 3
        switch fit_mode
            case 'gauss'
                fitType = fittype('gauss3');
            case 'pseudo-voigt'
                fitType = fittype(@(a1,x0_1,w1,n1,a2,x0_2,w2,n2,a3,x0_3,w3,n3,x) a1.*(n1.*exp(-log(2).*((x-x0_1)./w1).^2)+(1-n1)./(1+((x-x0_1)./w1).^2))...
                    +a2.*(n2.*exp(-log(2).*((x-x0_2)./w2).^2)+(1-n2)./(1+((x-x0_2)./w2).^2))...
                    +a3.*(n3.*exp(-log(2).*((x-x0_3)./w3).^2)+(1-n3)./(1+((x-x0_3)./w3).^2)));
        end
    case 4
        switch fit_mode
            case 'gauss'
                fitType = fittype('gauss4');
            case 'pseudo-voigt'
                fitType = fittype(@(a1,x0_1,w1,n1,a2,x0_2,w2,n2,a3,x0_3,w3,n3,a4,x0_4,w4,n4,x) a1.*(n1.*exp(-log(2).*((x-x0_1)./w1).^2)+(1-n1)./(1+((x-x0_1)./w1).^2))...
                    +a2.*(n2.*exp(-log(2).*((x-x0_2)./w2).^2)+(1-n2)./(1+((x-x0_2)./w2).^2))...
                    +a3.*(n3.*exp(-log(2).*((x-x0_3)./w3).^2)+(1-n3)./(1+((x-x0_3)./w3).^2))...
                    +a4.*(n4.*exp(-log(2).*((x-x0_4)./w4).^2)+(1-n4)./(1+((x-x0_4)./w4).^2)));
        end
    case 5
        switch fit_mode
            case 'gauss'
                fitType = fittype('gauss5');
            case 'pseudo-voigt'
                fitType = fittype(@(a1,x0_1,w1,n1,a2,x0_2,w2,n2,a3,x0_3,w3,n3,a4,x0_4,w4,n4,a5,x0_5,w5,n5,x) a1.*(n1.*exp(-log(2).*((x-x0_1)./w1).^2)+(1-n1)./(1+((x-x0_1)./w1).^2))...
                    +a2.*(n2.*exp(-log(2).*((x-x0_2)./w2).^2)+(1-n2)./(1+((x-x0_2)./w2).^2))...
                    +a3.*(n3.*exp(-log(2).*((x-x0_3)./w3).^2)+(1-n3)./(1+((x-x0_3)./w3).^2))...
                    +a4.*(n4.*exp(-log(2).*((x-x0_4)./w4).^2)+(1-n4)./(1+((x-x0_4)./w4).^2))...
                    +a5.*(n5.*exp(-log(2).*((x-x0_5)./w5).^2)+(1-n5)./(1+((x-x0_5)./w5).^2)));
        end
    case 6
        switch fit_mode
            case 'gauss'
                fitType = fittype('gauss6');
            case 'pseudo-voigt'
                fitType = fittype(@(a1,x0_1,w1,n1,a2,x0_2,w2,n2,a3,x0_3,w3,n3,a4,x0_4,w4,n4,a5,x0_5,w5,n5,a6,x0_6,w6,n6,x) a1.*(n1.*exp(-log(2).*((x-x0_1)./w1).^2)+(1-n1)./(1+((x-x0_1)./w1).^2))...
                    +a2.*(n2.*exp(-log(2).*((x-x0_2)./w2).^2)+(1-n2)./(1+((x-x0_2)./w2).^2))...
                    +a3.*(n3.*exp(-log(2).*((x-x0_3)./w3).^2)+(1-n3)./(1+((x-x0_3)./w3).^2))...
                    +a4.*(n4.*exp(-log(2).*((x-x0_4)./w4).^2)+(1-n4)./(1+((x-x0_4)./w4).^2))...
                    +a5.*(n5.*exp(-log(2).*((x-x0_5)./w5).^2)+(1-n5)./(1+((x-x0_5)./w5).^2))...
                    +a6.*(n6.*exp(-log(2).*((x-x0_6)./w6).^2)+(1-n6)./(1+((x-x0_6)./w6).^2)));
        end
    case 7
        switch fit_mode
            case 'gauss'
                fitType = fittype('gauss7');
            case 'pseudo-voigt'
                fitType = fittype(@(a1,x0_1,w1,n1,a2,x0_2,w2,n2,a3,x0_3,w3,n3,a4,x0_4,w4,n4,a5,x0_5,w5,n5,a6,x0_6,w6,n6,a7,x0_7,w7,n7,x) a1.*(n1.*exp(-log(2).*((x-x0_1)./w1).^2)+(1-n1)./(1+((x-x0_1)./w1).^2))...
                    +a2.*(n2.*exp(-log(2).*((x-x0_2)./w2).^2)+(1-n2)./(1+((x-x0_2)./w2).^2))...
                    +a3.*(n3.*exp(-log(2).*((x-x0_3)./w3).^2)+(1-n3)./(1+((x-x0_3)./w3).^2))...
                    +a4.*(n4.*exp(-log(2).*((x-x0_4)./w4).^2)+(1-n4)./(1+((x-x0_4)./w4).^2))...
                    +a5.*(n5.*exp(-log(2).*((x-x0_5)./w5).^2)+(1-n5)./(1+((x-x0_5)./w5).^2))...
                    +a6.*(n6.*exp(-log(2).*((x-x0_6)./w6).^2)+(1-n6)./(1+((x-x0_6)./w6).^2))...
                    +a7.*(n7.*exp(-log(2).*((x-x0_7)./w7).^2)+(1-n7)./(1+((x-x0_7)./w7).^2)));
        end
    case 8
        switch fit_mode
            case 'gauss'
                fitType = fittype('gauss8');
            case 'pseudo-voigt'
                fitType = fittype(@(a1,x0_1,w1,n1,a2,x0_2,w2,n2,a3,x0_3,w3,n3,a4,x0_4,w4,n4,a5,x0_5,w5,n5,a6,x0_6,w6,n6,a7,x0_7,w7,n7,a8,x0_8,w8,n8,x) a1.*(n1.*exp(-log(2).*((x-x0_1)./w1).^2)+(1-n1)./(1+((x-x0_1)./w1).^2))...
                    +a2.*(n2.*exp(-log(2).*((x-x0_2)./w2).^2)+(1-n2)./(1+((x-x0_2)./w2).^2))...
                    +a3.*(n3.*exp(-log(2).*((x-x0_3)./w3).^2)+(1-n3)./(1+((x-x0_3)./w3).^2))...
                    +a4.*(n4.*exp(-log(2).*((x-x0_4)./w4).^2)+(1-n4)./(1+((x-x0_4)./w4).^2))...
                    +a5.*(n5.*exp(-log(2).*((x-x0_5)./w5).^2)+(1-n5)./(1+((x-x0_5)./w5).^2))...
                    +a6.*(n6.*exp(-log(2).*((x-x0_6)./w6).^2)+(1-n6)./(1+((x-x0_6)./w6).^2))...
                    +a7.*(n7.*exp(-log(2).*((x-x0_7)./w7).^2)+(1-n7)./(1+((x-x0_7)./w7).^2))...
                    +a8.*(n8.*exp(-log(2).*((x-x0_8)./w8).^2)+(1-n8)./(1+((x-x0_8)./w8).^2)));
        end
end
end

