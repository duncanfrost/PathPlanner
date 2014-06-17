clc;
close all;



X = 0.0;
Y = 0.0;
Z = 10;


PX = [0 0 10 1]';
C = [3^2 0 0; 0 3^2 0; 0 0 3^2];

PX2 = [3 0 10 1]';






Camera.f = 0.5;
ay = 480*Camera.f;
ax = 640*Camera.f;
u0 = 640/2;
v0 = 480/2;
Camera.K = [ax 0 u0; 0 ay v0; 0 0 1];


Camera.E = eye(4,4);


pointparams = 3;

pointCamera = Camera.E*PX;
X = pointCamera(1);
Y = pointCamera(2);
Z = pointCamera(3);
Xnn = Camera.K(1,1)*X + Camera.K(1,3)*Z;
Ynn = Camera.K(2,2)*Y + Camera.K(2,3)*Z;
Znn = Z;

X = Xnn;
Y = Ynn;
Z = Znn;


P = Camera.K*Camera.E(1:3,:);

mu = rand(6,1)*0.3;
E_optim = expmap(mu);
P_optim = Camera.K*E_optim(1:3,:);




shape = [3 3 3];
TX = PX;
TX(1:3) = TX(1:3) + 2*rand(3,1);

f = figure;


for i = 1:4000
    
    
    
    clf(f)
    
    
    
    %Calculate projection for point in actual camera
    Jr = zeros(2,3);
    for p = 1:pointparams
        [dX_dp, dY_dp, dZ_dp] = diffXn3DIntern(Camera.E, Camera.K,p);
        Jr(1,p) = (dX_dp*Z - dZ_dp*X)/(Z^2);
        Jr(2,p) = (dY_dp*Z - dZ_dp*Y)/(Z^2);
    end
    
    
    
    
    %Calculate projection for point in optim camera
    Jo = zeros(2,3);
    for p = 1:pointparams
        [dX_dp, dY_dp, dZ_dp] = diffXn3DIntern(E_optim, Camera.K,p);
        Jo(1,p) = (dX_dp*Z - dZ_dp*X)/(Z^2);
        Jo(2,p) = (dY_dp*Z - dZ_dp*Y)/(Z^2);
    end
    
    
    
    %calculate projection bounds for actual camera
    Qr = Jr*C*Jr';
    sr = [sqrt(Qr(1,1)) , sqrt(Qr(2,2))]';
    
    %calculate projection bounds for optim camera
    Qo = Jo*C*Jo';
    so = [sqrt(Qo(1,1)) , sqrt(Qo(2,2))]';
    
    
    hold on;
    
    
    
    
    %Draw rectangle in actual camera
    xr = Camera.K*Camera.E(1:3,:)*PX;
    xr = xr./xr(3);
    if (xr(1) > 1 && xr(1) < 640 && xr(2) > 1 && xr(2) < 480)
        plot(xr(1),xr(2),'rx');
        plotrec(xr(1),xr(2),sr(1)*2,sr(2)*2,'b');
    end
    
    %     %Draw rectangle in optim camera
    %     xo = Camera.K*E_optim(1:3,:)*PX;
    %     xo = xo./xo(3);
    %     if (xo(1) > 1 && xo(1) < 640 && xo(2) > 1 && xo(2) < 480)
    %         plot(xo(1),xo(2),'rx');
    %         plotrec(xo(1),xo(2),so(1)*2,so(2)*2,'r');
    %     end
    
    
    
    
    
    [proj_centre, proj_bounds, jacob_shape, jacob_pos, jacob_proj, J_point] = AlexProj(PX(1:3), shape, P_optim);
    
    if (proj_centre(1) > 1 && proj_centre(1) < 640 && proj_centre(2) > 1 && proj_centre(2) < 480)
        plot(proj_centre(1),proj_centre(2),'rx');
        plotrec(proj_centre(1),proj_centre(2),proj_bounds(1)*2,proj_bounds(2)*2,'r');
    end
    
    camparams = 6;
    
    
            
    pointCamera = E_optim*PX;
    Xo = pointCamera(1);
    Yo = pointCamera(2);
    Zo = pointCamera(3);
    
    Xnn = Camera.K(1,1)*Xo + Camera.K(1,3)*Zo;
    Ynn = Camera.K(2,2)*Yo + Camera.K(2,3)*Zo;
    Znn = Zo;
    

    

            
    Jcent = zeros(2,6);
    for c = 1:camparams
        [dX_dp, dY_dp, dZ_dp] = expdiffXnIntern(X,Y,Z,eye(4,4),Camera.K,c);
        Jcent(1,c) = (dX_dp*Z - dZ_dp*X)/(Z^2);
        Jcent(2,c) = (dY_dp*Z - dZ_dp*Y)/(Z^2);
    end
    
    
    dEdmu1 = generator(1)*E_optim;
    dEdmu2 = generator(2)*E_optim;
    dEdmu3 = generator(3)*E_optim;
    dEdmu4 = generator(4)*E_optim;
    dEdmu5 = generator(5)*E_optim;
    dEdmu6 = generator(6)*E_optim;
    
    
    dPdmu = zeros(12,6);
    
    dPdmu(:,1) = reshape(Camera.K*dEdmu1(1:3,:),12,1);
    dPdmu(:,2) = reshape(Camera.K*dEdmu2(1:3,:),12,1);
    dPdmu(:,3) = reshape(Camera.K*dEdmu3(1:3,:),12,1);
    dPdmu(:,4) = reshape(Camera.K*dEdmu4(1:3,:),12,1);
    dPdmu(:,5) = reshape(Camera.K*dEdmu5(1:3,:),12,1);
    dPdmu(:,6) = reshape(Camera.K*dEdmu6(1:3,:),12,1);
    
    
    jacob_proj_vec = zeros(2,12);
    jacob_proj_vec(1,:) = reshape(jacob_proj{1}.P,1,12);
    jacob_proj_vec(2,:) = reshape(jacob_proj{2}.P,1,12);
    
    Jborder = jacob_proj_vec*dPdmu;
    
    J = [Jcent; Jborder];
    
    
    
    
    
    
    r = zeros(4,1);
    
    r(1:2) = (proj_centre(1:2) - xr(1:2));
    r(3:4) = (proj_bounds' - sr);
    
    grad = J'*r;
    
    mu = mu - grad*0.0000001;
    E_optim = expmap(mu);
    
    P_optim = Camera.K*E_optim(1:3,:);
    
    
    
    clc;
    display(i);
    display(r'*r);
    display(Camera.E);
    display(mu);
    display(E_optim);
    display(Camera.E);
    %     display(grad);
    %     display(rs'*rs);
    
    %     TX(1:3) = TX(1:3) - grads*0.002;
    
    
    
    axis([0 640 0 480])
    
    drawnow;
    
    
    
    
end





