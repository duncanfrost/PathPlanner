function [ Map ] = makemap(points,objects)
%COMBINEPOINTSANDOBJECTS combines points and objects into one data
%structure


mapCount = 0;

for i = 1:size(points,1)
    mapCount = mapCount + 1;
    Map{mapCount}.position = points(i,:);
    Map{mapCount}.ispoint = true;
end

for i = 1:size(objects,1)
    mapCount = mapCount + 1;
    Map{mapCount}.position = objects(i,:);
    Map{mapCount}.ispoint = false;
end





end

