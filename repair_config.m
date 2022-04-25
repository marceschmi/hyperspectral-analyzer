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
clc
clear all
close all

load('config.mat')

config.x = 38;
config.y = 38;
config.color_steps = 100;
config.path = 'C:\Users\marce\sciebo\PHD/';
config.window_size_data = 20;
config.window_size_1diff = 20;
config.delta_position = 1;
config.delta_height = 10;
config.delta_FWHM = 0.02;
config.min_file_size = 4000;
config.contour_lines = 5;

save_data = 'I:\Sciebo\Sciebo_data\PHD\Programme\Matlab_Programme_new\PL_Programm\AFP_analyse_7_6/';
save(fullfile(save_data, 'config.mat'), 'config')