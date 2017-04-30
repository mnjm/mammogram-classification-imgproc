function res_img = remove_black_region( img_org )
% This function removes the black region in the miniMIAS mammograms
% Input: img is the Input image matrix
% Output: res_img is the resulting trimmed image, img_bin is the trimmed
%         binary image of the res_img
%
% Author: Manjunath M (manjunath.bsk3@gmail.com)
PSF = fspecial('gaussian',11,5);
img = imfilter(img_org,PSF,'conv');
t = multi_otsu(img,2);
img_bin = im2bw(img,min(t)/256);
pointsL = zeros(1,1024);
for i = 1:1024
    pointsL(i) = 1024;
end
pointsR = zeros(1,1024);
l = 1;
r = 1024;
for i = 1:1024
    while img_bin(i,l) == 0
        l = l + 1;
        if l == 1025
            break;
        end
    end
    while img_bin(i,r) == 0
        r = r - 1;
        if r == 0
            break;
        end
    end
    pointsL(i) = l;
    pointsR(i) = r;
    l = 1;
    r = 1024;
end
l = min(pointsL)+3;
r = max(pointsR)-3;
res_img = imcrop(img_org,[ l 1 r-l 10244 ]);
end