clc;
i = imread('E:\BTP_4thSEM\realimg.png');
img=rgb2gray(i);
I=edge(img,'canny');
figure(1), imshow(I);
BW=bwselect(I);
[r,c]=find(BW==1);
rc = [r,c];
[m1,n1]=size(I);
M = zeros(m1,n1);
for m=1:m1
    for n=1:n1-1
        if(BW(m,n) > M(m,n))
            i(m,n) = 10;
        end
    end
end
figure(2), imshow(BW);
