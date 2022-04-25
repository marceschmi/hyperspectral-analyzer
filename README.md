%--------------------------------------------------------------------------
% Copyright (c) 2022 Marcel Schmidt
% Permission is hereby granted, free of charge, to any person obtaining a
% copy of this software and associated documentation files
% (the "Software"), to deal in the Software without restriction, including
% without limitation the rights to use, copy, modify, merge, publish,
% distribute, sublicense, and/or sell copies of the Software, and to permit
% persons to whom the Software is furnished to do so, subject to the
% following conditions: 

% The above copyright notice and this permission notice shall be included
% in all copies or substantial portions of the Software. 

% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
% OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
% MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
% IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
% CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
% TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
% SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
%--------------------------------------------------------------------------

# hyperspectral analysis
 A programme to visualise and analyse hyperspetral data.

##############################################################
#-----------------------Used Toolboxes-----------------------#
##############################################################

- Parallel Computing Toolbox
- Curve Fitting Toolbox
- Mapping Toolbox
- Optimization Toolbox
- Statistics and Machine Learning Toolbox
- Image Processing Toolbox

##############################################################
#-----------------------Used functions-----------------------#
##############################################################
For full functionality, the following functions must be downloaded:
- mat2clip v.1.1 by Jiro Doke (https://de.mathworks.com/matlabcentral/fileexchange/8559-mat2clip?s_tid=srchtitle)
- copyUIAxes v. 3.0 by Adam Danz (https://de.mathworks.com/matlabcentral/fileexchange/73103-copyuiaxes?s_tid=srchtitle) 

##############################################################
#-------------------How to use the import--------------------#
##############################################################

What the program does:

Auto Pl:
- searches for the folder "converted data" in all subdirectories
- generates a list of .txt files from each "converted data" folder
- sorts the files by date
- deletes all files smaller than the min_file_size from the lister 
(see settings)
- takes the wavelength values from the largest file
- generates data tensors by date (from old to new - if positions
are repeated, they are assumed to be a new temperature index in
a new tensors)
