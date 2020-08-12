clc;
i = imread('E:\BTP_4thSEM\realimg.png');
I = rgb2gray(i);
binaryImage = edge(I,'canny');
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