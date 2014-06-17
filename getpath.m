function [path] = getpath(nKeyFrames)
%GETPATH Asks the user to draw a path for the camera. 

path = zeros(nKeyFrames,3);

f = figure;
hold on;
axis([0 100 0 100]);



for i = 1:nKeyFrames
    clc;
    display(i);
    display(nKeyFrames);
    [x,z] = ginput(1);
    plot(x,z,'ro');
    path(i,:) = [x 0 z];
end




%Normalises the path so that the first keyframe is at [0 0 0]
offset = path(1,:);
for i = 1:nKeyFrames
    path(i,:) = path(i,:) - offset;
end


close(f);




end

