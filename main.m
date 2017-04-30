warning off
%clear all;
clc; close all;
%[img,img_no] = read_image(img_no+1);
[img,img_no] = read_image();
img_trimmed = remove_black_region(img);
%clear img;
if is_pectoral_muscle_right_sided(img_trimmed)
    img_trimmed = fliplr(img_trimmed); % Extracts the mirror of the image and save it under 'img_trimmed'. The pectoral muscle will be on the top left side
end
img = remove_label(img_trimmed); % Removes the labels and other noise in the image.
img = remove_pectoral_muscle(img);
subplot(1,2,2);imshow(img,[]); title(['Cropped Image ' int2str(img_no)]);