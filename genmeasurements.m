function [ Measurements ] = genmeasurements(Poses, points, K)
%GENMEASUREMENTS Takes camera poses and points and calculates measurements
%in keyframes. 


nKeyFrames = size(Poses,2);
nPoints = size(points,1);

nMeasureCount = 0;


for i = 1:nKeyFrames
    T_wc = Poses{i};
    
    for j = 1:nPoints
       Point_w = [points(j,:)'; 1];
       Point_c = T_wc*Point_w;
       
       if (Point_c(3) > 0.5)

           Measure_norm = zeros(3,1);
           Measure_norm(1) = Point_c(1)/Point_c(3);
           Measure_norm(2) = Point_c(2)/Point_c(3);
           Measure_norm(3) = 1;
           
           if (Measure_norm(1) > -1 && Measure_norm(1) < 1 ...
               && Measure_norm(2) > -1 && Measure_norm(2) < 1)
               
               
               Measure_pix = K*Measure_norm;
               nMeasureCount = nMeasureCount + 1;
               Measurements{nMeasureCount}.c = i;
               Measurements{nMeasureCount}.p = j;
               Measurements{nMeasureCount}.position = Measure_pix;
               
           end
           
           
           
           
       end
       
       
       
        
    end
end




end

