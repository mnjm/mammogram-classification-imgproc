main
t = multi_otsu(img,1);
t = t/775.0;
t = [0.6*t t];
edges = edge(img,'canny',t,25);
subplot(1,2,1);
imshow(img,[]);
subplot(1,2,2);
imshow(edges);