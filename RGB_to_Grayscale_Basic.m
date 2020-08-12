

i = imread('E:\BTP_4thSEM\apple.jpg');
i = imresize(i,[750 750]);
figure(1), imshow(i);
for k=1:750
    for l=1:750
        %a(k,l)=m*n;
        a(k,l) = (.299*i(k,l,1))+(.587*i(k,l,2))+(.114*i(k,l,3));
    end
end
figure(2), imshow(a);