function [Xd,dXd]=Quydao(t)
[L1,L2,a2,L3,L4,L5]=parameter5DOF();
Xd(1)=3.24; %m
Xd(2)=0.5*sin(pi*t/3); %m
Xd(3)=4.24+0.5*cos(pi*t/3); %m

dXd(1)=0;
dXd(2)=0.5*(pi/3)*cos(pi*t/3);
dXd(3)=0.5*(-pi/3)*sin(pi*t/3);
end
