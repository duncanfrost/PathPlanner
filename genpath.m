function [ path ] = genpath(nKeyFrames,xlimit,zlimit)
%GENPATH Generates a path
x = linspace(0,xlimit,nKeyFrames);
z = linspace(0,zlimit,nKeyFrames);
y = linspace(0,0,nKeyFrames);
path = [x' y' z'];





end

