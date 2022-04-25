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
function display_material(Defind_Map_Axis,spectrum,y_lim_style,material,x,T,type)
hold(Defind_Map_Axis,"on")

%length of the line
if y_lim_style
    y = get(Defind_Map_Axis,'ylim');
else
    y = [min(spectrum),max(spectrum)];
end

%bandgap of the material
switch material
    case {'gaas', 'alas', 'inas'}
        switch material
            case 'gaas'
                m = materials.gaas;
            case 'alas'
                m = materials.alas;
            case 'inas'
                m = materials.inas;
        end
        switch type
            case 'varshnie'
                Eg = band_gap.varshnie(m,T);
            case 'peassler'
                Eg = band_gap.peassler(m,T);
        end
    case {'algaas','ingaas'}
        switch material
            case 'algaas'
                m1 = materials.alas;
                m2 = materials.gaas;
            case 'ingaas'
                m1 = materials.inas;
                m2 = materials.gaas;
        end
        switch type
            case 'varshnie'
                Eg = band_gap.composition_varshnie(x,T,m1,m2);
            case 'peassler'
                Eg = band_gap.composition_peassler(x,T,m1,m2);
        end
end

wavelength = converter.energy_wavelength(Eg);

line(Defind_Map_Axis,[wavelength, wavelength], [y(1), y(2)], 'LineWidth', 2,'LineStyle','--', 'Color', 'r');
hold(Defind_Map_Axis,"off")
end

