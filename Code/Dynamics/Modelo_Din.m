function [Ma_ne,Va_ne,Ga_ne] = Modelo_Din(in)
clc

Tipo_modelo = in;

% Definición de variables simbólicas
syms T1 T2 T3 T4 T5 q1 qd1 qdd1 q2 qd2 qdd2 q3 qd3 qdd3 q4 qd4 qdd4 q5 qd5 qdd5 real  
PI = pi; 

% Definición de constantes
L0 = sym(45); % m
L1B = sym(35); % m 
L1A = sym(35/2); % m
L2 = sym(15); % m
Lcp = sym(10); % m

M0 = sym(7991.3); % kg
M1 = sym(1236);  % kg
M5 = sym(40); % kg
m = 0; % kg
Mcp = sym(7400); % kg

R = sym(1.2); % m

jm1 = sym(360e-4);  % kg*m^2
jm2 = sym(34e-4);  % kg*m^2
jm3 = 0;  % kg*m^2
jm4 = 0;  % kg*m^2
jm5 = sym(270e-4);  % kg*m^2

bm1 = sym(0.191);  % N*m*s
bm2 = sym(0.042);  % N*m*s
bm3 = 0;  % N*m*s
bm4 = 0;  % N*m*s
bm5 = sym(0.130);  % N*m*s

R1 = sym(94.21);
R2 = sym(91.53);
R5 = sym(177);

J0=  10215; % kg*m^2

g=sym(9.81); % m/s^2

% Elección entre modelo simplificado (S) o completo (C)
  if ( (Tipo_modelo ~= 'S') && (Tipo_modelo ~='C')); error('Elegir S o C para Tipo_modelo'); end


  if (Tipo_modelo=='S') 
      Mt = 1140.75; % kg

    Ma_ne=[J0 + jm1 + Mt*q2^2 + m*q2^2 + m*q5^2 - 1.0*m*q5^2*cos(q3)^2*cos(q4)^2 + 2.0*m*q2*q5*cos(q4)*sin(q3),              m*q5*sin(q4), m*q5^2*cos(q3)*cos(q4)*sin(q4), -1.0*m*q5*(q2*cos(q4) + q5*sin(q3)), -1.0*m*q2*sin(q4);
m*q5*sin(q4),              Mt + jm2 + m,           m*q5*cos(q3)*cos(q4),           -1.0*m*q5*sin(q3)*sin(q4), m*cos(q4)*sin(q3);
m*q5^2*cos(q3)*cos(q4)*sin(q4),      m*q5*cos(q3)*cos(q4),         m*q5^2*cos(q4)^2 + jm3,                                   0,                 0;
-1.0*m*q5*(q2*cos(q4) + q5*sin(q3)), -1.0*m*q5*sin(q3)*sin(q4),                              0,                        m*q5^2 + jm4,                 0;
-1.0*m*q2*sin(q4),         m*cos(q4)*sin(q3),                              0,                                   0,           jm5 + m];

    Va_ne= [bm1*qd1 + 2.0*Mt*q2*qd1*qd2 + 2.0*m*q2*qd1*qd2 + 2.0*m*q5*qd1*qd5 - 2.0*m*q5*qd4*qd5*sin(q3) - 2.0*m*q5^2*qd3*qd4*cos(q3) + m*q2*q5*qd4^2*sin(q4) - 2.0*m*q2*qd4*qd5*cos(q4) - 1.0*m*q5^2*qd3^2*cos(q4)*sin(q3)*sin(q4) - 2.0*m*q5*qd1*qd5*cos(q3)^2*cos(q4)^2 + 2.0*m*q5^2*qd3*qd4*cos(q3)*cos(q4)^2 + 2.0*m*q2*qd1*qd5*cos(q4)*sin(q3) + 2.0*m*q5*qd1*qd2*cos(q4)*sin(q3) + 2.0*m*q2*q5*qd1*qd3*cos(q3)*cos(q4) - 2.0*m*q2*q5*qd1*qd4*sin(q3)*sin(q4) + 2.0*m*q5^2*qd1*qd3*cos(q3)*cos(q4)^2*sin(q3) + 2.0*m*q5^2*qd1*qd4*cos(q3)^2*cos(q4)*sin(q4) + 2.0*m*q5*qd3*qd5*cos(q3)*cos(q4)*sin(q4);
bm2*qd2 - 1.0*m*q2*qd1^2 - 1.0*Mt*q2*qd1^2 + 2.0*m*qd1*qd5*sin(q4) + 2.0*m*qd3*qd5*cos(q3)*cos(q4) - 2.0*m*qd4*qd5*sin(q3)*sin(q4) - 1.0*m*q5*qd1^2*cos(q4)*sin(q3) - 1.0*m*q5*qd3^2*cos(q4)*sin(q3) - 1.0*m*q5*qd4^2*cos(q4)*sin(q3) + 2.0*m*q5*qd1*qd4*cos(q4) - 2.0*m*q5*qd3*qd4*cos(q3)*sin(q4);
bm3*qd3 + m*q5*cos(q4)*(2.0*qd3*qd5*cos(q4) - 1.0*q2*qd1^2*cos(q3) - 2.0*q5*qd3*qd4*sin(q4) + 2.0*qd1*qd5*cos(q3)*sin(q4) - 1.0*q5*qd1^2*cos(q3)*cos(q4)*sin(q3) + 2.0*q5*qd1*qd4*cos(q3)*cos(q4));
bm4*qd4 - 1.0*m*q5*(2.0*qd1*qd2*cos(q4) - 2.0*qd4*qd5 + 2.0*qd1*qd5*sin(q3) - 1.0*q5*qd3^2*cos(q4)*sin(q4) - 1.0*q2*qd1^2*sin(q3)*sin(q4) + q5*qd1^2*cos(q3)^2*cos(q4)*sin(q4) + 2.0*q5*qd1*qd3*cos(q3)*cos(q4)^2);
bm5*qd5 - 1.0*m*(q5*qd1^2 + q5*qd4^2 + 2.0*qd1*qd2*sin(q4) + q5*qd3^2*cos(q4)^2 - 1.0*q5*qd1^2*cos(q3)^2*cos(q4)^2 + q2*qd1^2*cos(q4)*sin(q3) - 2.0*q5*qd1*qd4*sin(q3) + 2.0*q5*qd1*qd3*cos(q3)*cos(q4)*sin(q4))];

    Ga_ne= [           0;
                       0;
              g*m*q5*cos(q4)*sin(q3);
              g*m*q5*cos(q3)*sin(q4);
            -1.0*g*m*cos(q3)*cos(q4)];
    
  else 
      Mt = 0; % kg

    Ma_ne=[0.33333*L1B^2*(M1 + Mcp) + Mt*(L1A + q2)^2 + R1^2*jm1 + 0.25*Mcp*(L1B + 2.0*Lcp)^2 + cos(q3)*(cos(q3)*sin(q4)^2*(0.33333*L2^2*M5 + 0.58333*L2^2*m + M5*q5^2 + m*q5^2 + L2*M5*q5 + L2*m*q5) + cos(q3)*(L1A + q2)*(cos(q4)*(M5 + m)*(L1A*cos(q4) + 0.5*L2*sin(q3) + q2*cos(q4) + q5*sin(q3)) + sin(q4)^2*(M5 + m)*(L1A + q2))) + sin(q3)*((M5 + m)*(0.5*L2 + q5)*(L1A*cos(q4) + 0.5*L2*sin(q3) + q2*cos(q4) + q5*sin(q3)) + 0.083333*L2^2*sin(q3)*(M5 + 4.0*m) + sin(q3)*(L1A + q2)*(cos(q4)*(M5 + m)*(L1A*cos(q4) + 0.5*L2*sin(q3) + q2*cos(q4) + q5*sin(q3)) + sin(q4)^2*(M5 + m)*(L1A + q2))),          0.5*sin(q4)*(M5 + m)*(L2 + 2.0*q5), 0.083333*cos(q3)*cos(q4)*sin(q4)*(4.0*L2^2*M5 + 7.0*L2^2*m + 12.0*M5*q5^2 + 12.0*m*q5^2 + 12.0*L2*M5*q5 + 12.0*L2*m*q5), - 0.33333*L2^2*M5*sin(q3) - 0.58333*L2^2*m*sin(q3) - 1.0*M5*q5^2*sin(q3) - 1.0*m*q5^2*sin(q3) - 0.5*L2*L1A*M5*cos(q4) - 0.5*L2*L1A*m*cos(q4) - 0.5*L2*M5*q2*cos(q4) - 1.0*L1A*M5*q5*cos(q4) - 1.0*L2*M5*q5*sin(q3) - 0.5*L2*m*q2*cos(q4) - 1.0*L1A*m*q5*cos(q4) - 1.0*M5*q2*q5*cos(q4) - 1.0*L2*m*q5*sin(q3) - 1.0*m*q2*q5*cos(q4), -1.0*sin(q4)*(M5 + m)*(L1A + q2);
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            0.5*sin(q4)*(M5 + m)*(L2 + 2.0*q5),                      jm2*R2^2 + M5 + Mt + m,                                                                              0.5*cos(q3)*cos(q4)*(M5 + m)*(L2 + 2.0*q5),                                                                                                                                                                                                                                                                                        -0.5*sin(q3)*sin(q4)*(M5 + m)*(L2 + 2.0*q5),         cos(q4)*sin(q3)*(M5 + m);
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            cos(q3)*cos(q4)*sin(q4)*(0.33333*L2^2*M5 + 0.58333*L2^2*m + M5*q5^2 + m*q5^2 + L2*M5*q5 + L2*m*q5),      cos(q3)*cos(q4)*(M5 + m)*(0.5*L2 + q5),               jm3 + cos(q4)*(0.083333*L2^2*cos(q4)*(M5 + 4.0*m) + (M5 + m)*(0.5*L2 + q5)*(0.5*L2*cos(q4) + q5*cos(q4))),                                                                                                                                                                                                                                                                                                                                  0,                                0;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                    - 1.0*(M5 + m)*(0.5*L2 + q5)*(L1A*cos(q4) + 0.5*L2*sin(q3) + q2*cos(q4) + q5*sin(q3)) - 0.083333*L2^2*sin(q3)*(M5 + 4.0*m), -1.0*sin(q3)*sin(q4)*(M5 + m)*(0.5*L2 + q5),                                                                                                                       0,                                                                                                                                                                                                                                                              jm4 + 0.083333*L2^2*(M5 + m) + 0.25*L2^2*m + (M5 + m)*(0.5*L2 + q5)^2,                                0;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              -1.0*sin(q4)*(M5 + m)*(L1A + q2),                    cos(q4)*sin(q3)*(M5 + m),                                                                                                                       0,                                                                                                                                                                                                                                                                                                                                  0,                jm5*R5^2 + M5 + m];
     
    Va_ne= [R1^2*bm1*qd1 + 2.0*M5*q2*qd1*qd2 + 2.0*M5*q5*qd1*qd5 + 2.0*Mt*q2*qd1*qd2 + 2.0*m*q2*qd1*qd2 + 2.0*m*q5*qd1*qd5 + L2*M5*qd1*qd5 + 2.0*L1A*M5*qd1*qd2 + 2.0*L1A*Mt*qd1*qd2 + L2*m*qd1*qd5 + 2.0*L1A*m*qd1*qd2 - 2.0*m*q5*qd4*qd5*sin(q3) - 0.66667*L2^2*M5*qd3*qd4*cos(q3) + 0.5*L2*L1A*m*qd4^2*sin(q4) + 0.5*L2*M5*q2*qd4^2*sin(q4) + L1A*M5*q5*qd4^2*sin(q4) - 1.1667*L2^2*m*qd3*qd4*cos(q3) - 2.0*M5*q5^2*qd3*qd4*cos(q3) + 0.5*L2*m*q2*qd4^2*sin(q4) + L1A*m*q5*qd4^2*sin(q4) + M5*q2*q5*qd4^2*sin(q4) - 2.0*m*q5^2*qd3*qd4*cos(q3) + m*q2*q5*qd4^2*sin(q4) - 2.0*L1A*M5*qd4*qd5*cos(q4) - 1.0*L2*M5*qd4*qd5*sin(q3) - 2.0*L1A*m*qd4*qd5*cos(q4) - 2.0*M5*q2*qd4*qd5*cos(q4) - 1.0*L2*m*qd4*qd5*sin(q3) - 2.0*M5*q5*qd4*qd5*sin(q3) - 2.0*m*q2*qd4*qd5*cos(q4) + 0.5*L2*L1A*M5*qd4^2*sin(q4) - 1.0*m*q5^2*qd3^2*cos(q4)*sin(q3)*sin(q4) - 2.0*L2*M5*q5*qd3*qd4*cos(q3) - 2.0*L2*m*q5*qd3*qd4*cos(q3) - 1.0*L2*M5*qd1*qd5*cos(q3)^2*cos(q4)^2 + 0.66667*L2^2*M5*qd3*qd4*cos(q3)*cos(q4)^2 - 1.0*L2*m*qd1*qd5*cos(q3)^2*cos(q4)^2 + 1.1667*L2^2*m*qd3*qd4*cos(q3)*cos(q4)^2 - 2.0*M5*q5*qd1*qd5*cos(q3)^2*cos(q4)^2 + 2.0*M5*q5^2*qd3*qd4*cos(q3)*cos(q4)^2 - 2.0*m*q5*qd1*qd5*cos(q3)^2*cos(q4)^2 + 2.0*m*q5^2*qd3*qd4*cos(q3)*cos(q4)^2 + L2*M5*qd1*qd2*cos(q4)*sin(q3) + 2.0*L1A*M5*qd1*qd5*cos(q4)*sin(q3) + L2*m*qd1*qd2*cos(q4)*sin(q3) + 2.0*L1A*m*qd1*qd5*cos(q4)*sin(q3) + 2.0*M5*q2*qd1*qd5*cos(q4)*sin(q3) + 2.0*M5*q5*qd1*qd2*cos(q4)*sin(q3) - 0.33333*L2^2*M5*qd3^2*cos(q4)*sin(q3)*sin(q4) + 2.0*m*q2*qd1*qd5*cos(q4)*sin(q3) + 2.0*m*q5*qd1*qd2*cos(q4)*sin(q3) - 0.58333*L2^2*m*qd3^2*cos(q4)*sin(q3)*sin(q4) - 1.0*M5*q5^2*qd3^2*cos(q4)*sin(q3)*sin(q4) - 1.0*L2*L1A*m*qd1*qd4*sin(q3)*sin(q4) - 1.0*L2*M5*q2*qd1*qd4*sin(q3)*sin(q4) - 2.0*L1A*M5*q5*qd1*qd4*sin(q3)*sin(q4) + L2*m*q2*qd1*qd3*cos(q3)*cos(q4) + 2.0*L1A*m*q5*qd1*qd3*cos(q3)*cos(q4) + 2.0*M5*q2*q5*qd1*qd3*cos(q3)*cos(q4) + 0.66667*L2^2*M5*qd1*qd3*cos(q3)*cos(q4)^2*sin(q3) + 0.66667*L2^2*M5*qd1*qd4*cos(q3)^2*cos(q4)*sin(q4) - 1.0*L2*m*q2*qd1*qd4*sin(q3)*sin(q4) - 2.0*L1A*m*q5*qd1*qd4*sin(q3)*sin(q4) - 2.0*M5*q2*q5*qd1*qd4*sin(q3)*sin(q4) + 2.0*m*q2*q5*qd1*qd3*cos(q3)*cos(q4) + 1.1667*L2^2*m*qd1*qd3*cos(q3)*cos(q4)^2*sin(q3) + 1.1667*L2^2*m*qd1*qd4*cos(q3)^2*cos(q4)*sin(q4) + 2.0*M5*q5^2*qd1*qd3*cos(q3)*cos(q4)^2*sin(q3) + 2.0*M5*q5^2*qd1*qd4*cos(q3)^2*cos(q4)*sin(q4) + 2.0*L2*M5*q5*qd3*qd4*cos(q3)*cos(q4)^2 - 2.0*m*q2*q5*qd1*qd4*sin(q3)*sin(q4) + L2*M5*qd3*qd5*cos(q3)*cos(q4)*sin(q4) + 2.0*m*q5^2*qd1*qd3*cos(q3)*cos(q4)^2*sin(q3) + 2.0*m*q5^2*qd1*qd4*cos(q3)^2*cos(q4)*sin(q4) + 2.0*L2*m*q5*qd3*qd4*cos(q3)*cos(q4)^2 + L2*m*qd3*qd5*cos(q3)*cos(q4)*sin(q4) + 2.0*M5*q5*qd3*qd5*cos(q3)*cos(q4)*sin(q4) + 2.0*m*q5*qd3*qd5*cos(q3)*cos(q4)*sin(q4) + L2*L1A*M5*qd1*qd3*cos(q3)*cos(q4) - 1.0*L2*M5*q5*qd3^2*cos(q4)*sin(q3)*sin(q4) - 1.0*L2*L1A*M5*qd1*qd4*sin(q3)*sin(q4) + L2*L1A*m*qd1*qd3*cos(q3)*cos(q4) + L2*M5*q2*qd1*qd3*cos(q3)*cos(q4) + 2.0*L1A*M5*q5*qd1*qd3*cos(q3)*cos(q4) - 1.0*L2*m*q5*qd3^2*cos(q4)*sin(q3)*sin(q4) + 2.0*L2*M5*q5*qd1*qd3*cos(q3)*cos(q4)^2*sin(q3) + 2.0*L2*M5*q5*qd1*qd4*cos(q3)^2*cos(q4)*sin(q4) + 2.0*L2*m*q5*qd1*qd3*cos(q3)*cos(q4)^2*sin(q3) + 2.0*L2*m*q5*qd1*qd4*cos(q3)^2*cos(q4)*sin(q4);
R2^2*bm2*qd2 - 1.0*L1A*M5*qd1^2 - 1.0*L1A*Mt*qd1^2 - 1.0*m*q2*qd1^2 - 1.0*L1A*m*qd1^2 - 1.0*M5*q2*qd1^2 - 1.0*Mt*q2*qd1^2 + 2.0*M5*qd1*qd5*sin(q4) + 2.0*m*qd1*qd5*sin(q4) + 2.0*M5*qd3*qd5*cos(q3)*cos(q4) - 2.0*M5*qd4*qd5*sin(q3)*sin(q4) + 2.0*m*qd3*qd5*cos(q3)*cos(q4) - 2.0*m*qd4*qd5*sin(q3)*sin(q4) - 0.5*L2*M5*qd1^2*cos(q4)*sin(q3) - 0.5*L2*M5*qd3^2*cos(q4)*sin(q3) - 0.5*L2*M5*qd4^2*cos(q4)*sin(q3) - 0.5*L2*m*qd1^2*cos(q4)*sin(q3) - 0.5*L2*m*qd3^2*cos(q4)*sin(q3) - 0.5*L2*m*qd4^2*cos(q4)*sin(q3) - 1.0*M5*q5*qd1^2*cos(q4)*sin(q3) - 1.0*M5*q5*qd3^2*cos(q4)*sin(q3) - 1.0*M5*q5*qd4^2*cos(q4)*sin(q3) + L2*M5*qd1*qd4*cos(q4) - 1.0*m*q5*qd1^2*cos(q4)*sin(q3) - 1.0*m*q5*qd3^2*cos(q4)*sin(q3) - 1.0*m*q5*qd4^2*cos(q4)*sin(q3) + L2*m*qd1*qd4*cos(q4) + 2.0*M5*q5*qd1*qd4*cos(q4) + 2.0*m*q5*qd1*qd4*cos(q4) - 1.0*L2*M5*qd3*qd4*cos(q3)*sin(q4) - 1.0*L2*m*qd3*qd4*cos(q3)*sin(q4) - 2.0*M5*q5*qd3*qd4*cos(q3)*sin(q4) - 2.0*m*q5*qd3*qd4*cos(q3)*sin(q4);
bm3*qd3 - 0.083333*cos(q4)*(6.0*L2*L1A*m*qd1^2*cos(q3) + 6.0*L2*M5*q2*qd1^2*cos(q3) + 12.0*L1A*M5*q5*qd1^2*cos(q3) + 8.0*L2^2*M5*qd3*qd4*sin(q4) + 6.0*L2*m*q2*qd1^2*cos(q3) + 12.0*L1A*m*q5*qd1^2*cos(q3) + 12.0*M5*q2*q5*qd1^2*cos(q3) + 14.0*L2^2*m*qd3*qd4*sin(q4) + 24.0*M5*q5^2*qd3*qd4*sin(q4) + 12.0*m*q2*q5*qd1^2*cos(q3) + 24.0*m*q5^2*qd3*qd4*sin(q4) - 12.0*L2*M5*qd3*qd5*cos(q4) - 12.0*L2*m*qd3*qd5*cos(q4) - 24.0*M5*q5*qd3*qd5*cos(q4) + 6.0*L2*L1A*M5*qd1^2*cos(q3) - 24.0*m*q5*qd3*qd5*cos(q4) - 14.0*L2^2*m*qd1*qd4*cos(q3)*cos(q4) - 24.0*M5*q5^2*qd1*qd4*cos(q3)*cos(q4) - 24.0*m*q5^2*qd1*qd4*cos(q3)*cos(q4) + 24.0*L2*M5*q5*qd3*qd4*sin(q4) + 24.0*L2*m*q5*qd3*qd4*sin(q4) - 12.0*L2*M5*qd1*qd5*cos(q3)*sin(q4) - 12.0*L2*m*qd1*qd5*cos(q3)*sin(q4) + 4.0*L2^2*M5*qd1^2*cos(q3)*cos(q4)*sin(q3) - 24.0*M5*q5*qd1*qd5*cos(q3)*sin(q4) + 7.0*L2^2*m*qd1^2*cos(q3)*cos(q4)*sin(q3) - 24.0*m*q5*qd1*qd5*cos(q3)*sin(q4) + 12.0*M5*q5^2*qd1^2*cos(q3)*cos(q4)*sin(q3) - 8.0*L2^2*M5*qd1*qd4*cos(q3)*cos(q4) + 12.0*m*q5^2*qd1^2*cos(q3)*cos(q4)*sin(q3) - 24.0*L2*m*q5*qd1*qd4*cos(q3)*cos(q4) + 12.0*L2*M5*q5*qd1^2*cos(q3)*cos(q4)*sin(q3) + 12.0*L2*m*q5*qd1^2*cos(q3)*cos(q4)*sin(q3) - 24.0*L2*M5*q5*qd1*qd4*cos(q3)*cos(q4));
bm4*qd4 - 1.0*(0.083333*L2^2*(M5 + m) + 0.25*L2^2*m)*(qdd1*sin(q3) - 1.0*qdd4 + qd1*qd3*cos(q3)) + qdd1*(sin(q3)*(0.083333*L2^2*(M5 + m) + 0.25*L2^2*m) + (M5 + m)*(0.5*L2 + q5)*(sin(q4 + 1.5708)*(L1A + q2) + 0.5*L2*sin(q3) + q5*sin(q3))) - 1.0*qdd4*(0.083333*L2^2*(M5 + m) + 0.25*L2^2*m + (M5 + m)*(0.5*L2 + q5)^2) - 1.0*(M5 + m)*(0.5*L2 + q5)*(q5*(qdd1*sin(q3) - 1.0*qdd4 + qd1*qd3*cos(q3)) - 2.0*qd5*(qd4 - 1.0*qd1*sin(q3)) + 1.0*cos(q4 + 1.5708)*(1.0*g*cos(q3) - sin(q3)*(qdd2 - 1.0*qd1^2*(L1A + q2))) + sin(q4 + 1.5708)*(2.0*qd1*qd2 + qdd1*(L1A + q2)) + 0.5*L2*(qdd1*sin(q3) - 1.0*qdd4 + qd1*qd3*cos(q3)) + 0.5*L2*(qd3*cos(q4 + 1.5708) + qd1*sin(q4 + 1.5708)*cos(q3))*(qd3*sin(q4 + 1.5708) - 1.0*qd1*cos(q4 + 1.5708)*cos(q3)) + q5*(qd3*cos(q4 + 1.5708) + qd1*sin(q4 + 1.5708)*cos(q3))*(qd3*sin(q4 + 1.5708) - 1.0*qd1*cos(q4 + 1.5708)*cos(q3))) - 1.0*(qd3*cos(q4 + 1.5708) + qd1*sin(q4 + 1.5708)*cos(q3))*(qd3*sin(q4 + 1.5708) - 1.0*qd1*cos(q4 + 1.5708)*cos(q3))*(0.083333*L2^2*(M5 + m) + 0.25*L2^2*m) + g*cos(q4 + 1.5708)*cos(q3)*(M5 + m)*(0.5*L2 + q5) - 1.0*qdd2*cos(q4 + 1.5708)*sin(q3)*(M5 + m)*(0.5*L2 + q5);
bm5*qd5*R5^2 - 0.5*(M5 + m)*(L2*qd1^2 + L2*qd4^2 + 2.0*q5*qd1^2 + 2.0*q5*qd4^2 + 4.0*qd1*qd2*sin(q4) + L2*qd3^2*cos(q4)^2 + 2.0*q5*qd3^2*cos(q4)^2 - 2.0*q5*qd1^2*cos(q3)^2*cos(q4)^2 + 2.0*L1A*qd1^2*cos(q4)*sin(q3) + 2.0*q2*qd1^2*cos(q4)*sin(q3) - 2.0*L2*qd1*qd4*sin(q3) - 4.0*q5*qd1*qd4*sin(q3) - 1.0*L2*qd1^2*cos(q3)^2*cos(q4)^2 + 2.0*L2*qd1*qd3*cos(q3)*cos(q4)*sin(q4) + 4.0*q5*qd1*qd3*cos(q3)*cos(q4)*sin(q4))];
 
    Ga_ne=[                       0
                                  0
            g*cos(q4)*sin(q3)*(M5 + m)*(0.5*L2 + q5)
            g*cos(q3)*sin(q4)*(M5 + m)*(0.5*L2 + q5)
             -2.0*g*cos(q3)*cos(q4)*(0.5*M5 + 0.5*m)];
  end
 
 Ma_ne = simplify(Ma_ne);
 Va_ne = simplify(Va_ne);
 Ga_ne = simplify(Ga_ne);

 Ma_ne = vpa(Ma_ne,3);
 Va_ne = vpa(Va_ne,3);
 Ga_ne = vpa(Ga_ne,3);


end