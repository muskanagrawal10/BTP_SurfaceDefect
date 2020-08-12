A = imread('E:\BTP_4thSEM\circle1.jpg');
figure(1), imshow(A);

A = rgb2gray(A);
A = edge(A, 'canny');
figure(2), imshow(A);
%Define the radius range.
Rmin = 10;
Rmax = 150;
[centersBright, radiiBright] = imfindcircles(A,[Rmin Rmax]);
viscircles(centersBright, radiiBright,'Color','b');
figure(3), imshow(A);
%Find all the bright circles in the image within the radius range.


%Find all the dark circles in the image within the radius range.
%[centersDark, radiiDark] = imfindcircles(A,[Rmin Rmax],'ObjectPolarity','dark');

%Draw blue lines around the edges of the bright circles.


%Draw red dashed lines around the edges of the dark circles.
%viscircles(centersDark, radiiDark,'LineStyle','--');
