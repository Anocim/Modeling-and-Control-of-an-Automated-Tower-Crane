function [xyz,angEuler] = CinematicaDir(in)
  q1       = in(1);           % Posiciones articulares
  q2       = in(2);            
  q3       = in(3);
  q4       = in(4);
  q5       = in(5);

L0= 45; % m
L1B = 35; % m 
L1A= L1B/2; % m
L2= 15; % m

x= cos(q1)*(L1A + q2) + (L2 + q5)*(sin(q1)*sin(q4) + cos(q1)*cos(q4)*sin(q3));

y= sin(q1)*(L1A + q2) - (L2 + q5)*(cos(q1)*sin(q4) - cos(q4)*sin(q1)*sin(q3));

z= L0 - cos(q3)*cos(q4)*(L2 + q5);

xyz=[x;y;z];

TB6= [  cos(q4)*sin(q1) - cos(q1)*sin(q3)*sin(q4), -cos(q1)*cos(q3), sin(q1)*sin(q4) + cos(q1)*cos(q4)*sin(q3), L1A*cos(q1) + q2*cos(q1) + L2*sin(q1)*sin(q4) + q5*sin(q1)*sin(q4) + L2*cos(q1)*cos(q4)*sin(q3) + q5*cos(q1)*cos(q4)*sin(q3);
      - cos(q1)*cos(q4) - sin(q1)*sin(q3)*sin(q4), -cos(q3)*sin(q1), cos(q4)*sin(q1)*sin(q3) - cos(q1)*sin(q4), L1A*sin(q1) + q2*sin(q1) - L2*cos(q1)*sin(q4) - q5*cos(q1)*sin(q4) + L2*cos(q4)*sin(q1)*sin(q3) + q5*cos(q4)*sin(q1)*sin(q3);
                                  cos(q3)*sin(q4),         -sin(q3),                          -cos(q3)*cos(q4),                                                                                 L0 - L2*cos(q3)*cos(q4) - q5*cos(q3)*cos(q4);
                                                0,                0,                                         0,                                                                                                                            1];

r11= TB6(1,1);      r12= TB6(1,2);      r13= TB6(1,3);
r21= TB6(2,1);      r22= TB6(2,2);      r23= TB6(2,3);
r31= TB6(3,1);      r32= TB6(3,2);      r33= TB6(3,3);

theta = atan2(-r31,sqrt(r11^2+r21^2));

phi = atan2(r21,r11);

psi = atan2(r32,r33);

angEuler = [phi;theta;psi];

end