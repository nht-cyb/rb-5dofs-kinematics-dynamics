function [xE,yE,zE] = fcn(q1,q2,q3,q4,q5)

[L1,L2,a2,L3,L4,L5]=parameter5DOF();

xE=((L4 + L5) * cos(q4) + a2) * cos(q2) + q1;
yE=sin(q2) * ((L4 + L5) * cos(q4) + a2);
zE=(-L4 - L5) * sin(q4) + q3 + L2;
end

