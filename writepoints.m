function [  ] = writepoints( points, filename)
%WRITEPOINTS Writes the points out to a file
nPoints = size(points,1);
fid = fopen(filename,'wt');

for i = 1:nPoints
    point = points(i,:);
    if i < nPoints
        fprintf(fid,'%2.6f %2.6f %2.6f\n',point);
    else
        fprintf(fid,'%2.6f %2.6f %2.6f',point);
    end
    

end

fclose(fid);




end

