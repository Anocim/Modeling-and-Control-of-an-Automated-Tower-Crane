function [Tau] = Control(in)

qr1      = in(1);
qr2      = in(2);
qr3      = in(3);
qr4      = in(4);
qr5      = in(5);
qdr1     = in(6);
qdr2     = in(7);
qdr3     = in(8);
qdr4     = in(9);
qdr5     = in(10);
qddr1    = in(11);
qddr2    = in(12);
qddr3    = in(13);
qddr4    = in(14);
qddr5    = in(15);
q1_       = in(16);
q2_       = in(17);
q3_       = in(18);
q4_       = in(19);
q5_       = in(20);
qd1_      = in(21);
qd2_      = in(22);
qd3_      = in(23);
qd4_      = in(24); 
qd5_      = in(25);

 % Tiempo de muestreo  (revisar el utilizado en Simulink)
 Tm=0.01; 
 paso=[];
 % A MODIFICAR POR EL ALUMNO
 
 e1=qr1-q1_;  ed1=qdr1-qd1_;
 e2=qr2-q2_;  ed2=qdr2-qd2_;
 e3=qr3-q3_;  ed3=qdr3-qd3_;
 e4=qr4-q4_;  ed4=qdr4-qd4_;
 e5=qr5-q5_;  ed5=qdr5-qd5_;

%% Sin Control aplicado
% Tau= [45700; zeros(2,1)];

%% Control PID

e=[e1;e2;e5];
ed=[ed1;ed2;ed5];

kp1= 9158000; Td1=0.5*9158000; Ti1= 0;
kp2= 0; Td2= 0; Ti2= 0;
kp5= 0; Td5= 0; Ti5= 0;

Kp=double([kp1;kp2;kp5]);
Ti=double([Ti1;Ti2;Ti5]);
Td=double([Td1;Td2;Td5]);

Tau=Kp.*e+Td.*ed;

%% Control LQR
 % e=[e1;e2;e3;e4;e5];
 % ed=[ed1;ed2;ed3;ed4;ed5];
 % 
 % if isempty(paso)
 %    paso=0;
 % 
 %    x = [q1_ q2_ q3_ q4_ q5_ qd1_ qd2_ qd3_ qd4_ qd5_]';
 %    u = [0 0 0]';
 % 
 %    A = A_grua(x,u);
 %    B = B_grua(x,u);
 % 
 %    Q = diag([200 10 200 200 10 1 1 10 10 1]); 
 % 
 %    R = diag([0.1 10 10]);
 % 
 %    format short e
 %    K = lqr(A, B, Q, R);
 % else
 %    paso= paso+1;
 % end

 % LQR Adaptativo
 % if paso==10
 % 
 %    paso=0;
 % 
 %    x = [q1_ q2_ q3_ q4_ q5_ qd1_ qd2_ qd3_ qd4_ qd5_]';
 %    u = [0 0 0]';
 % 
 %    A = A_grua(x,u);
 %    B = B_grua(x,u);
 % 
 %    Q = diag([200 10 200 200 10 1 1 10 10 1]); 
 % 
 %    R = diag([0.1 10 10]);
 % 
 %    format short e
 %    K = lqr(A, B, Q, R);
 % end
 % LQR lineal

%     K =    [ 1.9622e+01  -7.5060e+00   1.3222e+03   1.2202e+03  -1.1084e+02   6.8282e+03  -7.7824e+01  -2.2658e+02   2.1703e+03 -2.7751e+01;
%   -3.9233e+00   5.1995e+00  -5.9113e+03  -8.0672e+02   1.6800e+02  -1.6214e+03   5.0925e+00  -3.7095e+03  -9.0791e+03 6.7586e+01;
%   -8.7051e-01   5.4671e-01  -5.9047e+02  -7.9463e+02   6.4613e+01  -3.5860e+02   5.2722e+01   3.5699e+02  -1.0034e+03 1.4407e+01];
% 
% Tau= K * [e;ed];
% 
% Tau= [Tau(1);Tau(2);Tau(3)];

end