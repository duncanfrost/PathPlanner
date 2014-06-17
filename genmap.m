%% Init
close all;
clc;
clear variables;

addpath('Output');

s = RandStream('mt19937ar','Seed',0);
RandStream.setGlobalStream(s);

nKeyFrames = 200;
nPointsPerKF = 20;


%% Get the path
% path = getpath(nKeyFrames);
path = genpath2(nKeyFrames,100,100);

%% Add Objects
objects = [90 0 80];

%% Generate points
points = genpoints(path, nPointsPerKF);

%% Combine the two
Map = makemap(points,objects);


%% Plot

Poses = posesfrompath(path,0,0);
K = [320 0 320;
    0 240 240;
    0 0 1];


display('Calculating Est Measurements');
Measurements = genobjectmeasurements(Poses,Map,K,0);
Map = cleanpoints(Measurements,Map);
EstMeasurements = genobjectmeasurements(Poses,Map,K,2);

display('Checking for possible errors');
camhist = camerameashist(EstMeasurements, nKeyFrames);
checkfornans(camhist);




estpath = path;


EstPoses = posesfrompath(estpath,0,0);
estpath = pathfromposes(EstPoses);



estpoints = points;
EstMap = rescalemap(Map,1);


display('Calculating Directions');

 



%% Plot Everything


figure;
hold on;
displaymap(Poses,Map,'r');
axis equal;


figure;
hold on;
displaymap(EstPoses,EstMap,'b');
axis equal;




%% Output
writeposes(EstPoses,'EstPoses.txt');
writemap(EstMap,'EstMap.txt');
writemeasures(EstMeasurements,'EstMeasurements.txt');

writeposes(Poses,'GTPoses.txt');
writepoints(points,'GTPoints.txt');



