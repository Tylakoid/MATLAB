
% Code to measure width and length of torch beam
clear all
close all
clc

%% Load the mock image file (if you don't have images acquired from camera.
% Comment out this line if you have images acquired from the camera in your
% workspace
load('Ten_images_mock.mat');

%% Extract a single frame from the 4-D image matrix and display
I = M(:,:,1,1);
% display the single image frame
figure
imagesc(I)
axis image
colormap gray

%% use getpts to select 2 points on selected image to find width of torch beam in pixels
 disp('getpts is requesting for input to measure width of torch beam.')
 disp('Use normal button clicks to add points.  A double-click adds a final point and ends the selection.')  
 disp('Pressing RETURN or ENTER ends the selection without adding a final point.')
 disp('Pressing BACKSPACE or DELETE removes the previously selected point.')
 disp('Coordinates of the selected points are returned in the vectors X and Y.') 
[x,y] = getpts;
hold on;
plot(x,y, 'r+', 'MarkerSize', 15);

% find width of torch beam, in pixels 
width_of_torch_beam_pixels = abs(x(2)-x(1))
 
%% use getpts to select 2 points on selected image to find length of torch beam in pixels
 disp('getpts is requesting for input to measure length of torch beam.')
[x1,y1] = getpts;
hold on;
plot(x1,y1, 'b+', 'MarkerSize', 15);
 
 % find length of torch beam, in pixels 
length_of_torch_beam_pixels = abs(y1(2)-y1(1))
 
