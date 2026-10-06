%% CHUONG TRINH TINH KHONG GIAN LAM VIEC
clc
clear 
close all
% Thong so cac khau
[L1,L2,a2,L3,L4,L5]=parameter5DOF();
% Gioi han cac khau
q1s=0;        q1f=2;
q2s=-pi;      q2f=pi;
q3s=0;        q3f=1.5;
q4s=-2*pi/3;  q4f=pi/3;
%q5s=-pi/2;  q5f=pi/2;
% Toa do diem cuoi cac khau o thoi diem ban dau
 q01=1; q02=0; q03=0.5; q04=-pi/6; %q05=-pi/2;
% Diem goc O
x01=0;  y01=0;  z01=0;
% Diem A
x0A=0;  y0A=L1; z0A=0;
% Diem O2
x02=0;  y02=q01; z02=0;
% Diem O2.5
x025=0;
y025=q01;
z025=L2;
% Diem O3
x03=a2 * cos(q02) + q01;
y03=a2 * sin(q02);
z03=L2;
% Diem B
x0B=a2 * cos(q02) + q01;
y0B=a2 * sin(q02); 
z0B=L2 + q03 + L3;
% Diem O4
x04=a2 * cos(q02) + q01;
y04=a2 * sin(q02); 
z04=q03 + L2;
% Diem O5
x05=cos(q02) * (L4 * cos(q04) + a2) + q01;
y05=sin(q02) * (L4 * cos(q04) + a2); 
z05=-L4 * sin(q04) + q03 + L2;
% Diem E
x0E=((L4 + L5) * cos(q04) + a2) * cos(q02) + q01;
y0E=sin(q02) * ((L4 + L5) * cos(q04) + a2);
z0E=(-L4 - L5) * sin(q04) + q03 + L2;

X=[x01 x0A x02 x025 x03 x0B x04 x05 x0E];
Y=[y01 y0A y02 y025 y03 y0B y04 y05 y0E];
Z=[z01 z0A z02 z025 z03 z0B z04 z05 z0E];
Tool = plot3(X,Y,Z,'ro-','Linewidth',3,'XDataSource','X','YDataSource','Y','ZDataSource','Z');
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');
view([1 1 1])
set(gca,'DataAspectRatio',[1 1 1]);
grid on
hold('on')

% Tao gia tri cac bien khop ngau nhien
for q1 = q1s:0.5:q1f
    for q2 = q2s:0.25:q2f
        for q3 = q3s:0.5:q3f
            for q4 = q4s:0.25:q4f   
% Ve quy dao cua 4 khau
% Diem goc 0
X1=0;   Y1=0; Z1=0;
% Diem A
XA=0;   YA=L1; ZA=0;
% Diem O2
X2=0;   Y2=q1; Z2=0;
% Diem O2.5
X25=0;
Y25=q1;
Z25=L2;
% Diem O3
X3=a2 * cos(q2) + q1;
Y3=a2 * sin(q2);
Z3=L2;
% Diem B
XB=a2 * cos(q2) + q1;
YB=a2 * sin(q2); 
ZB=L2 + q3 - L3;
% Diem O4
X4=a2 * cos(q2) + q1;
Y4=a2 * sin(q2); 
Z4=q3 + L2;
% Diem O5
X5=cos(q2) * (L4 * cos(q4) + a2) + q1;
Y5=sin(q2) * (L4 * cos(q4) + a2); 
Z5=-L4 * sin(q4) + q3 + L2;
% Diem E
XE=((L4 + L5) * cos(q4) + a2) * cos(q2) + q1;
YE=sin(q2) * ((L4 + L5) * cos(q4) + a2);
ZE=(-L4 - L5) * sin(q4) + q3 + L2;

X=[X1 XA X2 X25 X3 XB X4 X5 XE];
Y=[Y1 YA Y2 Y25 Y3 YB Y4 Y5 YE];
Z=[Z1 ZA Z2 Z25 Z3 ZB Z4 Z5 ZE];
% Toa do diem thao tac
XE=((L4 + L5) * cos(q4) + a2) * cos(q2) + q1;
YE=sin(q2) * ((L4 + L5) * cos(q4) + a2);
ZE=(-L4 - L5) * sin(q4) + q3 + L2;
% Hien thi so lieu
q=[q1;q2;q3;q4];
XX=[XE;YE;ZE];
% Ve do thi diem thao tac
plot3 (XE,YE,ZE, 'b.') % Diem thao tac mau xanh
refreshdata(Tool,'caller')
drawnow                
            end
        end
    end
end





