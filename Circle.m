clear all;
clc;
A = imread('E:\BTP_4thSEM\realimg.png');
figure(1), imshow(A);
I = rgb2gray(A);

%Define the radius range.
Rmin = 30;
Rmax = 65;

%Find all the bright circles in the image within the radius range.
[centersBright, radiiBright] = imfindcircles(I,[Rmin Rmax],'ObjectPolarity','bright');

%Find all the dark circles in the image within the radius range.
[centersDark, radiiDark] = imfindcircles(I,[Rmin Rmax],'ObjectPolarity','dark');
%figure(3), imshow(I);
%Draw blue lines around the edges of the bright circles.
viscircles(centersBright, radiiBright,'Color','b');

%Draw red dashed lines around the edges of the dark circles.
viscircles(centersDark, radiiDark,'LineStyle','--');

figure(2), imshow(A);