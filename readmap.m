function [points] = readmap(filename)
%WRITEPOSES reads poses from file


fid = fopen(filename,'r');



points = [];
while ~feof(fid)
    
    out = fscanf(fid,'%f',5);
    if ~isempty(out)
        point = out(1:3);
        points = [points; point'];
        
    end
    
end

fclose(fid);


end

