close all;
clear variables;

GTPoses = readposes('GTPoses.txt');
OutPoses = readposes('OutPoses.txt');

outpath = pathfromposes(OutPoses);
gtpath = pathfromposes(GTPoses);


GTpoints = readmap('GTMap.txt');
Outpoints = readmap('OutMap.txt');


%% Plot 1

% f = figure;
% hold on;
% plot3(gtpath(:,1),gtpath(:,3),gtpath(:,2),'ro');
% plot3(estpath(:,1),estpath(:,3),estpath(:,2),'bo');
% plot3(GTpoints(:,1),GTpoints(:,3), GTpoints(:,2),'rx');
% plot3(estpoints(:,1),estpoints(:,3), estpoints(:,2),'bx');
% axis equal;

%% Plot 2

f = figure;
hold on;
limit = 50:100;
plot3(gtpath(:,1),gtpath(:,3),gtpath(:,2),'bo');
plot3(outpath(:,1),outpath(:,3),outpath(:,2),'ro');
% plot3(GTpoints(:,1),GTpoints(:,3), GTpoints(:,2),'r.','MarkerSize',1);
% plot3(Outpoints(:,1),Outpoints(:,3), Outpoints(:,2),'b.','MarkerSize',1);
axis equal;
% axis off;
ylabel('Speed');
xlabel('Keyframe');
legend('Ground-truth','Estimated','location','best');
saveas(f, 'traj.eps','epsc');




gtscale = measurescale(gtpath);
outscale = measurescale(outpath);

error = sqrt((gtscale-outscale).*(gtscale-outscale));

errorpercentage = error ./ gtscale;
err = errorpercentage;
errorpercentage = 100 * sum(errorpercentage) / size(gtscale,1);

% 
f = figure;


hold on;
% objects = [20 outscale(20); 
%             40 outscale(40); 
%             60 outscale(60);
%             80 outscale(80);
%             100 outscale(100);
%             120 outscale(120);
%             140 outscale(140)];



plot(gtscale,'b','LineWidth',3);
plot(outscale,'r','LineWidth',3);
plot(err,'g','LineWidth',3);
% plot(objects(:,1),objects(:,2),'gx','MarkerSize',10,'LineWidth',3);
ylabel('Speed');
xlabel('Keyframe');
legend('Ground-truth','Estimated','location','best');
saveas(f, 'scale.eps','epsc');



% K = [320 0 320;
%     0 240 240;
%     0 0 1];

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

%% Plot 3
hold on;
plot3(gtpath(:,1),gtpath(:,3),gtpath(:,2),'bx');
plot3(outpathnorm(:,1),outpathnorm(:,3),outpathnorm(:,2),'rx');
plot3(outpathobj(:,1),outpathobj(:,3),outpathobj(:,2),'gx');
axis equal;
axis off;
legend('Ground-truth','Estimated: Points only','Estimated: Object-supplemented','location','best');
