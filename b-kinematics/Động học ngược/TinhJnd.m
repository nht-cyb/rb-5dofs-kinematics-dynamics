function Jnd=TinhJnd(q1,q2,q3,q4,q5)
[L1,L2,a2,L3,L4,L5]=parameter5DOF();
%% Jacobian
%J=zeros(3,3);
J11=1;
J12=-sin(q2) * ((L4 + L5) * cos(q4) + a2);
J13=0;
J14=-(L4 + L5) * sin(q4) * cos(q2);
J15=0;

J21=0;
J22=((L4 + L5) * cos(q4) + a2) * cos(q2);
J23=0;
J24= -sin(q2) * (L4 + L5) * sin(q4);
J25=0;

J31=0;
J32=0;
J33=1;
J34=(-L4 - L5) * cos(q4);
J35=0;

J=[J11 J12 J13 J14 J15; J21 J22 J23 J24 J25; J31 J32 J33 J34 J35];

%% Chuyen vi Jacobian
Jt=J';
%% Jacobi tua nghich dao
Jnd = (Jt*inv(J*Jt));


