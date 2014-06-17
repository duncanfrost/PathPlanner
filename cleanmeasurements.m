function [ OutMeasurements ] = cleanmeasurements(Measurements, EstMeasurements)


outcount = 0;

for i = 1:size(Measurements,2)
    for j = 1:size(EstMeasurements,2)
        if (Measurements{i}.c == EstMeasurements{j}.c && Measurements{i}.p == EstMeasurements{j}.p)
            outcount = outcount + 1;
            OutMeasurements{outcount} = Measurements{i};
        end
    end
end




end

