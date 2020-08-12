clc;
I = imread('E:\BTP_4thSEM\realimg.png');
i = rgb2gray(I);
x = edge(i,'canny');
imshow(x);
for i=1:1 %can say 1:x and the xth drawing will be saved as mask
M = imfreehand(gca,'Closed',0);
end
F = false(size(M.createMask));
P0 = M.getPosition;
   D = round([0; cumsum(sum(abs(diff(P0)),2))]); 
P = interp1(D,P0,D(1):.5:D(end)); % ...to close the gaps
P = unique(round(P),'rows');
S = sub2ind(size(I),P(:,2),P(:,1));
F(S) = true;
figure;
imshow(F);

montage({I,F});
title(['Image to Be Inpainted','   |   ','Mask for Inpainting'])

J = inpaintExemplar(I,F,'FillOrder','tensor','PatchSize',7);
%y = rgb2gray(J);
%z = edge(y,'canny');
figure(1), imshow(J);
X = rgb2gray(J);
X = edge(X, 'canny');
figure(3), imshow(X);
figure(4), imshow(x);