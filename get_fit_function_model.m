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
function [parameter,grade] = get_fit_function_model(fit_formula)
fit_formula = fit_formula(find(~isspace(fit_formula)));
cases = {'a1*exp(-((x-b1)/c1)^2)','a1*exp(-((x-b1)/c1)^2)+a2*exp(-((x-b2)/c2)^2)',...
    'a1*exp(-((x-b1)/c1)^2)+a2*exp(-((x-b2)/c2)^2)+a3*exp(-((x-b3)/c3)^2)'...
    'a1*exp(-((x-b1)/c1)^2)+a2*exp(-((x-b2)/c2)^2)+a3*exp(-((x-b3)/c3)^2)+a4*exp(-((x-b4)/c4)^2)',...
    'a1*exp(-((x-b1)/c1)^2)+a2*exp(-((x-b2)/c2)^2)+a3*exp(-((x-b3)/c3)^2)+a4*exp(-((x-b4)/c4)^2)+a5*exp(-((x-b5)/c5)^2)',...
    'a1*exp(-((x-b1)/c1)^2)+a2*exp(-((x-b2)/c2)^2)+a3*exp(-((x-b3)/c3)^2)+a4*exp(-((x-b4)/c4)^2)+a5*exp(-((x-b5)/c5)^2)+a6*exp(-((x-b6)/c6)^2)',...
    'a1*exp(-((x-b1)/c1)^2)+a2*exp(-((x-b2)/c2)^2)+a3*exp(-((x-b3)/c3)^2)+a4*exp(-((x-b4)/c4)^2)+a5*exp(-((x-b5)/c5)^2)+a6*exp(-((x-b6)/c6)^2)+a7*exp(-((x-b7)/c7)^2)',...
    'a1*exp(-((x-b1)/c1)^2)+a2*exp(-((x-b2)/c2)^2)+a3*exp(-((x-b3)/c3)^2)+a4*exp(-((x-b4)/c4)^2)+a5*exp(-((x-b5)/c5)^2)+a6*exp(-((x-b6)/c6)^2)+a7*exp(-((x-b7)/c7)^2)+a8*exp(-((x-b8)/c8)^2)',...
    'a1.*(n1.*exp(-log(2).*((x-x0_1)./w1).^2)+(1-n1)./(1+((x-x0_1)./w1).^2))',...
    'a1.*(n1.*exp(-log(2).*((x-x0_1)./w1).^2)+(1-n1)./(1+((x-x0_1)./w1).^2))+a2.*(n2.*exp(-log(2).*((x-x0_2)./w2).^2)+(1-n2)./(1+((x-x0_2)./w2).^2))',...
    'a1.*(n1.*exp(-log(2).*((x-x0_1)./w1).^2)+(1-n1)./(1+((x-x0_1)./w1).^2))+a2.*(n2.*exp(-log(2).*((x-x0_2)./w2).^2)+(1-n2)./(1+((x-x0_2)./w2).^2))+a3.*(n3.*exp(-log(2).*((x-x0_3)./w3).^2)+(1-n3)./(1+((x-x0_3)./w3).^2))',...
    'a1.*(n1.*exp(-log(2).*((x-x0_1)./w1).^2)+(1-n1)./(1+((x-x0_1)./w1).^2))+a2.*(n2.*exp(-log(2).*((x-x0_2)./w2).^2)+(1-n2)./(1+((x-x0_2)./w2).^2))+a3.*(n3.*exp(-log(2).*((x-x0_3)./w3).^2)+(1-n3)./(1+((x-x0_3)./w3).^2))+a4.*(n4.*exp(-log(2).*((x-x0_4)./w4).^2)+(1-n4)./(1+((x-x0_4)./w4).^2))',...
    'a1.*(n1.*exp(-log(2).*((x-x0_1)./w1).^2)+(1-n1)./(1+((x-x0_1)./w1).^2))+a2.*(n2.*exp(-log(2).*((x-x0_2)./w2).^2)+(1-n2)./(1+((x-x0_2)./w2).^2))+a3.*(n3.*exp(-log(2).*((x-x0_3)./w3).^2)+(1-n3)./(1+((x-x0_3)./w3).^2))+a4.*(n4.*exp(-log(2).*((x-x0_4)./w4).^2)+(1-n4)./(1+((x-x0_4)./w4).^2))+a5.*(n5.*exp(-log(2).*((x-x0_5)./w5).^2)+(1-n5)./(1+((x-x0_5)./w5).^2))',...
    'a1.*(n1.*exp(-log(2).*((x-x0_1)./w1).^2)+(1-n1)./(1+((x-x0_1)./w1).^2))+a2.*(n2.*exp(-log(2).*((x-x0_2)./w2).^2)+(1-n2)./(1+((x-x0_2)./w2).^2))+a3.*(n3.*exp(-log(2).*((x-x0_3)./w3).^2)+(1-n3)./(1+((x-x0_3)./w3).^2))+a4.*(n4.*exp(-log(2).*((x-x0_4)./w4).^2)+(1-n4)./(1+((x-x0_4)./w4).^2))+a5.*(n5.*exp(-log(2).*((x-x0_5)./w5).^2)+(1-n5)./(1+((x-x0_5)./w5).^2))+a6.*(n6.*exp(-log(2).*((x-x0_6)./w6).^2)+(1-n6)./(1+((x-x0_6)./w6).^2))',...
    'a1.*(n1.*exp(-log(2).*((x-x0_1)./w1).^2)+(1-n1)./(1+((x-x0_1)./w1).^2))+a2.*(n2.*exp(-log(2).*((x-x0_2)./w2).^2)+(1-n2)./(1+((x-x0_2)./w2).^2))+a3.*(n3.*exp(-log(2).*((x-x0_3)./w3).^2)+(1-n3)./(1+((x-x0_3)./w3).^2))+a4.*(n4.*exp(-log(2).*((x-x0_4)./w4).^2)+(1-n4)./(1+((x-x0_4)./w4).^2))+a5.*(n5.*exp(-log(2).*((x-x0_5)./w5).^2)+(1-n5)./(1+((x-x0_5)./w5).^2))+a6.*(n6.*exp(-log(2).*((x-x0_6)./w6).^2)+(1-n6)./(1+((x-x0_6)./w6).^2))+a7.*(n7.*exp(-log(2).*((x-x0_7)./w7).^2)+(1-n7)./(1+((x-x0_7)./w7).^2))',...
    'a1.*(n1.*exp(-log(2).*((x-x0_1)./w1).^2)+(1-n1)./(1+((x-x0_1)./w1).^2))+a2.*(n2.*exp(-log(2).*((x-x0_2)./w2).^2)+(1-n2)./(1+((x-x0_2)./w2).^2))+a3.*(n3.*exp(-log(2).*((x-x0_3)./w3).^2)+(1-n3)./(1+((x-x0_3)./w3).^2))+a4.*(n4.*exp(-log(2).*((x-x0_4)./w4).^2)+(1-n4)./(1+((x-x0_4)./w4).^2))+a5.*(n5.*exp(-log(2).*((x-x0_5)./w5).^2)+(1-n5)./(1+((x-x0_5)./w5).^2))+a6.*(n6.*exp(-log(2).*((x-x0_6)./w6).^2)+(1-n6)./(1+((x-x0_6)./w6).^2))+a7.*(n7.*exp(-log(2).*((x-x0_7)./w7).^2)+(1-n7)./(1+((x-x0_7)./w7).^2))+a8.*(n8.*exp(-log(2).*((x-x0_8)./w8).^2)+(1-n8)./(1+((x-x0_8)./w8).^2))'};
switch fit_formula
    case cases{1,1}
        parameter = 3;
        grade = 1;
    case cases{1,2}
        parameter = 3;
        grade = 2;
    case cases{1,3}
        parameter = 3;
        grade = 3;
    case cases{1,4}
        parameter = 3;
        grade = 4;
    case cases{1,5}
        parameter = 3;
        grade = 5;
    case cases{1,6}
        parameter = 3;
        grade = 6;
    case cases{1,7}
        parameter = 3;
        grade = 7;
    case cases{1,8}
        parameter = 3;
        grade = 8;
    case cases{1,9}
        parameter = 4;
        grade = 1;
    case cases{1,10}
        parameter = 4;
        grade = 2;
    case cases{1,11}
        parameter = 4;
        grade = 3;
    case cases{1,12}
        parameter = 4;
        grade = 4;
    case cases{1,13}
        parameter = 4;
        grade = 5;
    case cases{1,14}
        parameter = 4;
        grade = 6;
    case cases{1,15}
        parameter = 4;
        grade = 7;
    case cases{1,16}
        parameter = 4;
        grade = 8;
end
end

