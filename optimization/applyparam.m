function [outPTAM] = applyparam(PTAM, pointList, camList, param)
%APPLYPARAM Summary of this function goes here
%   Detailed explanation goes here

% ncameras = size(PTAM.KeyFrames,2);
npoints = size(pointList,2);

for i = 1:npoints
    index = pointList(i);
    rows = 3*(i-1) + 1:3*(i-1) + 3;
    PTAM.Map.points(index).location(1:3) = PTAM.Map.points(index).location(1:3) + param(rows);
end

if (~isempty(camList))
    
    for j = 1:size(camList,2);
        
        index = pointList(j);
        rows = 3*npoints + 6*(j-1) + 1 : 3*npoints + 6*(j-1) + 6;
        mu = param(rows);
        change = expmap(mu);
        PTAM.KeyFrames(index).Camera.E = change*PTAM.KeyFrames(index).Camera.E;
        
    end
end

outPTAM = PTAM;


end

