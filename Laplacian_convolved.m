i = imread('E:\BTP_4thSEM\apple.jpg');
I = rgb2gray(i);

[r c]=size(I);
a=im2double(I);
filter=[0 1 0;1 -4 1; 0 1 0];
filter1=[-1 -1 -1;-1 8 -1;-1 -1 -1];

result=a;
for i=2:r-1
    for j=2:c-1
        sum=0;
        row=0;
        col=1;
        
        for k=i-1:i+1
            row=row+1;
            col=1;
            for l=j-1:j+1
                sum = sum+a(k,l)*filter(row,col);               
                col=col+1;
            end
        end
      result(i,j)=sum;      
    end
end
figure(2),imshow(result);
title('2nd derivative with filter');

[r c]=size(I);
a=im2double(I);
filter=[0 2 2;-2 0 2; -2 -2 0];
result1=a;
for i=2:r-1
    for j=2:c-1
        sum=0;
        row=0;
        col=1;
        
        for k=i-1:i+1
            row=row+1;
            col=1;
            for l=j-1:j+1
                sum = sum+a(k,l)*filter1(row,col);               
                col=col+1;
            end
        end
      result1(i,j)=sum;      
    end
end

figure(3),imshow(result1);
title('2nd derivative with filter1');