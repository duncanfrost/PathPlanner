function [  ] = writemap(Map,filename)
%WRITEMAP Writes a map, consisting of points and objects
nMap = size(Map,2);
fid = fopen(filename,'wt');

for i = 1:nMap
    pos = Map{i}.position;
    ispoint = Map{i}.ispoint;
    
    out = [pos ispoint i];
    if i < nMap
        fprintf(fid,'%2.6f %2.6f %2.6f %u %u\n',out);
    else
        fprintf(fid,'%2.6f %2.6f %2.6f %u %u',out);
    end
    

end

fclose(fid);



end

