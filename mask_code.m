clc;
i = imread('E:\BTP_4thSEM\realimg.png');
i = rgb2gray(i);
I = edge(i,'canny');
imshow(I);
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
imwrite(F,'line.jpg')