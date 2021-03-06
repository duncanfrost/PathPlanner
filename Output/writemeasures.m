function [  ] = writemeasures( Measurements, filename )
%WRITEMEASURES outputs the measurements to a file

nMeasurements = size(Measurements,2);
fid = fopen(filename,'wt');

for i = 1:nMeasurements
    Measurement = Measurements{i};
    
    pos = Measurement.position(1:2);
    c = Measurement.c;
    p = Measurement.p;
    s = Measurement.size;
    ispoint = Measurement.ispoint;
    
    output = [pos' s' ispoint c p];
     
    
    
    if i < nMeasurements
        fprintf(fid,'%2.6f %2.6f %2.6f %2.6f %u %u %u\n',output);
    else
        fprintf(fid,'%2.6f %2.6f %2.6f %2.6f %u %u %u',output);
    end

end




end

