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
q1       = in(16);
q2       = in(17);
q3       = in(18);
q4       = in(19);
q5       = in(20);
qd1      = in(21);
qd2      = in(22);
qd3      = in(23);
qd4      = in(24); 
qd5      = in(25);

 % Tiempo de muestreo  (revisar el utilizado en Simulink)
 Tm=0.01; 

 % A MODIFICAR POR EL ALUMNO
 
 e1=qr1-q1;  ed1=qdr1-qd1;
 e2=qr2-q2;  ed2=qdr2-qd2;
 e3=qr3-q3;  ed3=qdr3-qd3;
 e4=qr4-q4;  ed4=qdr4-qd4;
 e5=qr5-q5;  ed5=qdr5-qd5;

 e=[e1;e2;e3;e4;e5];
 ed=[ed1;ed2;ed3;ed4;ed5];
  
 %%
kp1= 897630000; Td1=0.2*897630000; Ti1= 0;
kp2= 6776.4; Td2= 0.2*6776.4; Ti2= 0;
kp5= 88187; Td5= 0.2*88187; Ti5= 0;

Kp=double([kp1;kp2;0;0;kp5]);
Ti=double([Ti1;Ti2;0;0;Ti5]);
Td=double([Td1;Td2;0;0;Td5]);
  
Tau=Kp.*e+Td.*ed;
% Tau=zeros(5,1);

end