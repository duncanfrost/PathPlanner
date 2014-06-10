function [ path ] = pathfromposes( Poses )
%CENTRESFROMPOSES Converts camera poses to camera centres

nKeyFrames = size(Poses,2);

path = zeros(nKeyFrames,3);

for i = 1:nKeyFrames
    T = Poses{i};
    R = T(1:3,1:3);
    t = T(1:3,4);
    centre = -R'*t;
    path(i,:) = centre';
end





end

