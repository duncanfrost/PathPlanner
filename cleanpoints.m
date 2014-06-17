function [ cMap ] = cleanpoints(Measurements,Map)
%CLEANPOINTS clears points with 1 or zero measurements

histogram = zeros(size(Map,2),1);

for i = 1:size(Measurements,2)
    histogram(Measurements{i}.p) = histogram(Measurements{i}.p) + 1;
end


nNewMapCount = 0;
for i = 1:size(Map,2)
    if (histogram(i) > 1)
        nNewMapCount = nNewMapCount + 1;
        cMap{nNewMapCount}.position = Map{i}.position;
        cMap{nNewMapCount}.ispoint = Map{i}.ispoint;
    end
end
        




end

