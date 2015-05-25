function [r, J] = calculateresiduals(Measurements, pointList, camList, calcJ)
%CALCULATERESIDUALS Summary of this function goes here
%   Detailed explanation goes here



if (~isempty(camList))
    nParams = 3*size(pointList,2) + 6*size(camList,2);
else
    nParams = 3*size(pointList,2);
end

nRes = size(Measurements,2)*2;
J = zeros(nRes,nParams);
r = zeros(nRes,1);








for i = 1:size(Measurements,2)
    meas = Measurements{i};
    
    rows = 2*(i-1) + 1 :  2*(i-1) + 2;
    
    
    pointid = find(pointList == meas.p);
    camid = find(camList == meas.c);
    
    
    colsp = 3*(pointid-1) + 1 : 3*(pointid-1) + 3;
    colsc = 3*size(pointList,2) + 6*(camid-1) + 1 : 3*size(pointList,2) + 6*(camid-1) + 6;
    
    J(rows,colsp) = meas.JA;
    if (~isempty(camid))
        J(rows,colsc) = meas.JB;
    end
    
    r(rows) = meas.v2Error;
    
   
    
    
  
    
    
   
    
    
    
    

       
        
   
end


end



