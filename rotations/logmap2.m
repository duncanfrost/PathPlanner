function [ mu ] = logmap2(in)
%LOGMAP2 This is the real deal lie algebra log map, seen in strasdats
%thesis. Works perfectly


mu = zeros(6,1);
R = in(1:3,1:3);
t = in(1:3,4);
arg = (trace(R) - 1)/2;




if (abs(arg-1) < 1e-15)
    arg = 1;
end


theta = acos(arg);

if theta == 0
    w = [0 0 0]';
    V = eye(3,3);
else
    w = invcrossnot(theta/(2*sqrt(1-arg^2))*(R-R'));
    V = eye(3,3) + ((1-cos(theta))/theta^2)*crossnot(w) + ((theta-sin(theta))/theta^3)*(crossnot(w)^2);
end


v = V\t;







mu(4:6) = w;
mu(1:3) = v;

end




function [C] = crossnot(w)

C = zeros(3,3);

C(1,2) = -w(3);
C(2,1) = w(3);

C(1,3) = w(2);
C(3,1) = -w(2);

C(3,2) = w(1);
C(2,3) = -w(1);

end


function [w] = invcrossnot(C)


w(1) = C(3,2);
w(2) = C(1,3);
w(3) = C(2,1);



end

