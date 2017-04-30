function out_img = remove_pectoral_muscle( img )
% img = remove_pectoral_muscle( img )
% Input: 'img' is a mammogram image with the pectoral muscle on the top left side of the image with no labels.
% Output: 'out_img' is a mammogram image without pectoral muscle.
% This function uses Canny Edge detection and Nonlinear Regression methods to identify the pectoral muscle and removes it.
%
% Author: Manjunath M (manjunath.bsk3@gmail.com)
% 
% The dataset used in this program is MiniMIAS data collections.
    old_img = img;
    t = multi_otsu(img,1);
    t = t/775.0;
    t = [0.6*t t];
    edges = edge(img,'canny',t,25);
    figure; imshow(edges); title('Canny Output');
    [row col] = size(edges);
    loc = zeros(row/2,1);
    loc_dif = zeros(row/2,1);
    for i = 1:(row/2)
        j = 1;
        while j<col
            if edges(i,j) == 1
                loc(i) = j;
                break
            end
            j=j+1;
        end
        if i ~= 1
            loc_dif(i) = loc(i-1) - loc(i);
        end
    end
    indx = 0;
    i = 1;
    while i<=(row/2)
        j = i;
        while  j<=(row/2) && loc_dif(j)>=0 && loc_dif(j)<=2
            j = j + 1;
        end
        if i~=j
            indx = indx + 1;
            index(indx) = i;
            count(indx) = j-i;
        end
        i = j + 1;
    end
    indx = find(count == max(count));
    start = index(indx);
    end_ = count(indx) + start - 2;
    figure;
    subplot(1,2,1);
    plot(loc); title('Location');
    subplot(1,2,2);
    loc = loc(start:end_);
    plot((start:end_)',loc); title('Cropped Location');
    figure; plot(loc_dif); title('Difference Matrix Plot');
    function_ = fit((start:end_)',loc,'power2');
    indexs = uint16(function_(1:row));
    for i = 1:row
        if indexs(i) > col
            indexs(i) = col;
        end
        for j = 1:indexs(i)
            img(i,j) = 0;
        end
    end
    figure;
    subplot(1,2,1);imshow(old_img,[]);title('Original Image');
    out_img = img;
end