function [  ] = checkfornans( hist )

for i = 1:size(hist,1)
    if hist(i) < 6
        display('We are going to have a problem!');
        
        
    end
end

end

