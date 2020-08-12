I = imread('E:\BTP_4thSEM\realimg.png');
I = rgb2gray(I);
BW=edge(I,'canny');
figure(2),imshow(BW);
%Create a vertical line shaped structuring element.

se = strel('line',5,75);
%Dilate the image with a vertical line structuring element and compare the results.

BW2 = imdilate(BW,se);
imshow(BW), title('Original')
figure, imshow(BW2), title('Dilated')