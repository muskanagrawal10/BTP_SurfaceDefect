clc;
clear;
close all;
i = imread('C:\Users\user\Desktop\x.jpg');
I=rgb2gray(i);
bw=edge(I,'canny');
imshow(bw);
verticalProfile = sum(bw, 2); 
horizontalProfile = sum(bw, 1); 
figure(1), bar(horizontalProfile); 
figure(9), barh(verticalProfile);




binaryImage = edge(I,'canny');
figure(5), imshow(binaryImage);
%binaryImage = grayImage(:,:,1) > 200;
% Crop off huge white frame surrounding the image.
%binaryImage = binaryImage(46:1058, 1094:1295);
subplot(1, 2, 1);
imshow(binaryImage);
fontSize = 15;
title('Binary Image', 'FontSize', fontSize);

% Label each blob with 8-connectivity, so we can make measurements of it
[labeledImage, numberOfBlobs] = bwlabel(binaryImage, 8);
% Apply a variety of pseudo-colors to the regions.
coloredLabelsImage = label2rgb (labeledImage, 'hsv', 'k', 'shuffle');
% Display the pseudo-colored image.
subplot(1, 2, 2);
imshow(coloredLabelsImage);
title('Labeled Image', 'FontSize', fontSize);
impixelinfo
% Get all the blob properties.  Can only pass in originalImage in version R2008a and later.
blobMeasurements = regionprops(labeledImage, 'all');
numberOfBlobs = size(blobMeasurements, 1);



[Gx, Gy] = imgradientxy(binaryImage,'prewitt');
%Display the directional gradients.
%figure(4), imshow(Gx);
%figure(5), imshow(Gy);
figure(2), imshowpair(Gx, Gy, 'montage');
title('Directional Gradients: x-direction, Gx (left), y-direction, Gy (right), using Prewitt method')
[Gmag, Gdir] = imgradient(binaryImage,'prewitt');
%figure(6), imshow(Gmag);
%figure(7), imshow(Gdir);
figure(3), imshowpair(Gmag, Gdir, 'montage');
title('Gradient Magnitude, Gmag (left), and Gradient Direction, Gdir (right), using Prewitt method')


realImg = binaryImage;
[x, y] = size(binaryImage);

for i = 1:x
    for j = 1:y
        if(Gdir(i,j)~=0)
            count=0;
            if(i-1>0 && j-1>0 && i+1<x+1 && j+1<y+1 && Gdir(i-1,j-1)==0)
                count=count+1;
            end
            if(i-1>0 && j-1>0 && i+1<x+1 && j+1<y+1 && Gdir(i,j-1)==0)
                count=count+1;
            end
            if(i-1>0 && j-1>0 && i+1<x+1 && j+1<y+1 && Gdir(i+1,j-1)==0)
                count=count+1;
            end
            if(i-1>0 && j-1>0 && i+1<x+1 && j+1<y+1 && Gdir(i+1,j)==0)
                count=count+1;
            end
            if(i-1>0 && j-1>0 && i+1<x+1 && j+1<y+1 && Gdir(i+1,j+1)==0)
                count=count+1;
            end
            if(i-1>0 && j-1>0 && i+1<x+1 && j+1<y+1 && Gdir(i,j+1)==0)
                count=count+1;
            end
            if(i-1>0 && j-1>0 && i+1<x+1 && j+1<y+1 && Gdir(i-1,j+1)==0)
                count=count+1;
            end
            if(i-1>0 && j-1>0 && i+1<x+1 && j+1<y+1 && Gdir(i-1,j)==0)
                count=count+1;
            end
            if(i-1>0 && j-1>0 && i+1<x+1 && j+1<y+1 && count<4)
                binaryImage(i-1,j-1)=1;
                binaryImage(i,j-1)=1;
                binaryImage(i+1,j-1)=1;
                binaryImage(i+1,j)=1;
                binaryImage(i+1,j+1)=1;
                binaryImage(i,j+1)=1;
                binaryImage(i-1,j+1)=1; 
                binaryImage(i,j)=1;
                binaryImage(i-1,j)=1;
            end
        end
    end
end

figure(7), imshow(binaryImage);
figure(8), imshow(realImg);


    