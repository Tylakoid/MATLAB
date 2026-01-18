%Displaying each of the frames in Image Analysis
%
clc
close all
clear
%
load ('Ten_images_mock.mat');

%Display frames with a pause of 0.5 seconds between frames
figure;
for k = 1:1:10
    imagesc(M(:,:,1,k))
    colormap gray;
    axis image
    title(['Image frame', num2str(k)]); pause(0.5);
end;
%num2str converts the number to a string so we can put it in the title as a
%graph heading. 


