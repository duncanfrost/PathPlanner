function [  ] = writeposes(Poses,filename)
%WRITEPOSES performs the log map of poses and outputs the 6 dimensional lie
%vector

nKeyFrames = size(Poses,2);
fid = fopen(filename,'wt');

for i = 1:nKeyFrames
    mu = logmap2(Poses{i});
    
    if i < nKeyFrames
        fprintf(fid,'%2.6f %2.6f %2.6f %2.6f %2.6f %2.6f\n',mu);
    else
        fprintf(fid,'%2.6f %2.6f %2.6f %2.6f %2.6f %2.6f',mu);
    end
    
    
    
    
end

fclose(fid);


end

