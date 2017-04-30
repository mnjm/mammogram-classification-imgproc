function img_blurr = mean_blurr( img ) 
    k = ones(3,3);
    [rows,cols,type] = size(img);
    if type ~= 1
        img = rgb2gray(img);
    end
    img_blurr = double(zeros(rows,cols));
    win = zeros(3,3);
    for i = 2:rows-1
        for j = 2:cols-1
            win = double([ img(i-1,j-1),img(i-1,j),img(i-1,j+1);img(i,j-1),img(i,j),img(i,j+1);img(i+1,j-1),img(i+1,j),img(i+1,j+1)]);
            win = win.*k;
            img_blurr(i,j) = sum(sum(win))/9;
        end
    end
end

