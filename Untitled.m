
% Demo by Image Analyst.
clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clearvars;
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 16;
fprintf('Beginning to run %s.m ...\n', mfilename);
%-----------------------------------------------------------------------------------------------------------------------------------
% Read in image.
folder = [];
baseFileName = 'D:\Doaa_PHD\PHD2020\2nd paper\code\custom cnn48\jaffedbase - Copy\happiness\KA.HA2.30.tiff';
%baseFileName=imresize(baseFileName, [256 256]);
fullFileName = fullfile(folder, baseFileName);
% Check if file exists.
if ~exist(fullFileName, 'file')
    % The file doesn't exist -- didn't find it there in that folder.
    % Check the entire search path (other folders) for the file by stripping off the folder.
    fullFileNameOnSearchPath = baseFileName; % No path this time.
    if ~exist(fullFileNameOnSearchPath, 'file')
        % Still didn't find it.  Alert user.
        errorMessage = sprintf('Error: %s does not exist in the search path folders.', fullFileName);
        uiwait(warndlg(errorMessage));
        return;
    end
end
rgbImage = imread(fullFileName);
[rows, columns, numberOfColorChannels] = size(rgbImage)
% Display the image.
subplot(2, 1, 1);
imshow(rgbImage, []);
axis('on', 'image');
hp = impixelinfo(); % Set up status line to see values when you mouse over the image.
caption = sprintf('Original RGB Image : "%s"\n%d rows by %d columns', baseFileName, rows, columns);
title(caption, 'FontSize', fontSize, 'Interpreter', 'None');
drawnow;
hp = impixelinfo(); % Set up status line to see values when you mouse over the image.
% Set up figure properties:
% Enlarge figure to full screen.
hFig1 = gcf;
hFig1.Units = 'Normalized';
hFig1.WindowState = 'maximized';
% Get rid of tool bar and pulldown menus that are along top of figure.
% set(gcf, 'Toolbar', 'none', 'Menu', 'none');
% Give a name to the title bar.
hFig1.Name = 'Demo by Image Analyst';
% Ask user to draw the line.
promptMessage = sprintf('Draw the line');
titleBarCaption = 'Continue?';
buttonText = questdlg(promptMessage, titleBarCaption, 'Continue', 'Quit', 'Continue');
if contains(buttonText, 'Quit', 'IgnoreCase', true)
    return; % or break or continue.
end
roi = drawline()
position = roi.Position
x1 = position(1,1)
y1 = position(1,2)
x2 = position(2,1)
y2 = position(2,2)
% Get alpha as delta x
alpha = abs(x2-x1)
% Get the top row:
topRow = round(min([y2,y1]) - alpha * 1.3)
% Get the bottom row:
bottomRow = round(max([y2,y1]) + alpha * 3.2)
% Get the left column:
xLeft = min([x2,x1]); % Point on the bridge of the nose.
leftColumn = round(xLeft - alpha * 1.2)
% Get the right column:
rightColumn = round(xLeft + alpha * 1.2)
% Put up the bounding box
hold on;
r = [leftColumn, topRow, rightColumn - leftColumn, bottomRow - topRow]
rectangle('Position', r, 'EdgeColor', 'r', 'LineWidth', 2)
% Crop the image
croppedImage = imcrop(rgbImage, r);
% Display the mask image.
subplot(2, 1, 2);
imshow(croppedImage, []);
axis('on', 'image');
hp = impixelinfo(); % Set up status line to see values when you mouse over the image.
title('Cropped Image', 'FontSize', fontSize, 'Interpreter', 'None');
drawnow;
msgbox('Done!');