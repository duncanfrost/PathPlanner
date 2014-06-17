function [ CurrentError ] = getreprojerror(Measurements, EstMeasurements)
%GETREPROJERROR Calculates the reprojection error for the measurements

CurrentError = 0;
for i = 1:size(Measurements,2)
    diff = Measurements{i}.position - EstMeasurements{i}.position;
    CurrentError = CurrentError + diff'*diff;
end



end

