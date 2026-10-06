clc
clear
clear all

%% Parameters
[L1,L2,a2,L3,L4,L5]=Parameter5DOF();

%% Vi tri ban dau cua diem thao tac E
xx_0=3.24;yy_0=0;zz_0=4.24;
X_0=[xx_0;yy_0;zz_0];% Vec to vi tri E
% Gia tri gan dung cua goc khop ban dau, su dung auto cad de xac dinh
q1_0=1;q2_0=0;q3_0=0.5;q4_0=-pi/6;q5_0=0;

%% Tinh chinh xac gia tri goc khop ban dau q_0
for n=1:1:10^10
    Jnd_0=TinhJnd(q1_0,q2_0,q3_0,q4_0,q5_0); % Tinh ma tran Jacobian theo q_0
    [xE_0,yE_0,zE_0]=DongHocThuan(q1_0,q2_0,q3_0,q4_0,q5_0);% tinh lai xx_0, yy_0 theo q_0
    XX_0=[xE_0;yE_0;zE_0];
    delta_q_0 = Jnd_0*(X_0 - XX_0);% Tinh gia tri hieu chinh delta_q_0
    % Tinh lai cac gia tri q_0 hieu chinh
    q1_0 = q1_0 + delta_q_0(1,1);
    q2_0 = q2_0 + delta_q_0(2,1);
    q3_0 = q3_0 + delta_q_0(3,1);
    q4_0 = q4_0 + delta_q_0(4,1);
    q5_0 = q5_0 + delta_q_0(5,1);
    
    % khai bao do chinh xac can thiet va tao vong lap tinh toan
    ss=10^(-10);
    if abs(delta_q_0(1,1)) < ss 
        if abs(delta_q_0(2,1)) < ss
            if abs(delta_q_0(3,1)) < ss     
                if abs(delta_q_0(4,1)) < ss 
                    if abs(delta_q_0(5,1)) < ss
            break
                    end
                end
            end
        end
    end
    n;
end
% Xac nhan cac gia tri q_0 chinh xac sau khi hieu chinh
q1=q1_0;
q2=q2_0;
q3=q3_0;
q4=q4_0;
q5=q5_0;

%% Thuat toan ap dung cho toan bo quy dao x, y, z cho truoc
% bien thoi gian
dt=0.1; % Khai bao buoc thoi gian chay
t_max=6; % Khai bao thoi gian voi van toc goc bang pi/3

%% QUY DAO
for t=0:dt:t_max
[Xd,dXd]=Quydao(t); % Vi tri va van toc diem E cho truoc theo thoi gian t
Jnd=TinhJnd(q1,q2,q3,q4,q5); % Tinh ma tran Jacobian theo q
dX=[dXd(1);dXd(2);dXd(3)]; % Vec to van toc diem thao tac E cho truoc
q=[q1;q2;q3;q4;q5];
dq=Jnd*dX; % Van toc goc khop
for k=1:1:10^5
    q_k=q + dq*dt; % Tinh gia tri goc khop trong vong lap bien k
    q1=q_k(1,1);
    q2=q_k(2,1);
    q3=q_k(3,1);
    q4=q_k(4,1);
    q5=q_k(5,1);
    Jnd_real=TinhJnd(q1,q2,q3,q4,q5); % Tinh lai gia tri ma tran Jacobian
    [xE,yE,zE]=DongHocThuan(q1,q2,q3,q4,q5); % Tinh lai quy dao diem E tu q tim duoc
    Xq=[xE;yE;zE];
    [Xd,dXd]=Quydao(t);% Goi quy dao mong muon
    Xm=[Xd(1);Xd(2);Xd(3)];
    Delta_q = Jnd_real*(Xm - Xq);% Tinh sai lech goc khop
    % khai bao do chinh xac can thiet
    ss1=10^(-5);
    if abs(Delta_q(1,1)) < ss1 
        if abs(Delta_q(2,1)) < ss1
            if abs(Delta_q(3,1)) < ss1 
                if abs(Delta_q(4,1)) < ss1   
                    if abs(Delta_q(5,1)) < ss1   
            break
                    end
                end
            end
        end
    end     
end
    k;
    % Tinh lai gia tri goc khop chinh xac
    q1 = q1 + Delta_q(1,1);
    q2 = q2 + Delta_q(2,1);
    q3 = q3 + Delta_q(3,1);
    q4 = q4 + Delta_q(4,1);
    q5 = q5 + Delta_q(5,1);
    
%% Tinh lai quy dao lan nua
  [xE_tinhlai,yE_tinhlai,zE_tinhlai]=DongHocThuan(q1,q2,q3,q4,q5);
  
%% 
% Thiet lap vecto sai so quy dao
eX=xE-xE_tinhlai;
eY=yE-yE_tinhlai;
eZ=zE-zE_tinhlai;

%% Ve do thi
% Do thi cac bien khop - ket qua bai toan dong hoc nguoc
figure(1)
    plot(t,q1,'r.',t,q2,'g.',t,q3,'b.',t,q4,'k.',t,q5,'y.')
    xlabel('time (sec)')
    ylabel('Bien khop q1, q2, q3,q4 va q5')
    hold on
    grid on
 % Do thi quy dao thao tac
 figure(2)
    plot(t,xE_tinhlai,'r.',t,yE_tinhlai,'g.',t,zE_tinhlai,'b.')
    xlabel('time (sec)')
    ylabel('Do thi quy dao thao tac tinh lai')
    hold on
    grid on
 % Do thi sai so quy dao thao tac
 figure(3)
    plot(t,eX,'r.')
    xlabel('time (sec)')
    ylabel('Do thi quy dao thao tac tinh lai')
    hold on
    grid on
figure(4)
    plot(t,eY,'g.')
    xlabel('time (sec)')
    ylabel('Do thi quy dao thao tac tinh lai')
    hold on
    grid on
figure(5)
    plot(t,eZ,'b.')
    xlabel('time (sec)')
    ylabel('Do thi quy dao thao tac tinh lai')
    hold on
    grid on

%% Bieu dien Robot chuyen dong de kiem tra tinh chinh xac tu q1, q2, q3, q4, q5 tim duoc
% Do thi mo phong 3D
 figure(6)
  P1=[0 0 0];
  viscircles([P1(3) P1(2)],0.005,'Color','r');
% Mo phong quy dao
curve=animatedline('Linewidth',1.5);
set(gca,'xlim',[-5 5],'Ylim',[-5 7],'Zlim',[0 7]);
view(43,24);
xlabel('X(m)');
ylabel('Y(m)');
zlabel('Z(m)'); 

%%
% Diem goc 0
for t_q1=0:0.1:1
    x1=0;
    y1=0;
    z1=0;
    plot3(x1,y1,z1,'r.',0,0,0,'r.')
    grid on
    hold on
end
% Diem A
for t_q1=0:0.1:1
    xA=0;
    yA=L1*t_q1;
    zA=0;
    plot3(xA,yA,zA,'c.',0,L1,0,'c.')
    grid on
    hold on
end
% Diem O2
for t_q2=0:0.05:1
    x2=0;
    y2=q1*t_q2;
    z2=0;
    plot3(x2,y2,z2,'g.',0,q1,0,'g.')
    grid on
    hold on
end
% Diem O2.5
for t_q25=0:0.05:1
    x25=0;
    y25=y2;
    z25=L2*t_q25;
    
    X25=0;
    Y25=q1;
    Z25=L2;
    
    plot3(x25,y25,z25,'g.',X25,Y25,Z25,'r.')
    grid on
    hold on
end
% Diem O3
for t_q3=0:0.1:1
    x3=a2 * cos(q2)*t_q3 + q1;
    y3=a2 * sin(q2)*t_q3;
    z3=z25;
    
    X3=a2 * cos(q2) + q1;
    Y3=a2 * sin(q2);
    Z3=L2;
    
    plot3(x3,y3,z3,'r.',X3,Y3,Z3,'r.')
    grid on
    hold on
end
% Diem B

for t_qB=0:0.1:1
    xB=x3;
    yB=y3; 
    zB=z3 + (-L3+q3)*t_qB;
    
    XB=a2 * cos(q2) + q1;
    YB=a2 * sin(q2); 
    ZB=L2 + q3 - L3;
    
    plot3(xB,yB,zB,'g.',XB,YB,ZB,'g.')
    grid on
    hold on
end
% Diem O4
for t_q4=0:0.1:1
    x4=x3;
    y4=y3; 
    z4=q3*t_q4+z3;
    
    X4=a2 * cos(q2) + q1;
    Y4=a2 * sin(q2); 
    Z4=q3 + L2;
    
    plot3(x4,y4,z4,'b.',X4,Y4,Z4,'b.')
    grid on
    hold on
end
% Diem O5
for t_q5=0:0.1:1
    x5=cos(q2)*L4*cos(q4)*t_q5 + x4;
    y5=sin(q2)*L4*cos(q4)*t_q5 + y4; 
    z5=-L4*sin(q4)*t_q5 + z4; 

    X5=cos(q2) * (L4 * cos(q4) + a2) + q1;
    Y5=sin(q2) * (L4 * cos(q4) + a2); 
    Z5=-L4 * sin(q4) + q3 + L2;
    
    plot3(x5,y5,z5,'b.',X5,Y5,Z5,'b.')
    grid on
    hold on
end
% Diem E
for t_qE=0:0.1:1  

    xE=x5 + L5*cos(q4)*cos(q2)*t_qE;
    yE=y5 + L5*cos(q4)*sin(q2)*t_qE;
    zE=z5 - L5*sin(q4)*t_qE;
    
    XE=((L4 + L5) * cos(q4) + a2) * cos(q2) + q1;
    YE=sin(q2) * ((L4 + L5) * cos(q4) + a2);
    ZE=(-L4 - L5) * sin(q4) + q3 + L2;
   
    
    plot3(xE,yE,zE,'b.',XE,YE,ZE,'r.')
    grid on
    hold on
end
M(:,:) = getframe;
pause(0.05) 
hold on
grid on
end





































