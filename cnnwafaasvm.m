%Accuracy 49.44% 20printer with 70 and 30 svm+full image  fc7 
%Accuracy 51.67% 20printer with 80 and 20 svm+full image fc7
%Accuracy 59.77% 20printer with 80 and 20 svm+full image fc6  and 51.11
%with 70% train

clc
close all
clear
%D:\Doaa_PHD\PHD2020\DataSets\ck\CK48وو D:\Doaa_PHD\PHD2020\DataSets\jaffedbase - Copy
images=imageDatastore('D:\Doaa_PHD\PHD2020\2nd paper\code\custom cnn48\jaffedbase - Copy','IncludeSubfolders',true,'LabelSource', 'foldernames');
tbl = countEachLabel(images)
images.ReadFcn = @(filename)readAndPreprocessImage(filename);

[trainingImages,testImages] = splitEachLabel(images, 0.7, 'randomize');
% numTrainImages = numel(trainingImages.Labels);%.
% numTestImages = numel(testImages.Labels);%.
%load('net1jaffee.mat')
load('net1.mat')
%load('net1ck.mat')
net =net1;
net.Layers;
%Extract Image Features
layer='fc';
  trainFeatures = activations(net,trainingImages,layer,'OutputAs','rows');
   trainLabels = trainingImages.Labels;
   %test feature
   testFeatures = activations(net,testImages,layer,'OutputAs','rows');
    testLabels = testImages.Labels;
    %svm 
    classifier = fitcecoc(trainFeatures,trainLabels);
    %BAgging
%     templ = templateTree('Reproducible',true);
%     classifier = fitcensemble(trainFeatures, trainLabels,'Method','Bag','NumLearningCycles',100,'Learners',templ); 
%Random Forest
%classifier = generic_random_forests(trainFeatures, trainLabels,100,'classification');
%Naive Base 
    %classifier = fitcnb(trainFeatures, trainLabels);
    %KNN
   %classifier = fitcknn(trainFeatures, trainLabels);
    predictedLabels = predict(classifier,testFeatures);
    %accuracy = mean(predictedLabels == testLabels);
    accuracy = sum(predictedLabels == testLabels)/numel(testLabels);
confMat = confusionmat(predictedLabels,testLabels)
% Convert confusion matrix into percentage form
confMat = bsxfun(@rdivide,confMat,sum(confMat,2))
% Display the mean accuracy
mean(diag(confMat))
figure, plotconfusion(predictedLabels,testLabels);
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
  %       fim=mat2gray(Iout);
 %   Iout=localnormalize(fim,4,5);%90
%         Iout=localnormalize(fim,4,4);
%         Iout=mat2gray(Iout);
        %Iout=imadjust(Iout,[0 .7],[],1.7);  
        Iout=histeq(Iout);
        Iout=imadjust(Iout,[],[],1.7);   
      
        %Iout = edge(Iout,'sobel');
      %  Iout=im2bw(Iout,.5);
      %  Iout=imgaussfilt(Iout,15);
        %Iout = globalContrastFactor(Iout);             `
        %Iout=BHPF( Iout,15,2);

%   
%             if ismatrix(Iout)
%             Iout = cat(3,Iout,Iout,Iout);
%         end
      Iout = imresize(Iout, [48 48]);
          end