i = imread('E:\BTP_4thSEM\Curve.jpg');
figure(4), imshow(i);
I = rgb2gray(i);
figure(1), imshow(I);
%Calculate the x- and y-directional gradients using the Prewitt gradient operator. 
[Gx, Gy] = imgradientxy(I,'prewitt');
%Display the directional gradients.
%figure(4), imshow(Gx);
%figure(5), imshow(Gy);
figure(2), imshowpair(Gx, Gy, 'montage');
title('Directional Gradients: x-direction, Gx (left), y-direction, Gy (right), using Prewitt method')
[Gmag, Gdir] = imgradient(I,'prewitt');
%figure(6), imshow(Gmag);
%figure(7), imshow(Gdir);
figure(3), imshowpair(Gmag, Gdir, 'montage');
title('Gradient Magnitude, Gmag (left), and Gradient Direction, Gdir (right), using Prewitt method')