function [vel] = Modelo_Diferencial_dir_num(in)

  q1       = in(1);           % Posiciones articulares
  q2       = in(2);            
  q3       = in(3);
  q4       = in(4);
  q5       = in(5);
  qd1       = in(6);           % Velocidades articulares
  qd2       = in(7);            
  qd3       = in(8);
  qd4       = in(9);
  qd5       = in(10);

  L0= 45; % m
L1B = 35; % m 
L1A= L1B/2; % m
L2= 15; % m

Ja=[(L2 + q5)*(cos(q1)*sin(q4) - cos(q4)*sin(q1)*sin(q3)) - sin(q1)*(L1A + q2), cos(q1),                             cos(q1)*cos(q3)*cos(q4)*(L2 + q5),          (L2 + q5)*(cos(q4)*sin(q1) - cos(q1)*sin(q3)*sin(q4)), sin(q1)*sin(q4) + cos(q1)*cos(q4)*sin(q3);
cos(q1)*(L1A + q2) + (L2 + q5)*(sin(q1)*sin(q4) + cos(q1)*cos(q4)*sin(q3)), sin(q1),                             cos(q3)*cos(q4)*sin(q1)*(L2 + q5),         -(L2 + q5)*(cos(q1)*cos(q4) + sin(q1)*sin(q3)*sin(q4)), cos(q4)*sin(q1)*sin(q3) - cos(q1)*sin(q4);
                                                                         0,       0,                                     cos(q4)*sin(q3)*(L2 + q5),                                      cos(q3)*sin(q4)*(L2 + q5),                          -cos(q3)*cos(q4);
                                                                         1,       0,  -(cos(q3)*cos(q4)*sin(q4))/(cos(q4)^2 + sin(q3)^2*sin(q4)^2),                 -sin(q3)/(sin(q3)^2*sin(q4)^2 - sin(q4)^2 + 1),                                         0;
                                                                      0,       0, (sin(q3)*sin(q4))/(sin(q3)^2*sin(q4)^2 - sin(q4)^2 + 1)^(1/2), -(cos(q3)*cos(q4))/(cos(q3)^2*cos(q4)^2 - cos(q3)^2 + 1)^(1/2),                                         0];

qd=[qd1;qd2;qd3;qd4;qd5];
vel=Ja*qd;

end
