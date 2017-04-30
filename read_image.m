function [ img no ]=read_image(no)
% This function reads the Mammogram from the location in the local variable
% 'loc' and a number is read as input or argument from the user. The
% filename format is 'mdb' + 3 digit number + '.pgm'.
% Input: 'no' is a number that is used to contruct the filename string.
% Output: img is the image in the location.
%         no is the number read as the input.
% Author: Manjunath M (manjunath.bsk3@gmail.com)
if nargin == 0
    no=input('Enter the number:');
end
clear filename
if no>99
    filename=int2str(no);
elseif no>9
    filename=[ '0' int2str(no) ];
else
    filename=[ '00' int2str(no) ];
end
if nargout == 1
    img=imread(['D:\MATLAB Workspace\Dataset\Mammograms\mdb' filename '.pgm']);
else
    img=imread(['D:\MATLAB Workspace\Dataset\Mammograms\mdb' filename '.pgm']);
end