function [ Poses ] = posesfrompath(path,sigma_t,sigma_r)
nKeyFrames = size(path,1);

for i = 1:nKeyFrames-1
    diffx =  path(i+1,1) - path(i,1);
    diffz =  path(i+1,3) - path(i,3);
    
     if (diffx == 0)
         diffx = 1;
     end
         
    angle = -atan2(diffx,diffz);
    
   
        
        
    
    angle = angle + randn*sigma_r;

    
    
    R = [cos(angle) 0 sin(angle);
        0 1 0;
        -sin(angle) 0 cos(angle)];
    
    
    
    t_cw = path(i,:)';
    
    t_cw(1) = t_cw(1) + randn*sigma_t;
    t_cw(2) = t_cw(2) + randn*sigma_t;
    t_cw(3) = t_cw(3) + randn*sigma_t;
    
    
    
    
    t_wc = -R*t_cw;
    
    
    T_wc = [R t_wc; 0 0 0 1];
    Poses{i} = T_wc;
end


t_cw = path(nKeyFrames,:)';
t_cw(1) = t_cw(1) + randn*sigma_t;
t_cw(2) = t_cw(2) + randn*sigma_t;
t_cw(3) = t_cw(3) + randn*sigma_t;


t_wc = -R*t_cw;
T_wc = [R t_wc; 0 0 0 1];
Poses{nKeyFrames} = T_wc;


end

