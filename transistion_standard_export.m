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
function transistion_standard_export(PLMap_Data,wavelength_range,start,direction,transition_factor,save_path)
%gets the transition and exports it
%at max power and min temperature

%define start end end Wavelength index
start_wavelength_index = find_index(PLMap_Data.Wavelength,wavelength_range(1),1);
end_wavelength_index = find_index(PLMap_Data.Wavelength,wavelength_range(2),1);
power_index = find_index(PLMap_Data.Power,max(PLMap_Data.Power),1);
tamperature_index = find_index(PLMap_Data.Temperature_index,min(PLMap_Data.Temperature_index),1);

switch direction
    case 'x'
        %define closest x value
        x = find_index(PLMap_Data.X_vector,start,1);
        position = PLMap_Data.X_vector(x);
        
        %creat Spectrum array
        j = 0;
        for i = 1 : numel(PLMap_Data.Y_vector)
            j = j+1;
            PL_Intensity(j,:) = PLMap_Data.data_array(tamperature_index,power_index,i,x,start_wavelength_index:end_wavelength_index);
        end
    case 'y'
        %define closest x value
        y = find_index(PLMap_Data.Y_vector,start,1);
        position = PLMap_Data.Y_vector(y);
        
        %creat Spectrum array
        j = 0;
        for i = 1 : numel(PLMap_Data.X_vector)
            j = j+1;
            PL_Intensity(j,:) = PLMap_Data.data_array(tamperature_index,power_index,y,i,start_wavelength_index:end_wavelength_index);
        end
end

%Define Wavelength vektor
Spectral_Wavelength_Vector = PLMap_Data.Wavelength(start_wavelength_index:end_wavelength_index);

%creats a figure for save
Fig = figure;
ax = axes(Fig);

%Displays colormap
switch direction
    case 'x'
        [~,~,~] = Display_Gradient(ax,'linear',Spectral_Wavelength_Vector,PLMap_Data.Y_vector,PL_Intensity,100,'jet',':*','color',0);
        ylabel(ax, 'Y [mm]');
        str_title =  join(['gradient spectrum along x = ',replace(num2str(position,'%.1f'),'.',','),' mm'],"");
        full_filename = join(['spectrum_along_x_',replace(num2str(start,'%.1f'),'.','_'),...
            '_mm_from_',replace(num2str(Spectral_Wavelength_Vector(1),'%.1f'),'.','_'),...
            '_nm_to_',replace(num2str(Spectral_Wavelength_Vector(end),'%.1f'),'.','_'),'_nm'],"");
    case 'y'
        [~,~,~] = Display_Gradient(ax,'linear',Spectral_Wavelength_Vector,PLMap_Data.X_vector,PL_Intensity,100,'jet',':*','color',0);
        ylabel(ax, 'X [mm]');
        str_title =  join(['gradient spectrum along y = ',replace(num2str(position,'%.1f'),'.',','),' mm'],"");
        full_filename = join(['spectrum_along_y_',replace(num2str(start,'%.1f'),'.','_'),...
            '_mm_from_',replace(num2str(Spectral_Wavelength_Vector(1),'%.1f'),'.','_'),...
            '_nm_to_',replace(num2str(Spectral_Wavelength_Vector(end),'%.1f'),'.','_'),'_nm'],"");
end

xlabel(ax, 'wavelength [nm]');
title(ax, str_title);

Fig.Position = [20,60,1172,700];

%saves the graph
%saveas(Fig, fullfile(save_path, full_filename), 'fig');
saveas(Fig, fullfile(save_path, full_filename), 'png');
delete(Fig);

%creats a figure for save
Fig = figure;
ax = axes(Fig);

%Displays waterfall
switch direction
    case 'x'
        [~,~,~] = Display_Gradient(ax,'linear',Spectral_Wavelength_Vector,PLMap_Data.Y_vector,PL_Intensity,100,'jet',':*','waterfall',0);
        str_title =  join(['gradient spectrum along x = ',replace(num2str(position,'%.1f'),'.',','),' mm'],"");
        full_filename = join(['waterfall_along_x_',replace(num2str(start,'%.1f'),'.','_'),...
            '_mm_from_',replace(num2str(Spectral_Wavelength_Vector(1),'%.1f'),'.','_'),...
            '_nm_to_',replace(num2str(Spectral_Wavelength_Vector(end),'%.1f'),'.','_'),'_nm'],"");
    case 'y'
        [~,~,~] = Display_Gradient(ax,'linear',Spectral_Wavelength_Vector,PLMap_Data.X_vector,PL_Intensity,100,'jet',':*','waterfall',0);
        str_title =  join(['gradient spectrum along y = ',replace(num2str(position,'%.1f'),'.',','),' mm'],"");
        full_filename = join(['waterfall_along_y_',replace(num2str(start,'%.1f'),'.','_'),...
            '_mm_from_',replace(num2str(Spectral_Wavelength_Vector(1),'%.1f'),'.','_'),...
            '_nm_to_',replace(num2str(Spectral_Wavelength_Vector(end),'%.1f'),'.','_'),'_nm'],"");
end


xlabel(ax, 'wavelength [nm]');
ylabel(ax, 'intensity [counts/s]');
title(ax, str_title);

Fig.Position = [20,60,1172,700];

%save the graph
%saveas(Fig, fullfile(save_path, full_filename), 'fig');
saveas(Fig, fullfile(save_path, full_filename), 'png');
delete(Fig);

%creats a figure for save
Fig = figure;
ax = axes(Fig);

%Define Wavelength vektor
set_Wavelength_Vector = [];
%Displays waterfall
switch direction
    case 'x'
        [~,data_map,~] = Display_Gradient(ax,'linear',set_Wavelength_Vector,PLMap_Data.Y_vector,PL_Intensity,100,'jet',':*','waterfall',0);
        xlabel(ax, 'Y [mm]');
    case 'y'
        [~,data_map,~] = Display_Gradient(ax,'linear',set_Wavelength_Vector,PLMap_Data.X_vector,PL_Intensity,100,'jet',':*','waterfall',0);
        xlabel(ax, 'X [mm]');
end

ylabel(ax, 'intensity [counts/s]');
hold(ax,'on')

%statistics
[v_max,idx_max] = max(data_map);
[v_min,idx_min] = min(data_map);

if idx_min<idx_max
    idx_max_temp = idx_max;
    v_max_temp = v_max;
    idx_min_temp = idx_min;
    v_min_temp = v_min;
    
    idx_max = idx_min_temp;
    v_max = v_min_temp;
    idx_min = idx_max_temp;
    v_min = v_max_temp;
end

transition = data_map(idx_max:idx_min,1);
transition_hight = (v_max-v_min)*transition_factor;
idx_transition = find_index(transition,transition_hight,1);

switch direction
    case 'x'
        %horizontal line
        line([PLMap_Data.Y_vector(1) PLMap_Data.Y_vector(end)],...
            [transition_hight transition_hight],'LineStyle','--');
        
        %vertical line
        line([PLMap_Data.Y_vector(idx_max+idx_transition-1) PLMap_Data.Y_vector(idx_max+idx_transition-1)],...
            [v_min v_max],'LineStyle','--');
        
        %display the chosen spectra in the summed plot
        plot(PLMap_Data.Y_vector(idx_max+idx_transition-1),transition(idx_transition),'r*');
        
        str_title =  join(['summed intensity at x = ',replace(num2str(position,'%.1f'),'.',','),' mm from ',...
            replace(num2str(PLMap_Data.Wavelength(start_wavelength_index),'%.1f'),'.',','),' nm to ',...
            replace(num2str(PLMap_Data.Wavelength(end_wavelength_index),'%.1f'),'.',','),' nm'],"");
        
        full_filename = join(['summed_intensity_along_x_',replace(num2str(start,'%.1f'),'.','_'),...
            '_mm_from_',replace(num2str(Spectral_Wavelength_Vector(1),'%.1f'),'.','_'),...
            '_nm_to_',replace(num2str(Spectral_Wavelength_Vector(end),'%.1f'),'.','_'),'_nm'],"");
    case 'y'
        %horizontal line
        line([PLMap_Data.X_vector(1) PLMap_Data.X_vector(end)],...
            [transition_hight transition_hight],'LineStyle','--');
        
        %vertical line
        line([PLMap_Data.X_vector(idx_max+idx_transition-1) PLMap_Data.X_vector(idx_max+idx_transition-1)],...
            [v_min v_max],'LineStyle','--');
        
        %display the chosen spectra in the summed plot
        plot(PLMap_Data.X_vector(idx_max+idx_transition-1),transition(idx_transition),'r*');
        
        str_title =  join(['summed intensity at y = ',replace(num2str(position,'%.1f'),'.',','),' mm from ',...
            replace(num2str(PLMap_Data.Wavelength(start_wavelength_index),'%.1f'),'.',','),' nm to ',...
            replace(num2str(PLMap_Data.Wavelength(end_wavelength_index),'%.1f'),'.',','),' nm'],"");
        
        full_filename = join(['summed_intensity_along_y_',replace(num2str(start,'%.1f'),'.','_'),...
            '_mm_from_',replace(num2str(Spectral_Wavelength_Vector(1),'%.1f'),'.','_'),...
            '_nm_to_',replace(num2str(Spectral_Wavelength_Vector(end),'%.1f'),'.','_'),'_nm'],"");
end


Fig.Position = [20,60,1172,700];

title(ax, str_title);
hold(ax,'off')

%save the graph
%saveas(Fig, fullfile(save_path, full_filename), 'fig');
saveas(Fig, fullfile(save_path, full_filename), 'png');
delete(Fig);

%creats a figure for save
Fig = figure;
ax = axes(Fig);

%display the spectrum at transition
switch direction
    case 'x'
        axes_vector(:) = PLMap_Data.data_array(tamperature_index,power_index,idx_max+idx_transition-1,x,...
            start_wavelength_index:end_wavelength_index);
        
        str_title =  join(['spectrum at x = ',replace(num2str(position,'%.1f'),'.',','),' mm,',...
            ' y = ',replace(num2str(PLMap_Data.Y_vector(idx_max+idx_transition-1),'%.1f'),'.',','),' mm'],"");
        
        full_filename = join(['spectrum_at_x_',replace(num2str(start,'%.1f'),'.','_'),'_mm_y_',...
            replace(num2str(PLMap_Data.Y_vector(idx_max+idx_transition-1),'%.1f'),'.','_'),...
            '_mm_from_',replace(num2str(Spectral_Wavelength_Vector(1),'%.1f'),'.','_'),...
            '_nm_to_',replace(num2str(Spectral_Wavelength_Vector(end),'%.1f'),'.','_'),'_nm'],"");
    case 'y'
        axes_vector(:) = PLMap_Data.data_array(tamperature_index,power_index,y,idx_max+idx_transition-1,...
            start_wavelength_index:end_wavelength_index);
        
        str_title =  join(['spectrum at x = ',replace(num2str(PLMap_Data.X_vector(idx_max+idx_transition-1),'%.1f'),'.',','),' mm,',...
            ' y = ',replace(num2str(position,'%.1f'),'.',','),' mm'],"");
        
        full_filename = join(['spectrum_at_x_',replace(num2str(PLMap_Data.X_vector(idx_max+idx_transition-1),'%.1f'),'.','_'),'_mm_y_',...
            replace(num2str(start,'%.1f'),'.','_'),...
            '_mm_from_',replace(num2str(Spectral_Wavelength_Vector(1),'%.1f'),'.','_'),...
            '_nm_to_',replace(num2str(Spectral_Wavelength_Vector(end),'%.1f'),'.','_'),'_nm'],"");
end
[~,~] = specify_display_style_spectrum(ax,Spectral_Wavelength_Vector,axes_vector,[],[],0,'-',0);

xlabel(ax, 'wavelength [nm]');
ylabel(ax, 'intensity [counts/s]');

title(ax, str_title);

Fig.Position = [20,60,1172,700];

%save the graph
%saveas(Fig, fullfile(save_path, full_filename), 'fig');
saveas(Fig, fullfile(save_path, full_filename), 'png');
delete(Fig);

%creats a figure for save
Fig = figure;
ax = axes(Fig);

%get info for map
label{1} = join(['summed intensity from ',...
    replace(num2str(PLMap_Data.Wavelength(start_wavelength_index),'%.1f'),'.',','),' nm to ',...
    replace(num2str(PLMap_Data.Wavelength(end_wavelength_index),'%.1f'),'.',','),' nm'],"");
label{2} = 'X [mm]';
label{3} = 'Y [mm]';
label{4} = 'Intensity (Counts/s)';

%displays Map
[~,~,~,~,~,~] = update_map(PLMap_Data,PLMap_Data.Temperature_index(tamperature_index),...
    PLMap_Data.Power(power_index),Spectral_Wavelength_Vector(1),Spectral_Wavelength_Vector(end),...
    ax,100,'hot',-inf,inf,label,'integrated',0,5,'off',[],0);

Fig.Position = [20,60,800,700];

full_filename = join(['map_from_',replace(num2str(Spectral_Wavelength_Vector(1),'%.1f'),'.','_'),...
    '_nm_to_',replace(num2str(Spectral_Wavelength_Vector(end),'%.1f'),'.','_'),'_nm'],"");
%saveas(Fig, fullfile(save_path, full_filename), 'fig');
saveas(Fig, fullfile(save_path, full_filename), 'png');
delete(Fig);
end

