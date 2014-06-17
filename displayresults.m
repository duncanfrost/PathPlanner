close all;
EstPoses = readposes('EstPoses.txt');
GTPoses = readposes('GTPoses.txt');

estpath = pathfromposes(EstPoses);
gtpath = pathfromposes(GTPoses);

Estpoints = readpoints('EstPoints.txt');
GTpoints = readpoints('GTPoints.txt');


OutPoses = readposes('OutPoses.txt');
Outpoints = readpoints('OutPoints.txt');
outpath = pathfromposes(OutPoses);



f = figure;
hold on;
plot3(gtpath(:,1),gtpath(:,3),gtpath(:,2),'ro');
plot3(estpath(:,1),estpath(:,3),estpath(:,2),'bo');
% plot3(GTpoints(:,1),GTpoints(:,3), GTpoints(:,2),'rx');
% plot3(estpoints(:,1),estpoints(:,3), estpoints(:,2),'bx');
axis equal;



f = figure;
hold on;
plot3(gtpath(:,1),gtpath(:,3),gtpath(:,2),'ro');
plot3(outpath(:,1),outpath(:,3),outpath(:,2),'bo');
% plot3(GTpoints(:,1),GTpoints(:,3), GTpoints(:,2),'rx');
% plot3(Outpoints(:,1),Outpoints(:,3), Outpoints(:,2),'bx');
axis equal;


K = [320 0 320;
    0 240 240;
    0 0 1];

% Measurements = genmeasurements(GTPoses,GTpoints,K,0);
% EstMeasurements = genmeasurements(EstPoses,Estpoints,K,0);
% OutMeasurements = genmeasurements(OutPoses,Outpoints,K,0);
% 
% 
% StartError = getreprojerror(Measurements,EstMeasurements);
% EndError = getreprojerror(Measurements,OutMeasurements);
% 
% display(StartError);
% display(EndError);
% 
% 
% StartPointError = getpointerror(points, estpoints);
% EndPointError = getpointerror(points, Outpoints);
% 
% display(StartPointError);
% display(EndPointError);