im=imread('D:\Doaa_PHD\PHD2020\2nd paper\code\custom cnn48\jaffedbase - Copy\happiness\KA.HA2.30.tiff');
imgSize = size(im);

imgSize = imgSize(1:2);

channels = 1:32;
im = deepDreamImage(net1,'conv_2',channels, ...
    'PyramidLevels',1);

figure
im = imtile(im,'ThumbnailSize',[32 32]);
imshow(im)
title(['Layer ','conv_1',' Features'],'Interpreter','none')

act1 = activations(net1,im,'conv_2');
sz = size(act1);
act1 = reshape(act1,[sz(1) sz(2) 1 sz(3)]);
I = imtile(mat2gray(act1),'GridSize',[32 32]);
figure,imshow(I)
act1ch22 = act1(:,:,:,22);
act1ch22 = mat2gray(act1ch22);
act1ch22 = imresize(act1ch22,imgSize);

I = imtile({im,act1ch22});
figure,imshow(I)
[maxValue,maxValueIndex] = max(max(max(act1)));
act1chMax = act1(:,:,:,maxValueIndex);
act1chMax = mat2gray(act1chMax);
act1chMax = imresize(act1chMax,imgSize);

I = imtile({im,act1chMax});
figure,imshow(I)

act6 = activations(net1,im,'conv_2');
sz = size(act6);
act6 = reshape(act6,[sz(1) sz(2) 1 sz(3)]);

I = imtile(imresize(mat2gray(act6),[32 32]),'GridSize',[6 8]);
figure,imshow(I)

[maxValue6,maxValueIndex6] = max(max(max(act6)));
act6chMax = act6(:,:,:,maxValueIndex6);
figure,imshow(imresize(mat2gray(act6chMax),imgSize))

% I = imtile(imresize(mat2gray(act6(:,:,:,[14 47])),imgSize));
% figure,imshow(I)

