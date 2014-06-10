function [Poses] = readposes(filename)
%WRITEPOSES reads poses from file


fid = fopen(filename,'r');


i = 0;

while ~feof(fid)
   
    mu = fscanf(fid,'%f',6);
    display(mu);
    
    
    i = i + 1;
    if ~isempty(mu)
        T = expmap(mu);
        Poses{i} = T;
    end
    
end

fclose(fid);


end

