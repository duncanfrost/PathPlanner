function [ Measurements, pointList, camList] = getmeasurements(KeyFrames, Map, map)

nMeasurements = 0;
ncameras = size(KeyFrames,2);
npoints = size(Map.points,2);
K = KeyFrames(1).Camera.K;
pointList = [];
camList = [];

pointparams = 3;
camparams = 6;


for i = 1:ncameras
    E = KeyFrames(i).Camera.E;
    for j = 1:npoints
        id = Map.points(j).id;
        pointIndex = map{i}(id);
        if pointIndex > 0
            nMeasurements = nMeasurements + 1;
            meas.c = i;
            meas.p = j;
            pointList = [pointList meas.p];
           
            
            
            imagePoint = KeyFrames(i).ImagePoints(pointIndex).location;
            imagePoint = K\imagePoint;
            
            meas.v2Found = [imagePoint(1) imagePoint(2)]';
            
            
            pointCamera = E*Map.points(j).location;
            X = pointCamera(1);
            Y = pointCamera(2);
            Z = pointCamera(3);
            x = X/Z;
            y = Y/Z;
            
            meas.v2Project = [x y]';
            meas.v2Error = meas.v2Project -  meas.v2Found;
            
            
            JA = zeros(2,3);
            
            for p = 1:pointparams
                [dX_dp, dY_dp, dZ_dp] = diffXn3D(E,p);
                JA(1,p) = (dX_dp*Z - dZ_dp*X)/(Z^2);
                JA(2,p) = (dY_dp*Z - dZ_dp*Y)/(Z^2);
            end
            
            meas.JA = JA;
            
            JB = zeros(2,6);
            
          
            
            if i > 2
                camList = [camList meas.c];
                for c = 1:camparams
                    [dX_dp, dY_dp, dZ_dp] = expdiffXn(X,Y,Z,E,c);
                    JB(1,c) = (dX_dp*Z - dZ_dp*X)/(Z^2);
                    JB(2,c) = (dY_dp*Z - dZ_dp*Y)/(Z^2);
                end
            end
%                 JB = zeros(2,6);
%             end
            
            
            meas.JB = JB;
            
            
            Measurements{nMeasurements} = meas;

            
        end
    end
end

pointList = unique(pointList);
camList = unique(camList);





end

