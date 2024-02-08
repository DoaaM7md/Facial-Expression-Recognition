

%-----------------------------------------------------------------------------------------------------------------------------------
% Read in image.
function I=alphacrop(I);
I=imresize(I, [256 256]);
[rows, columns, numberOfColorChannels] = size(I);
% Display the image.

% x1=132.204180064309	;
% y1=133.438906752412;
% x2=171.715434083601	;
% y2=133.438906752412;
x1=120.204180064309	;
y1=132.438906752412;
x2=165.715434083601	;
y2=130.438906752412;

% Get alpha as delta x
alpha = abs(x2-x1);
%**************************
% % Get the top row:
% topRow = round(min([y2,y1]) - alpha * 1.3);
% % Get the bottom row:
% bottomRow = round(max([y2,y1]) + alpha * 3);
% % Get the left column:
% xLeft = min([x2,x1]); % Point on the bridge of the nose.
% leftColumn = round(xLeft - alpha * 1.2);
% % Get the right column:
% rightColumn = round(xLeft + alpha * 1.2);
% Get the top row:
topRow = round(min([y2,y1]) - alpha * .8);
%imshow(topRow);
% Get the bottom row:
bottomRow = round(max([y2,y1]) + alpha * 2.0);
% Get the left column:
xLeft = min([x2,x1]); % Point on the bridge of the nose.
leftColumn = round(xLeft - alpha * 1.0);
% Get the right column:
rightColumn = round(xLeft + alpha * 1.5);
%**************************

r = [leftColumn, topRow, rightColumn - leftColumn, bottomRow - topRow];
%r = [leftColumn, topRow, rightColumn - leftColumn,  topRow];
%rectangle('Position', r, 'EdgeColor', 'r', 'LineWidth', 2)
% Crop the image
I = imcrop(I, r);
%imshow(I);
