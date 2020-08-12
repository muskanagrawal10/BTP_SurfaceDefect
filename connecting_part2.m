clc;
i = imread('E:\BTP_4thSEM\realimg.png');
img=rgb2gray(i);
I=edge(img,'canny');

nG = 1;
X0 = 634;
Y0 = 99;
X1 = 636;
Y1 = 94;
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


figure(2), imshow(I);
