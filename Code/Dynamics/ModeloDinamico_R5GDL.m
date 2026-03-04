function [qdd] = ModeloDinamico_R5GDL(in)
q1        = in(1);
q2        = in(2);
q3        = in(3);
q4        = in(4);
q5        = in(5);
qd1       = in(6);
qd2       = in(7);
qd4       = in(8);
qd5       = in(9);
qd3       = in(10);
Tau1      = in(11);
Tau2      = in(12);
Tau3      = in(13);
Tau4      = in(14);
Tau5      = in(15);
modelo    = in(16);

% A rellenar por el alumno

T=[Tau1;Tau2;Tau3;Tau4;Tau5];
g=9.81;

if modelo==1

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
                                   0
                                   0
    392.0*cos(q4)*sin(q3)*(q5 + 7.5)
    392.0*cos(q3)*sin(q4)*(q5 + 7.5)
              -392.0*cos(q3)*cos(q4)];
elseif modelo==2
    
    Ma_ne =[1140.0*q2^2 + 1.02e+4,      0, 0, 0,     0;
                    0, 1140.0, 0, 0,     0;
                    0,      0, 0, 0,     0;
                    0,      0, 0, 0,     0;
                    0,      0, 0, 0, 0.027];
 

    Va_ne =[
     
    0.001*qd1*(2.28e+6*q2*qd2 + 191.0);
         - 1140.0*q2*qd1^2 + 0.042*qd2;
                                     0;
                                     0;
                              0.13*qd5];
 
    Ga_ne =[0; 0; 0; 0; 0];
end


Ma_ne= double(Ma_ne);
Va_ne= double(Va_ne);
Ga_ne= double(Ga_ne);

 
% Ma, Ga y Va provienen del cálculo iterativo de Newton-Euler

% Aceleraciones
  qdd = Ma_ne\(T-Ga_ne-Va_ne);
  qdd = round(qdd,2);
  
end