
%Valores iniciales

syms s k Ti Td q5 q4 q3 q2 q1 qd1 qdd1 qd2 qdd2 qd3 qdd3 qd4 qdd4 qd5 qdd5 g real


Ma_ne =[cos(q3)*(cos(q3)*(20.0*q2 + 350.0)*(2.0*q2 + 15.0*cos(q4)*sin(q3) + 2.0*q5*cos(q4)*sin(q3) + 35.0) + cos(q3)*sin(q4)^2*(40.0*q5^2 + 600.0*q5 + 3000.0)) + sin(q3)*(750.0*sin(q3) + (40.0*q5 + 300.0)*(17.5*cos(q4) + 7.5*sin(q3) + q2*cos(q4) + q5*sin(q3)) + sin(q3)*(20.0*q2 + 350.0)*(2.0*q2 + 15.0*cos(q4)*sin(q3) + 2.0*q5*cos(q4)*sin(q3) + 35.0)) + 9.12e+6,     20.0*sin(q4)*(2.0*q5 + 15.0), 0.0833*cos(q3)*cos(q4)*sin(q4)*(480.0*q5^2 + 7200.0*q5 + 3.6e+4), - 5250.0*cos(q4) - 3000.0*sin(q3) - 40.0*q5^2*sin(q3) - 300.0*q2*cos(q4) - 700.0*q5*cos(q4) - 600.0*q5*sin(q3) - 40.0*q2*q5*cos(q4), -40.0*sin(q4)*(q2 + 17.5);
                                                                                                                                                                                                                                                                                                                                      20.0*sin(q4)*(2.0*q5 + 15.0),                             68.5,                             20.0*cos(q3)*cos(q4)*(2.0*q5 + 15.0),                                                                                               -20.0*sin(q3)*sin(q4)*(2.0*q5 + 15.0),      40.0*cos(q4)*sin(q3);
                                                                                                                                                                                                                                                                                                           cos(q3)*cos(q4)*sin(q4)*(40.0*q5^2 + 600.0*q5 + 3000.0),  40.0*cos(q3)*cos(q4)*(q5 + 7.5),                        cos(q4)^2*(40.0*q5^2 + 600.0*q5 + 3000.0),                                                                                                                                   0,                         0;
                                                                                                                                                                                                                                                                    - 750.0*sin(q3) - 1.0*(40.0*q5 + 300.0)*(17.5*cos(q4) + 7.5*sin(q3) + q2*cos(q4) + q5*sin(q3)), -40.0*sin(q3)*sin(q4)*(q5 + 7.5),                                                                0,                                                                                                           40.0*(q5 + 7.5)^2 + 750.0,                         0;
                                                                                                                                                                                                                                                                                                                                         -40.0*sin(q4)*(q2 + 17.5),             40.0*cos(q4)*sin(q3),                                                                0,                                                                                                                                   0,                     886.0];
 
Va_ne = [ 
1700.0*qd1 + 5250.0*qd4^2*sin(q4) + 1400.0*qd1*qd2 + 600.0*qd1*qd5 - 6000.0*qd3*qd4*cos(q3) - 1400.0*qd4*qd5*cos(q4) - 600.0*qd4*qd5*sin(q3) + 300.0*q2*qd4^2*sin(q4) + 700.0*q5*qd4^2*sin(q4) + 80.0*q2*qd1*qd2 + 80.0*q5*qd1*qd5 - 1.05e+4*qd1*qd4*sin(q3)*sin(q4) + 6000.0*qd3*qd4*cos(q3)*cos(q4)^2 - 80.0*q2*qd4*qd5*cos(q4) - 1200.0*q5*qd3*qd4*cos(q3) - 80.0*q5*qd4*qd5*sin(q3) - 600.0*qd1*qd5*cos(q3)^2*cos(q4)^2 - 3000.0*qd3^2*cos(q4)*sin(q3)*sin(q4) - 80.0*q5^2*qd3*qd4*cos(q3) + 1.05e+4*qd1*qd3*cos(q3)*cos(q4) + 40.0*q2*q5*qd4^2*sin(q4) + 600.0*qd1*qd2*cos(q4)*sin(q3) + 1400.0*qd1*qd5*cos(q4)*sin(q3) - 80.0*q5*qd1*qd5*cos(q3)^2*cos(q4)^2 + 80.0*q5^2*qd3*qd4*cos(q3)*cos(q4)^2 + 6000.0*qd1*qd3*cos(q3)*cos(q4)^2*sin(q3) + 6000.0*qd1*qd4*cos(q3)^2*cos(q4)*sin(q4) - 600.0*q5*qd3^2*cos(q4)*sin(q3)*sin(q4) + 600.0*q2*qd1*qd3*cos(q3)*cos(q4) + 1400.0*q5*qd1*qd3*cos(q3)*cos(q4) + 80.0*q2*qd1*qd5*cos(q4)*sin(q3) + 80.0*q5*qd1*qd2*cos(q4)*sin(q3) - 600.0*q2*qd1*qd4*sin(q3)*sin(q4) - 1400.0*q5*qd1*qd4*sin(q3)*sin(q4) - 40.0*q5^2*qd3^2*cos(q4)*sin(q3)*sin(q4) + 1200.0*q5*qd3*qd4*cos(q3)*cos(q4)^2 + 600.0*qd3*qd5*cos(q3)*cos(q4)*sin(q4) + 80.0*q5*qd3*qd5*cos(q3)*cos(q4)*sin(q4) + 1200.0*q5*qd1*qd3*cos(q3)*cos(q4)^2*sin(q3) + 1200.0*q5*qd1*qd4*cos(q3)^2*cos(q4)*sin(q4) + 80.0*q2*q5*qd1*qd3*cos(q3)*cos(q4) - 80.0*q2*q5*qd1*qd4*sin(q3)*sin(q4) + 80.0*q5^2*qd1*qd3*cos(q3)*cos(q4)^2*sin(q3) + 80.0*q5^2*qd1*qd4*cos(q3)^2*cos(q4)*sin(q4);
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   352.0*qd2 - 40.0*q2*qd1^2 - 700.0*qd1^2 + 600.0*qd1*qd4*cos(q4) + 80.0*qd1*qd5*sin(q4) - 300.0*qd1^2*cos(q4)*sin(q3) - 300.0*qd3^2*cos(q4)*sin(q3) - 300.0*qd4^2*cos(q4)*sin(q3) - 80.0*qd4*qd5*sin(q3)*sin(q4) - 40.0*q5*qd1^2*cos(q4)*sin(q3) - 40.0*q5*qd3^2*cos(q4)*sin(q3) - 40.0*q5*qd4^2*cos(q4)*sin(q3) + 80.0*q5*qd1*qd4*cos(q4) + 80.0*qd3*qd5*cos(q3)*cos(q4) - 600.0*qd3*qd4*cos(q3)*sin(q4) - 80.0*q5*qd3*qd4*cos(q3)*sin(q4);
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     -0.0833*cos(q4)*(6.3e+4*qd1^2*cos(q3) - 7200.0*qd3*qd5*cos(q4) + 7.2e+4*qd3*qd4*sin(q4) + 3600.0*q2*qd1^2*cos(q3) + 8400.0*q5*qd1^2*cos(q3) - 960.0*q5*qd3*qd5*cos(q4) + 1.44e+4*q5*qd3*qd4*sin(q4) + 3.6e+4*qd1^2*cos(q3)*cos(q4)*sin(q3) + 480.0*q2*q5*qd1^2*cos(q3) - 7.2e+4*qd1*qd4*cos(q3)*cos(q4) + 960.0*q5^2*qd3*qd4*sin(q4) - 7200.0*qd1*qd5*cos(q3)*sin(q4) + 7200.0*q5*qd1^2*cos(q3)*cos(q4)*sin(q3) - 1.44e+4*q5*qd1*qd4*cos(q3)*cos(q4) - 960.0*q5*qd1*qd5*cos(q3)*sin(q4) + 480.0*q5^2*qd1^2*cos(q3)*cos(q4)*sin(q3) - 960.0*q5^2*qd1*qd4*cos(q3)*cos(q4));
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  600.0*qd4*qd5 - 1500.0*qd3^2*sin(2.0*q4 + 3.14) - 6000.0*qd1*qd3*cos(q3) - 600.0*qd1*qd5*sin(q3) - 20.0*q5^2*qd3^2*sin(2.0*q4 + 3.14) - 5250.0*qd1^2*cos(q4 + 1.57)*sin(q3) + 80.0*q5*qd4*qd5 - 300.0*q5*qd3^2*sin(2.0*q4 + 3.14) - 600.0*qd1*qd2*sin(q4 + 1.57) + 6000.0*qd1*qd3*cos(q4 + 1.57)^2*cos(q3) - 300.0*q2*qd1^2*cos(q4 + 1.57)*sin(q3) - 700.0*q5*qd1^2*cos(q4 + 1.57)*sin(q3) - 80.0*q5*qd1*qd2*sin(q4 + 1.57) - 1200.0*q5*qd1*qd3*cos(q3) - 80.0*q5*qd1*qd5*sin(q3) + 3000.0*qd1^2*cos(q4 + 1.57)*sin(q4 + 1.57)*cos(q3)^2 - 80.0*q5^2*qd1*qd3*cos(q3) + 600.0*q5*qd1^2*cos(q4 + 1.57)*sin(q4 + 1.57)*cos(q3)^2 + 40.0*q5^2*qd1^2*cos(q4 + 1.57)*sin(q4 + 1.57)*cos(q3)^2 + 1200.0*q5*qd1*qd3*cos(q4 + 1.57)^2*cos(q3) - 40.0*q2*q5*qd1^2*cos(q4 + 1.57)*sin(q3) + 80.0*q5^2*qd1*qd3*cos(q4 + 1.57)^2*cos(q3);
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      4070.0*qd5 - 300.0*qd3^2*cos(q4)^2 - 40.0*q5*qd1^2 - 40.0*q5*qd4^2 - 300.0*qd1^2 - 300.0*qd4^2 - 80.0*qd1*qd2*sin(q4) + 600.0*qd1*qd4*sin(q3) + 300.0*qd1^2*cos(q3)^2*cos(q4)^2 - 40.0*q5*qd3^2*cos(q4)^2 - 700.0*qd1^2*cos(q4)*sin(q3) + 40.0*q5*qd1^2*cos(q3)^2*cos(q4)^2 - 40.0*q2*qd1^2*cos(q4)*sin(q3) + 80.0*q5*qd1*qd4*sin(q3) - 600.0*qd1*qd3*cos(q3)*cos(q4)*sin(q4) - 80.0*q5*qd1*qd3*cos(q3)*cos(q4)*sin(q4)];

Ga_ne =[
                               0;
                               0;
392.0*cos(q4)*sin(q3)*(q5 + 7.5);
392.0*cos(q3)*sin(q4)*(q5 + 7.5);
          -392.0*cos(q3)*cos(q4)];


%%%%%%%%%%----- Se sustituyen los valores que se conocen y son deseados -----%%%%%%%%%% 
Ma_ne= subs(Ma_ne,q3,0);
Ma_ne= subs(Ma_ne,q4,0);

Va_ne= subs(Va_ne,q3,0);
Va_ne= subs(Va_ne,q4,0);

%%%%%%%%%%----- Diagonalización de Ma_ne -----%%%%%%%%%%
Ma_ne=diag(Ma_ne);

%%%%%%%%%%----- Dependencia de la qdi únicamente -----%%%%%%%%%%
Va_ne= [ diff(Va_ne(1),qd1);
         diff(Va_ne(1),qd2);
         diff(Va_ne(1),qd3);
         diff(Va_ne(1),qd4);
         diff(Va_ne(1),qd5)];

%%%%%%%%%%----- Anulación de Ga_ne -----%%%%%%%%%%
Ga_ne = zeros(3,1);

%%%%%%%%%%----- Maximizar Ma_ne -----%%%%%%%%%%
Ma_ne= subs(Ma_ne,q2,14);

Ma_ne = double([Ma_ne(1); Ma_ne(2); 0; 0; Ma_ne(5)]);
Va_ne = [1700; 0; 0; 0; 0];

%% 
Tau1= Ma_ne(1)*qdd1+ Va_ne(1)*qd1;
Tau2= Ma_ne(2)*qdd2+ Va_ne(2)*qd2;
Tau3= Ma_ne(5)*qdd5+ Va_ne(5)*qd5;


Tau1= Ma_ne(1)*q1*s^2+ Va_ne(1)*q1*s;
Tau2= Ma_ne(2)*q2*s^2+ Va_ne(2)*q2*s;
Tau3= Ma_ne(5)*q5*s^2+ Va_ne(5)*q5*s;

G11= tf(1,[Ma_ne(1), Va_ne(1), 0])
G22= tf(1,[Ma_ne(2), Va_ne(2), 0])
G33= tf(1,[Ma_ne(5), Va_ne(5), 0])

%% Valores del controlador PD tm=0.1
kp1= 897630000; Td1=0.2*897630000; Ti1= 0;
kp2= 6776.4; Td2= 0.2*6776.4; Ti2= 0;
kp5= 88187; Td5= 0.2*88187; Ti5= 0;

%% Valores del controlador PD tm=0.01
kp1= 91597000000; Td1=0.2*91597000000; Ti1= 0;
kp2= 685000; Td2= 0.2*685000; Ti2= 0;
kp5= 8860000; Td5= 0.02*8860000; Ti5= 0;
