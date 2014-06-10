%% Init
close all;
clear VARIABLES;

nKeyFrames = 10;
nPointsPerKF = 20;


%% Get the path
path = getpath(nKeyFrames);




%% Generate points
points = genpoints(path, nPointsPerKF);


%% Plot

Poses = posesfrompath(path,0,0);
K = [320 0 320;
    0 240 240;
    0 0 1];

EstPoses = posesfrompath(path,0.1,0.1);
estpath = pathfromposes(EstPoses);
estpoints = addnoise(points,0.1);


Measurements = genmeasurements(Poses,points,K);
    

f = figure;
hold on;
plot3(path(:,1),path(:,3),path(:,2),'ro');
plot3(estpath(:,1),estpath(:,3),estpath(:,2),'bo');
plot3(points(:,1),points(:,3), points(:,2),'rx');
plot3(estpoints(:,1),estpoints(:,3), estpoints(:,2),'bx');


writeposes(EstPoses,'EstPoses.txt');
writepoints(estpoints,'EstPoints.txt');
writemeasures(Measurements,'EstMeasurements.txt');

writeposes(Poses,'GTPoses.txt');
writepoints(points,'GTPoints.txt');





axis equal;