function  [x, y, z, phi, theta, psi, TB6]= CinematicaDirSim()

syms L0 L1A L2 q1 q2 q3 q4 q5 real            % Declaración de las variables simbólicas

PI=sym(pi);

[theta0, d0, a0, alpha0]=deal(0, L0, 0, 0);

[theta1, d1, a1, alpha1]=deal(q1+PI/2, 0, 0, PI/2);

[theta2, d2, a2, alpha2]=deal(-PI/2, L1A+q2, 0, PI/2);

[theta3, d3, a3, alpha3]=deal(q3, 0, 0, PI/2);

[theta4, d4, a4, alpha4]=deal(q4+PI/2, 0, 0, PI/2);

[theta5, d5, a5, alpha5]=deal(0, q5, 0, 0);

[theta6, d6, a6, alpha6]=deal(0, L2, 0, 0);

TB0= MDH(theta0, d0, a0, alpha0);

%{
 [1, 0, 0,  0]
 [0, 1, 0,  0]
 [0, 0, 1, L0]
 [0, 0, 0,  1]
%}

T01= MDH(theta1, d1, a1, alpha1);

%{
 [cos(q1 + pi/2), 0,  sin(q1 + pi/2), 0]
 [sin(q1 + pi/2), 0, -cos(q1 + pi/2), 0]
 [             0, 1,               0, 0]
 [             0, 0,               0, 1]
%}

T12= MDH(theta2, d2, a2, alpha2);

%{
 [ 0, 0, -1,       0]
 [-1, 0,  0,       0]
 [ 0, 1,  0, L1A + q2]
 [ 0, 0,  0,       1]
%}


T23= MDH(theta3, d3, a3, alpha3);

%{
 [cos(q3), 0,  sin(q3), 0]
 [sin(q3), 0, -cos(q3), 0]
 [      0, 1,        0, 0]
 [      0, 0,        0, 1]
%}

T34= MDH(theta4, d4, a4, alpha4);

%{
 [cos(q4 + pi/2), 0,  sin(q4 + pi/2), 0]
 [sin(q4 + pi/2), 0, -cos(q4 + pi/2), 0]
 [             0, 1,               0, 0]
 [             0, 0,               0, 1]
%}

T45= MDH(theta5, d5, a5, alpha5);

%{
 [1, 0, 0,  0]
 [0, 1, 0,  0]
 [0, 0, 1, q5]
 [0, 0, 0,  1]
%}

T56= MDH(theta6, d6, a6, alpha6);

%{
 [1, 0, 0,  0]
 [0, 1, 0,  0]
 [0, 0, 1, L2]
 [0, 0, 0,  1]
%}

TB6= simplify(TB0*T01*T12*T23*T34*T45*T56);

%{
[  cos(q4)*sin(q1) - cos(q1)*sin(q3)*sin(q4), -cos(q1)*cos(q3), sin(q1)*sin(q4) + cos(q1)*cos(q4)*sin(q3), cos(q1)*(L1A + q2) + (L2 + q5)*(sin(q1)*sin(q4) + cos(q1)*cos(q4)*sin(q3))]
[- cos(q1)*cos(q4) - sin(q1)*sin(q3)*sin(q4), -cos(q3)*sin(q1), cos(q4)*sin(q1)*sin(q3) - cos(q1)*sin(q4), sin(q1)*(L1A
 + q2) - (L2 + q5)*(cos(q1)*sin(q4) - cos(q4)*sin(q1)*sin(q3))]
[                            cos(q3)*sin(q4),         -sin(q3),                          -cos(q3)*cos(q4),                                     L0 - cos(q3)*cos(q4)*(L2 + q5)]
[                                          0,                0,                                         0,                                                                         1]
%}


x= cos(q1)*(L1A + q2) + (L2 + q5)*(sin(q1)*sin(q4) + cos(q1)*cos(q4)*sin(q3));

y= sin(q1)*(L1A + q2) - (L2 + q5)*(cos(q1)*sin(q4) - cos(q4)*sin(q1)*sin(q3));

z= L0 - cos(q3)*cos(q4)*(L2 + q5);

%% Ángulos de Euler

% MRPY=rotz(phi)*roty(theta)*rotx(psi);

% [cos(phi)*cos(theta), cos(phi)*sin(psi)*sin(theta) - cos(psi)*sin(phi), sin(phi)*sin(psi) + cos(phi)*cos(psi)*sin(theta), 0]
% [cos(theta)*sin(phi), cos(phi)*cos(psi) + sin(phi)*sin(psi)*sin(theta), cos(psi)*sin(phi)*sin(theta) - cos(phi)*sin(psi), 0]
% [        -sin(theta),                              cos(theta)*sin(psi),                              cos(psi)*cos(theta), 0]
% [                  0,                                                0,                                                0, 1]

% Se compara con TB6

r11= TB6(1,1);      r12= TB6(1,2);      r13= TB6(1,3);
r21= TB6(2,1);      r22= TB6(2,2);      r23= TB6(2,3);
r31= TB6(3,1);      r32= TB6(3,2);      r33= TB6(3,3);

theta = atan2(-r31,sqrt(r11^2+r21^2));

phi = atan2(r21,r11);

psi = atan2(r32,r33);

end 