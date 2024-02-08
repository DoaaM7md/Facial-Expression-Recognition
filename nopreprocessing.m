%D:\Fer       D:\Doaa_PHD\PHD2020\DataSets\jaffedbase - Copy   D:\Doaa_PHD\PHD2020\DataSets\ck\CK48
clear
clc
imds_f=imageDatastore('D:\Doaa_PHD\PHD2020\DataSets\jaffedbase - Copy','IncludeSubfolders',true,'LabelSource', 'foldernames')
imds_f.ReadFcn = @(filename)readAndPreprocessImage(filename);

%% Create training and validation sets
[imdsTrain,imdstest] = splitEachLabel(imds_f,0.7,'randomized');

% Specify the convolutional neural network architecture.
layers = [
      imageInputLayer([48 48])
%     convolution2dLayer(3,8,"Padding","same")
%     batchNormalizationLayer
%     reluLayer
%     maxPooling2dLayer(2,"Stride",2)
%     convolution2dLayer(3,16,"Padding","same")
%     batchNormalizationLayer
%     reluLayer
%     maxPooling2dLayer(2,"Stride",2)
%     
  convolution2dLayer(5,32,"Padding","same")
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,"Stride",2)
    convolution2dLayer(3,32,"Padding","same")
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,"Stride",2)
    convolution2dLayer(3,64,"Padding","same")
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,"Stride",2)
       convolution2dLayer(3,64,"Padding","same")
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,"Stride",2)
 convolution2dLayer(3,128,"Padding","same")
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,"Stride",2)
    convolution2dLayer(3,256,"Padding","same")
    batchNormalizationLayer
    reluLayer
    fullyConnectedLayer(7)
    softmaxLayer
    classificationLayer];

%% Specify training options 
options = trainingOptions('adam', ...
    'MiniBatchSize',128, ...
    'MaxEpochs',100, ...
    'InitialLearnRate',.01, ...
    'Shuffle','every-epoch', ...
    'ValidationData',imdstest, ...
    'ValidationFrequency',30, ...
    'Verbose',false, ...
    'Plots','training-progress');

%% Train the network
net1 = trainNetwork(imdsTrain,layers,options);
%save('fff',net1);
%% Report accuracy of baseline classifier on validation set
YPred = classify(net1,imdstest);
YTest = imdstest.Labels;
%%%%%%%%%%%SVM%%%%%%%%%%%%%%%%%%
% YPred = fitcecoc(imdsTrain,YValidation);
% YValidation = predict(YPred,imdsTrain);

imdsAccuracy = sum(YPred == YTest)/numel(YTest);
%imdsAccuracy=(nnz(Yperd==YValidation)/length(YValidation))*100;
%% Plot confusion matrix
figure, plotconfusion(YTest,YPred)


% newImage = imread('C:\Users\Doaa\Desktop\happiness.jpg');
% newImage = newImage(:,:,1);
%  img = readAndPreprocessImage(newImage);
  %imageFeatures = activations(net, img, layer);
%    new=classify(net1,img);
%   label= predict(featuresTrain, imageFeatures);
% 
%   figure
%  imshow(img)
%  title(char(label))

function Iout = readAndPreprocessImage(filename)
        Iout = imread(filename); 
%         faceDetector = vision.CascadeObjectDetector;  
%         bboxes = faceDetector(Iout);
%              z=double(zeros(0,4));
%              tf = isequal(bboxes,z);
%                 if tf==1
%                   bboxes=[28 23 173 173];
%                 end
%       Iout = insertObjectAnnotation(Iout,'rectangle',bboxes,'Face'); 
%     Iout = imcrop(Iout, bboxes);
        Iout=alphacrop(Iout);
       % Iout=im2bw(Iout,.4);
%         fim=mat2gray(Iout);
 %        Iout=localnormalize(fim,4,5);%90
%         Iout=localnormalize(fim,4,4);
%         Iout=mat2gray(Iout);
        %Iout=imadjust(Iout,[0 .7],[],1.7);
        
         Iout=histeq(Iout);
        Iout=imadjust(Iout,[],[],1.7);
%         mask=[1 1 1;1 1 1;1 1 1];
%         Iout=filter2(mask,Iout);
%         Iout=Iout/255;
                %Iout=im2bw(Iout,.5);
    %    Iout=imgaussfilt(Iout,15);
        %Iout = globalContrastFactor(Iout);             `
        %Iout=BHPF( Iout,15,2);

%   
%              if ismatrix(Iout)
%              Iout = cat(3,Iout,Iout,Iout);
%         end
   %130*114
Iout = imresize(Iout, [48 48]);
          end