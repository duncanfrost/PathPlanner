function [  ] = writepoints( points, filename)
%WRITEPOINTS Writes the points out to a file
nPoints = size(points,1);
fid = fopen(filename,'wt');

for i = 1:nPoints
    point = points(i,:);
    out = [point i];
    if i < nPoints
        fprintf(fid,'%2.6f %2.6f %2.6f %u\n',out);
    else
        fprintf(fid,'%2.6f %2.6f %2.6f %u',out);
    end
    

end

fclose(fid);




end

