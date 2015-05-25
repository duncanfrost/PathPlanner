function [ scale ] = measurescale( path )
%MEASURESCALE Outputs the scale of the path
speed = diff(path);
scale = zeros(size(speed,1),1);

for i = 1:size(speed,1)
    scale(i) = norm(speed(i,:));
end


end

