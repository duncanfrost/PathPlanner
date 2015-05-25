function [ Pose ] = estimatepose(Measurements, Pose, Map,K,nFrame)
%BUNDLEADJUST Does bundle adustment on the PTAM model.



dp = 1;
niter = 80;
iter = 0;
lambda = 10;


while iter < niter
    

    iter = iter + 1;

    [r, J] = calculateresidualscamonly(Measurements, Pose, Map,K);
    
    error = r'*r;
    left = J'*J + lambda*diag(diag(J'*J));
    right = J'*r;
    pn = left\right;

    param = -dp*pn;
   
    
    NewPose = expmap(param)*Pose;
    [r] = calculateresidualscamonly(Measurements, NewPose, Map,K);
    nerror = r'*r;
    
    
    if nerror <= error
        error = nerror;
        Pose = NewPose;
        lambda = lambda * (1-0.1);
    else
        lambda = lambda * (1+0.1);
    end
    
    clc;
    display(nFrame);
    display(error);
    display(iter);
    display(norm(param));
    display(lambda);
    display(nerror);
    
end



end





    






