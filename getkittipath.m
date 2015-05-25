function [ path ] = getkittipath( nKeyFrames, spacing,start )

filename = '/media/duncanlocal/Data2/KITTI/dataset/poses/08.txt';
fid = fopen(filename,'r');


i = 0;

path = zeros(nKeyFrames,3);


line = 0;
spacecount = 0;
while (~feof(fid) && i <nKeyFrames)
    
    
    out = fscanf(fid,'%f',12);
    
    if (~isempty(out))
        line = line + 1;
        
        if (line >= start)
            spacecount = spacecount + 1;

            if spacecount == spacing
                i = i + 1;
                pos = zeros(1,3);
                pos(1) = out(4);
                pos(2) = out(8);
                pos(3) = out(12);
                path(i,:) = pos;    
                spacecount = 0;
            end
        end
    end
    
end

fclose(fid);


end

