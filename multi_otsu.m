function thresholds = multi_otsu(img,levels)
% This is the implementation of fast multi-level otsu image implemented by
% TS Liao, TS Chen and PC Chung.
% Input: img is a image that needs to be segmented. levels is a single value
%  that defines the number of classes in the image.
% Output: thresholds is a array of threshold values.
%
% Author: Manjunath M (manjunath.bsk3@gmail.com)
if isa(img,'double')
    img = uint8(img);
end
img_hist = imhist(img); % Building histogram of the image.
p = zeros(256,256);
s = zeros(256,256);
h = zeros(256,256);
for i = 1:255
    p(1,i+1) = p(1,i) + img_hist(i+1);
    s(1,i+1) = s(1,i) + double(i+1)*img_hist(i+1);
end
for i = 2:256
    for j = i+1:256
        p(i,j) = p(1,j) - p(1,i-1);
        s(i,j) = s(1,j) - s(1,i-1);
    end
end
for i=1:256
    for j=i+1:256
        if p(i,j) ~= 0
            h(i,j) = s(i,j)*s(i,j) / p(i,j);
        else
            h(i,j) = 0;
        end
    end
end
clear p;
clear s;
max_sigma_b = 0;
switch levels
    case 1
        for i=1:256-2
            sigma_b = h(1,i) + h(i+1,256);
            if sigma_b > max_sigma_b
                max_sigma_b = sigma_b;
                thresholds = i;
            end
        end
    case 2
        for i=1:256-3
            for j=i+1:256-3+1
                sigma_b = h(1,i) + h(i+1,j) + h(j+1,256);
                if sigma_b > max_sigma_b
                    max_sigma_b = sigma_b;
                    thresholds = [ i j ];
                end
            end
        end
    case 3
        for i=1:256-4
            for j=i+1:256-4+1
                for k= j+1:256-4+2
                    sigma_b = h(1,i) + h(i+1,j) + h(j+1,k) + h(k+1,256);
                    if sigma_b > max_sigma_b
                        max_sigma_b = sigma_b;
                        thresholds = [ i j k ];
                    end
                end
            end
        end
    case 4
        for i=1:256-5
            for j=i+1:256-5+1
                for k=j+1:256-5+2
                    for m=k+1:256-5+3
                        sigma_b = h(1,i) + h(i+1,j) + h(j+1,k) + h(k+1,m) + h(m+1,255);
                        if sigma_b > max_sigma_b
                            thresholds = [i j k m];
                            max_sigma_b = sigma_b;
                        end
                    end
                end
            end
        end
end
end