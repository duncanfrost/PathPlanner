function [points ] = addnoise(points,sigma)
%ADDNOISE Adds noise to points, used as input to bundle




nPoints = size(points,1);


for i = 1:nPoints
    points(i,1) = points(i,1) + randn*sigma;
    points(i,2) = points(i,2) + randn*sigma;
    points(i,3) = points(i,3) + randn*sigma;
end






end

