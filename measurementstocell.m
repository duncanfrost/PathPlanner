function [ Out ] = measurementstocell( Measurements )
Out = [];

for i = 1:size(Measurements,2)
    c = Measurements{i}.c;
    p = Measurements{i}.p;
    pos = Measurements{i}.position;
    Out{p,c} = pos;
    



end

