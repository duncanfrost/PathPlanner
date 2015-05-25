function [ output_args ] = displaymeaspoints( Measurements )

hist = zeros(size(Measurements,2),1);

for i = 1:size(Measurements,2)
    hist(i) = Measurements{i}.p;
end

display(hist);



end

