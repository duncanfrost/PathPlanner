function [ path ] = genpath2(nKeyFrames,xlimit,zlimit)
%GENPATH Generates a path
t = linspace(0,2*pi,nKeyFrames);

% z = -100*exp(-x/20) + 100;
r = 10;

x = linspace(0,100,nKeyFrames);
z = x;
y = linspace(0,0,nKeyFrames);
path = [x' y' z'];





end

