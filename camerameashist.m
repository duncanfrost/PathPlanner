function [ hist ] = camerameashist( Measurements, nKeyFrames )
%CAMERAMEASHIST Gives a histogram of measurements per camera;


hist = zeros(nKeyFrames,1);

for i = 1:size(Measurements,2)
    hist(Measurements{i}.c) = hist(Measurements{i}.c) + 1;
end




end

