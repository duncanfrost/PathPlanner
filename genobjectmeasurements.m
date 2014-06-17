function [ Measurements ] = genobjectmeasurements(Poses, Map, K, sigma)
%GENOBJECTMEASUREMENTS Generates object measurements for a set of poses


nMap = size(Map,2);
nKeyFrames = size(Poses,2);


nMeasureCount = 0;


nPointMeasurements = 0;

for i = 1:nKeyFrames
    clc;
    display(i);
    display(nKeyFrames);
    display(nPointMeasurements);
    
    T_wc = Poses{i};
    nPointMeasurements = 0;
    
    
    for j = 1:nMap
        if (Map{j}.ispoint)
            if (nPointMeasurements < 15)
                
                
                Point_w = [Map{j}.position'; 1];
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
                        Measurements{nMeasureCount}.ispoint = true;
                        Measurements{nMeasureCount}.size = [0 0]';
                        nPointMeasurements = nPointMeasurements + 1;
                    end
                end
            end
            
        else
            centre = [Map{j}.position'; 1];
            [ xr, s ] = projectobject(T_wc,K,centre,2.5);
            
            if (~isempty(xr))
                nMeasureCount = nMeasureCount + 1;
                Measurements{nMeasureCount}.c = i;
                Measurements{nMeasureCount}.p = j;
                Measurements{nMeasureCount}.position = xr;
                Measurements{nMeasureCount}.ispoint = false;
                Measurements{nMeasureCount}.size = s;
                nPointMeasurements = nPointMeasurements + 1;
            end
        end
    end
    
end

end



