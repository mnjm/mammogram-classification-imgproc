function [ img_o ] = gaussian_blurr( img, l ,s )
% Prototype: [ img_o ] = gaussian_blurr( img, l ,s )
% Performs the Gaussian Blurr to the given image.
% Input:   img is the input image matrix.
%          l is the kernel length (The kernel length is lxl)
%          s is the sigma value that is applied to generate kernel values.
% Output:  img_o is the blurred image.
%
% Author: Manjunath M (manjunath.bsk3@gmail.com)
    if nargin == 1
        l = 11;
        s = 5;
    end
    PSF = fspecial('gaussian',l,s);
    img_o = imfilter(img,PSF,'conv');
end

