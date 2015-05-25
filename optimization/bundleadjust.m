function [ outPTAM ] = bundleadjust(PTAM, World)
%BUNDLEADJUST Does bundle adustment on the PTAM model.






ncameras = size(PTAM.KeyFrames,2);
npoints = size(PTAM.Map.points,2);




%Calculate the current error


dp = 1;
niter = 100;
iter = 0;

lambda = 10000;

for i = 1:ncameras
    map{i} = generateidmap(PTAM.KeyFrames(i));
end
    



while iter < niter

    iter = iter + 1;
    
    
   
    %Calculate residuals and jacobian
    [ Measurements, pointList, camList ] = getmeasurements(PTAM.KeyFrames, PTAM.Map, map);
    
    

    [r, J] = calculateresiduals(Measurements, pointList, camList, true);
     H = J'*J;
    H = H*10000;
    H = round(H);
    H = H / 10000;
    
    
    
    
    



    error = r'*r;
    left = J'*J + lambda*diag(diag(J'*J));
    right = J'*r;
    pn = left\right;
    param = -dp*pn;
    
    
    rescount = size(r,1)/2;

    
    
    newPTAM = applyparam(PTAM, pointList, camList, param);
    
    [ meas, pl, cl ] = getmeasurements(newPTAM.KeyFrames, newPTAM.Map, map);
    [nr, J] = calculateresiduals(meas, pointList, camList, true);
    
    
  
      
 
    
    
    nerror = nr'*nr;
    
    
    rescalePTAM = applyrescale(newPTAM,World);

    [ meas, pl, cl ] = getmeasurements(rescalePTAM.KeyFrames, rescalePTAM.Map, map);
    [rr] = calculateresiduals(meas, pointList, camList, true);
    rerror = rr'*rr;
    
    
    clc
    display(rescount);
    display(error);
    display(nerror);
    display(rerror);
    display(iter);
    display(norm(param));
    display(lambda);

    
    if rerror < error
        PTAM = rescalePTAM;
        lambda = lambda * (1-0.1);
    else
        lambda = lambda * (1+0.1);
    end
    
end



outPTAM = PTAM;




end




