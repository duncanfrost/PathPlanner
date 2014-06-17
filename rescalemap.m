function [ outMap ] = rescalemap(Map, scale)
%RESCALEMAP Rescales the entire map

for i = 1:size(Map,2)
    outMap{i}.position = Map{i}.position*scale;
    outMap{i}.ispoint = Map{i}.ispoint;
end




end

