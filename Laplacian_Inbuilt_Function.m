i = imread('E:\BTP_4thSEM\apple.jpg');
I = rgb2gray(i);

lab4=[0 1 0; 1 -4 1; 0 1 0];
lab8=[-1 -1 -1; -1 8 -1; -1 -1 -1];
result8=uint8(filter2(lab8, I, 'same'));
result4=uint8(filter2(lab4, I, 'same'));
%subplot(1,2,1);
figure(1), imshow(I);
%subplot(1,2,2);
figure (8), imshow(result8);

figure(4), imshow(result4);



