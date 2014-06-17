function [Poses] = readposes(filename)
%WRITEPOSES reads poses from file


fid = fopen(filename,'r');


i = 0;


line = 0;
while ~feof(fid)
    line = line + 1;
    
    out = fscanf(fid,'%f',7);
    if (~isempty(out))
    

    
        posemu = out(1:6);
        display(posemu);




        i = i + 1;
        if (size(posemu,1) == 6)
            T = expmap(posemu);
            Poses{i} = T;
        else
            display('Problem!');
        end
    end
    
end

fclose(fid);


end

