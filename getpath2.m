function [path] = getpath2(nKeyFrames)
%GETPATH Asks the user to draw a path for the camera. 

path = zeros(nKeyFrames,3);

f = figure;
hold on;
axis([0 300 0 300]);



f = figure;
axis([0 100 0 100]);
h = imfreehand('Closed',false);

pos = getPosition(h);
close all;

path = [pos(1:nKeyFrames,1) zeros(nKeyFrames,1) pos(1:nKeyFrames,2)];


%Normalises the path so that the first keyframe is at [0 0 0]
offset = path(1,:);
for i = 1:nKeyFrames
    path(i,:) = path(i,:) - offset;
end







end

