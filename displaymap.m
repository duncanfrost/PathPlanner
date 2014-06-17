function [  ] = displaymap( Poses, Map, color  )
%DISPLAYMAP Draws poses, points and objects

directions = getdirections(Poses);
path = pathfromposes(Poses);
nKeyFrames = size(Poses,2);


options = [color 'o'];
plot3(path(:,1),path(:,3),path(:,2),options);

options = [color '-'];
for i = 1:nKeyFrames
    plot3([path(i,1) directions(i,1)],[path(i,3) directions(i,3)],[path(i,2) directions(i,2)],options);
end


for i = 1:size(Map,2)
    pos = Map{i}.position;
    
    if (Map{i}.ispoint)
        options = [color '.'];
        plot3(pos(1),pos(:,3), pos(:,2),options,'MarkerSize',1);
    else
          drawcube(pos,2.5,color);
    end
end







end

