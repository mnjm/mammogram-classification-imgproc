function [ img_o ] = remove_label( img_trimmed )
% Prototype ' [ img_o ] = remove_label( img_trimmed )
% This function is used to remove the label and other unwanted elements (except pectoral muscle) from the mammograms in the miniMIAS database
% input : img_trimmed is a image( already trimmed off black region )
% output : img_o is the resulting image.
%
% Author: Manjunath M (manjunath.bsk3@gmail.com)
[rows cols] = size(img_trimmed);
img_o = zeros(rows,cols);
for i = 1:rows/2
    j = 1;
    while(img_trimmed(i,j) > 16)
        img_o(i,j) = img_trimmed(i,j);
        j = j + 1;
        if j == cols
            break;
        end
    end
end
img_o(rows/2+1:end,:) = img_trimmed(rows/2+1:end,:);
if img_o(rows,cols) > 152
    for i= rows:-1:rows/2+1
        j = cols;
        while img_trimmed(i,j) > 16
            img_o(i,j) = 0;
            j = j - 1;
            if j == 1
                break
            end
        end
    end
end

