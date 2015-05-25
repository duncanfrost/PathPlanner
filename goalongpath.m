function [OutPoses, Measurements, OutMap] = goalongpath(Poses, Map,K, sigma,limit )
T_current = Poses{1};
nKeyFrames = size(Poses,2);



nPointMeasurements = 0;
nMeasureCount = 0;

for i = 1:size(Map,2)
      OutMap{i}.gt = Map{i}.position;
      OutMap{i}.assigned = false;
end




for i = 1:240
    OutMap{i} = Map{i};
    OutMap{i}.assigned = true;
  
end



    
nEstPoints = 60;


for i = 1:12
    clc;
    display(i);
    display(nKeyFrames);
    display(nPointMeasurements);
    
    T_wc = Poses{i};
    nPointMeasurements = 0;
    nCurrentMeasureCount = 0;
    
    CurrentMeasurements = [];
    
    for j = 1:size(Map,2)
        if (Map{j}.ispoint)
           
                
                
                Point_w = [Map{j}.position'; 1];
                Point_c = T_wc*Point_w;
                
                if (Point_c(3) > 0.5 && Point_c(3) < 30)
                    
                    Measure_norm = zeros(3,1);
                    Measure_norm(1) = Point_c(1)/Point_c(3);
                    Measure_norm(2) = Point_c(2)/Point_c(3);
                    Measure_norm(3) = 1;
                    
                    if (Measure_norm(1) > -1 && Measure_norm(1) < 1 ...
                            && Measure_norm(2) > -1 && Measure_norm(2) < 1)
                        
                        Measure_pix = K*Measure_norm;
                        Measure_pix(1) = Measure_pix(1) + randn*sigma;
                        Measure_pix(2) = Measure_pix(2) + randn*sigma;
                        
                       
                        Measurement.c = i;
                        Measurement.p = j;
                        Measurement.position = Measure_pix;
        
                        Measurement.ispoint = true;
                        Measurement.size = [0 0]';
                 
                        
                        
                        
                        nMeasureCount = nMeasureCount + 1;
                        Measurements{nMeasureCount} = Measurement;
                        
                        
          
                        nCurrentMeasureCount = nCurrentMeasureCount + 1;
                        CurrentMeasurements{nCurrentMeasureCount} = Measurement;
              
                     
                        nPointMeasurements = nPointMeasurements + 1;
                        
                        
            
                        
                    end
                end
           
        end
    end
    

     T_current = estimatepose(CurrentMeasurements, T_current, OutMap,K,i);
  
    
    if (i > 1)
        OutMap = addtomap(T_current,T_past,CurrentMeasurements,PastMeasurements,OutMap,K);
    end
    
    
    
    OutPoses{i} = T_current;
    
    PastMeasurements = CurrentMeasurements;
    T_past = T_current;
        
        
        

    
    
    
    
    
end






end

