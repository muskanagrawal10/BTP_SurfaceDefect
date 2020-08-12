i = imread('E:\BTP_4thSEM\Broken_line1.jpg');
%figure(0), imshow(i);
I = rgb2gray(i)
figure(1),imshow(I);
[m1,n1]=size(I);
t=50;
T=-50;
M = zeros(m1,n1);
p= zeros(m1,n1)
        for m = 1:m1
            for n = 1:n1-1
               if(I(m,n)>I(m,n+1))
                p(m,n)=I(m,n)-I(m,n+1);
               else
                   p(m,n)=I(m,n+1)-I(m,n);
               end
               if(p(m,n)>t)
                  M(m,n)=50;
               else
                   M(m,n)=I(m,n);
               end
            end
        end
        for m= 1:m1
            for n= 1:n1-1
                if(M(m,n)==50)
                    %M(m-2,n)=50;
                    M(m-1,n)=50;
                    %M(m,n-2)=50;
                    M(m,n-1)=50;
                end
            end
        end
        

   y=colormap(hot(110));
   imwrite(M,y,'rgb.jpg','jpg'); % Re-change it to colored one 
   figure(2), imshow('rgb.jpg');