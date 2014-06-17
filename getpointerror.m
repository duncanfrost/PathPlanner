function [ CurrentError ] = getpointerror(points, estpoints)
%GETPOINTERROR Calculates the difference between ground 

CurrentError = 0;
for i = 1:size(points,1)
    diff = points(i,:)-estpoints(i,:);
    CurrentError = CurrentError + diff*diff';
    
    
end



end

