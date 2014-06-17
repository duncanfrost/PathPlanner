function [ directions ] = getdirections( Poses )
%GETDIRECTIONS gives the directions of each camera

nKeyFrames = size(Poses,2);

for i = 1:nKeyFrames
    
 
    
    point_c = [0 0 1 1]';
    T_wc = Poses{i};
    T_cw = inv(T_wc);
    direction = T_cw*point_c;
    directions(i,:) = [direction(1),direction(2),direction(3)];
    
    
    
    
end


end

