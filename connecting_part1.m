clc;
i = imread('E:\BTP_4thSEM\realimg.png');
img=rgb2gray(i);
I=edge(img,'canny');
figure(1), imshow(I);
curve1=bwselect(I);
figure(3), imshow(I);
curve2 = bwselect(I);
figure(2), imshow(curve1);
figure(4), imshow(curve2);
[r,c]=find(curve1==1);
rc = [r,c];
[p,q]=find(curve2==1);
pq = [p,q];
%[m1,n1]=size(I);
%M = zeros(m1,n1);
%for m=1:m1
    %for n=1:n1-1
      %  if(BW(m,n) > M(m,n))
       %     i(m,n) = 10;
       % end
    %end
%end
%figure(2), imshow(BW);

