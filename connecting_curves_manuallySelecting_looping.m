clc;
clear;
close all;
i = imread('E:\BTP_4thSEM\realimg.png');
img=rgb2gray(i);
I=edge(img,'canny');

for j = 1:2
    
figure(1), imshow(I);
aboveCurve=bwselect(I);
figure(2), imshow(aboveCurve);
figure(3), imshow(I);
lowerCurve = bwselect(I);
figure(4), imshow(lowerCurve);
[r,c]=find(aboveCurve==1);
rc = [r,c];
[p,q]=find(lowerCurve==1);
pq = [p,q];
%min1=rc(1,1);
req1_x=rc(1,1);
req1_y=rc(1,2);;
[r1,c1]=size(rc);
for i = 2:r1;
    if(rc(i,1)>req1_x)
       req1_x=rc(i,1);
       req1_y=rc(i,2);
    elseif(rc(i,1)==req1_x)
        if(req1_y>rc(i,2))
            req1_y=rc(i,2);
        end
    end
end

req2_x=pq(1,1);
req2_y=pq(1,2);
[r2,c2]=size(pq);

for i = 2:r2
    if(req2_x>pq(i,1))
        req2_x=pq(i,1);
        req2_y=pq(i,2);
    elseif(req2_x==pq(i,1))
        if(req2_y>pq(i,2))
            req2_y=pq(i,2);
        end
    end
end


nG = 1;
X0 = req1_x;
Y0 = req1_y;
X1 = req2_x;
Y1 = req2_y;
I(X0, Y0) = nG;
I(X1, Y1) = nG;
if abs(X1 - X0) <= abs(Y1 - Y0)
   if Y1 < Y0
      k = X1; X1 = X0; X0 = k;
      k = Y1; Y1 = Y0; Y0 = k;
   end
   if (X1 >= X0) & (Y1 >= Y0)
      dy = Y1-Y0; dx = X1-X0;
      p = 2*dx; n = 2*dy - 2*dx; tn = dy;
      while (Y0 < Y1)
         if tn >= 0
            tn = tn - p;
         else
            tn = tn + n; X0 = X0 + 1;
         end
         Y0 = Y0 + 1; I(X0, Y0) = nG;
      end
   else
      dy = Y1 - Y0; dx = X1 - X0;
      p = -2*dx; n = 2*dy + 2*dx; tn = dy;
      while (Y0 <= Y1)
         if tn >= 0
            tn = tn - p;
         else
            tn = tn + n; X0 = X0 - 1;
         end
         Y0 = Y0 + 1; I(X0, Y0) = nG;
      end
   end
else if X1 < X0
      k = X1; X1 = X0; X0 = k;
      k = Y1; Y1 = Y0; Y0 = k;
   end
   if (X1 >= X0) & (Y1 >= Y0)
      dy = Y1 - Y0; dx = X1 - X0;
      p = 2*dy; n = 2*dx-2*dy; tn = dx;
      while (X0 < X1)
         if tn >= 0
            tn = tn - p;
         else
            tn = tn + n; Y0 = Y0 + 1;
         end
         X0 = X0 + 1; I(X0, Y0) = nG;
      end
   else
      dy = Y1 - Y0; dx = X1 - X0;
      p = -2*dy; n = 2*dy + 2*dx; tn = dx;
      while (X0 < X1)
         if tn >= 0
            tn = tn - p;
         else
            tn = tn + n; Y0 = Y0 - 1;
         end
         X0 = X0 + 1; I(X0, Y0) = nG;
      end
   end
end

end
figure(5), imshow(I);


