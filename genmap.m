%% Init
close all;
clc;
clear variables;

addpath('Output');
addpath('optimization');
addpath('rotations');
addpath('reprojection');

s = RandStream('mt19937ar','Seed',0);
RandStream.setGlobalStream(s);

nKeyFrames = 150;
nPointsPerKF = 50;


%% Get the path
% load path;
% path = getpath(nKeyFrames);
% display('Got path');
% close all;
% % path = genpath2(nKeyFrames,100,100);
path = getkittipath(nKeyFrames,6,0);

%% Add Objects
% objects = [50 0 50; 100 0 100];

pathEnd = path(size(path,1),:);
% objects = path;
objects = [0 0 0];

count = 0;
for i = 1:size(path,1)
    count = count + 1;
    if count == 1
        objects = [objects; path(i,:)];
        count = 0;
    end
        
end



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
Measurements = genobjectmeasurements(Poses,Map,K,0,40);
Map = cleanpoints(Measurements,Map);
EstMeasurements = genobjectmeasurements(Poses,Map,K,4,40);

display('Checking for possible errors');
camhist = camerameashist(EstMeasurements, nKeyFrames);
checkfornans(camhist);




estpath = path;

EstPoses = posesfrompath(estpath,0,0);




EstMap = rescalemap(Map,1);


display('Calculating Directions');

 



%% Plot Everything


figure;
hold on;
displaymap(Poses,Map, 'r', EstMeasurements);
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
writemap(Map,'GTMap.txt');



