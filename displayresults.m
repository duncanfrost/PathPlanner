EstPoses = readposes('EstPoses.txt');
GTPoses = readposes('Poses.txt');

estpath = pathfromposes(EstPoses);
gtpath = pathfromposes(GTPoses);

Estpoints = readpoints('EstPoints.txt');
GTpoints = readpoints('GTPoints.txt');


f = figure;
hold on;
plot3(path(:,1),path(:,3),path(:,2),'ro');
plot3(estpath(:,1),estpath(:,3),estpath(:,2),'bo');
plot3(points(:,1),points(:,3), points(:,2),'rx');
plot3(estpoints(:,1),estpoints(:,3), estpoints(:,2),'bx');
axis equal;