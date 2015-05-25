function [r, J] = calculateresidualscamonly(Measurements, CurrentPose, Map,K)
%CALCULATERESIDUALSCAMONLY Calculates the residuals, and optionally
%jacobain for single camera only optimisation


filteredCount = 0;
for i = 1:size(Measurements,2);
    p = Measurements{i}.p;
    
    if (Map{p}.assigned)
        filteredCount = filteredCount + 1;
        FilteredMeasurements{filteredCount} = Measurements{i};
    end
end


if size(FilteredMeasurements,2) < 6
    display('Problem');
end



r = [];
J = [];

if exist('FilteredMeasurements','var')
    
    
    
    nMeasurements = size(FilteredMeasurements,2);
    
    camparams = 6;
    
    
    r = zeros(2*nMeasurements,1);
    
    J = zeros(2*nMeasurements,camparams);
    
    
    
    
    row = -1;
    
    for j = 1:nMeasurements
        
        p = FilteredMeasurements{j}.p;
        pointWorld = [Map{p}.position'; 1];
        imagePoint = K\FilteredMeasurements{j}.position;
        
        
        
        
        pointCamera = CurrentPose*pointWorld;
        X = pointCamera(1);
        Y = pointCamera(2);
        Z = pointCamera(3);
        
        if Z ~= 0
            x = X/Z;
            y = Y/Z;





            u = imagePoint(1);
            v = imagePoint(2);






            r(2*(j-1) + 1) = (x-u);
            r(2*(j-1) + 2) = (y-v);


            for c = 1:camparams
                [dX_dp dY_dp dZ_dp] = expdiffXn(X,Y,Z,eye(4,4),c);
                first = (dX_dp*Z - dZ_dp*X)/(Z^2);
                second = (dY_dp*Z - dZ_dp*Y)/(Z^2);

                if isnan(first)
                    display('Problem');
                end


                J(2*(j-1) + 1,c) = first;
                J(2*(j-1) + 2,c) = second;
            end
        end
        
        
        
        
        
    end
end





end

