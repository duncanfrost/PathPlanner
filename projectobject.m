function [ xr, s ] = projectobject(T,K,centre,size)
%PROJECTOBJECT Calculates the projection of the object in the camera

xr = [];
s = [];

pointCamera = T*centre;
X = pointCamera(1);
Y = pointCamera(2);
Z = pointCamera(3);


Xnn = K(1,1)*X + K(1,3)*Z;
Ynn = K(2,2)*Y + K(2,3)*Z;
Znn = Z;




if (pointCamera(3) > 0.5 && pointCamera(3) < 30)



    Jp = zeros(2,3);
    for p = 1:3
        [dX_dp, dY_dp, dZ_dp] = diffXn3DIntern(T,K,p);
        Jp(1,p) = (dX_dp*Znn - dZ_dp*Xnn)/(Z^2);
        Jp(2,p) = (dY_dp*Znn - dZ_dp*Ynn)/(Z^2);
    end




    C = [size^2 0 0; 0 size^2 0; 0 0 size^2];



    %calculate projection bounds for actual camera
    Q = Jp*C*Jp';
    s = [sqrt(Q(1,1)) , sqrt(Q(2,2))]';








    %Draw rectangle in actual camera
    T_proj = T(1:3,:);
    xr = K*T_proj*centre;
    xr = xr./xr(3);
    if ~(xr(1) > 1 && xr(1) < 640 && xr(2) > 1 && xr(2) < 480)
        xr = [];
        s = [];
    else
        xr(1) = xr(1) + randn*10;
        xr(2) = xr(2) + randn*10;
        boundnoise = randn*10;
        s(1) = s(1) + boundnoise;
        s(2) = s(2) + boundnoise;
    end
    
    
          
  
    
    
end



end

