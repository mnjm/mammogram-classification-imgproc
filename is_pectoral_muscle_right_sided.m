function [ is_right_sided ] = is_pectoral_muscle_right_sided( img_org )
% This function outputs the direction of the image
% Input: Enhanced Mammogram Image 'img' (Trimmed)
% Output: isRightSided--> bool , if isRightSided == true then in the Mammogram
% the pectoral muscle is in right side otherwise left.
%
% Author: Manjunath M (manjunath.bsk3@gmail.com)
    [~, c] = size(img_org);
    right_mean = mean(mean(img_org(1:256,uint32(0.5*c):c)));
    left_mean = mean(mean(img_org(1:256,1:uint32(0.5*c))));
    if right_mean > left_mean
        is_right_sided = true;
    else
        is_right_sided = false;
    end
end

