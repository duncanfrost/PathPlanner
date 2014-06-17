function [ Measurements ] = genmeasurements(Poses, points, K,sigma)
%GENMEASUREMENTS Takes camera poses and points and calculates measurements
%in keyframes.


nKeyFrames = size(Poses,2);
nPoints = size(points,1);

nMeasureCount = 0;


for i = 1:nKeyFrames
    clc;
    display(i);
    display(nKeyFrames);
    T_wc = Poses{i};
    nMeasurements = 0;
    
    
    
    for j = 1:nPoints
        
        if (nMeasurements < 15)
            Point_w = [points(j,:)'; 1];
            Point_c = T_wc*Point_w;
            
            if (Point_c(3) > 0.5 && Point_c(3) < 7)
                
                Measure_norm = zeros(3,1);
                Measure_norm(1) = Point_c(1)/Point_c(3);
                Measure_norm(2) = Point_c(2)/Point_c(3);
                Measure_norm(3) = 1;
                
                if (Measure_norm(1) > -1 && Measure_norm(1) < 1 ...
                        && Measure_norm(2) > -1 && Measure_norm(2) < 1)
                    
                    
                    Measure_pix = K*Measure_norm;
                    Measure_pix(1) = Measure_pix(1) + randn*sigma;
                    Measure_pix(2) = Measure_pix(2) + randn*sigma;
                    
                    
                    nMeasureCount = nMeasureCount + 1;
                    Measurements{nMeasureCount}.c = i;
                    Measurements{nMeasureCount}.p = j;
                    Measurements{nMeasureCount}.position = Measure_pix;
                    nMeasurements = nMeasurements + 1;
                    
                    
                end
                
                
                
                
            end
        end

    end
end




end

