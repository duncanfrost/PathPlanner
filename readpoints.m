function [points] = readpoints(filename)
%WRITEPOSES reads poses from file


fid = fopen(filename,'r');



points = [];
while ~feof(fid)
   
    point = fscanf(fid,'%f',3);

    
    
   
    if ~isempty(point)
      points = [points; point'];
      
    end
    
end

fclose(fid);


end

