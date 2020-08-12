I=imread('E:\BTP_4thSEM\apple.jpg');
   R=rgb2gray(I); % It is gray now
   y=colormap(hot(110));
   imwrite(R,y,'rgb.jpg','jpg'); % Re-change it to colored one 
   imshow('rgb.jpg');