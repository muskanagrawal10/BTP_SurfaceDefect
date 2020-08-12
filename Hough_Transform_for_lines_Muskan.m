clear all;
clc;
%Input image
img = imread ('E:\BTP_4thSEM\10.jpg');
%figure(1), imshow(img);
% rgb to gray
I = rgb2gray(img);
%figure(2), imshow(I);
% detectig the edges of the iage by canny edge detection
BW = edge(I,'canny');
%figure(3), imshow(BW);
%[H,theta,rho] = hough(BW) computes the Standard Hough Transform (SHT) of the binary image BW. 
%The hough function is designed to detect lines. The function uses the parametric representation 
%of a line: rho = x*cos(theta) + y*sin(theta). The function returns rho, the distance from the 
%origin to the line along a vector perpendicular to the line, and theta, the angle in degrees 
%between the x-axis and this vector. The function also returns the Standard Hough Transform, H, 
%which is a parameter space matrix whose rows and columns correspond to rho and theta values 
%respectively.

[H,theta,rho] = hough(BW);
%figure(4), imshow(imadjust(rescale(H)),[],'XData',theta,'YData',rho,'InitialMagnification','fit');
xlabel('\theta (degrees)')
ylabel('\rho')
axis on
axis normal 
hold on
colormap(gca,hot)
P = houghpeaks(H,130,'threshold',ceil(0.3*max(H(:))));
x = theta(P(:,2));
y = rho(P(:,1));
plot(x,y,'s','color','black');
lines = houghlines(BW,theta,rho,P,'FillGap',5,'MinLength',7);
%figure(5), imshow(I), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end
% highlight the longest line segment
%plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','green');