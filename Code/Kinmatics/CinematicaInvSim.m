function  [q1, q2, q3, q4, q5]= CinematicaInvSim()

syms L0 L1 L2 x y z theta psi phi real            % Declaración de las variables simbólicas

PI=sym(pi);

% Cinemática inversa

% Se van a utilizar las ecuaciones obtenidas a la hora de calcular los
% ángulos de Euler para conseguir la definición de las variables
% articulares. Se seguirá un procedimiento parecido al anterior.

MRPY=rotz(phi)*roty(theta)*rotx(psi);

% [cos(phi)*cos(theta), cos(phi)*sin(psi)*sin(theta) - cos(psi)*sin(phi), sin(phi)*sin(psi) + cos(phi)*cos(psi)*sin(theta), 0]
% [cos(theta)*sin(phi), cos(phi)*cos(psi) + sin(phi)*sin(psi)*sin(theta), cos(psi)*sin(phi)*sin(theta) - cos(phi)*sin(psi), 0]
% [        -sin(theta),                              cos(theta)*sin(psi),                              cos(psi)*cos(theta), 0]
% [                  0,                                                0,                                                0, 1]

% Se compara con la matriz TB6 obtenida en la cinemática directa.

r11= MRPY(1,1);      r12= MRPY(1,2);      r13= MRPY(1,3);
r21= MRPY(2,1);      r22= MRPY(2,2);      r23= MRPY(2,3);
r31= MRPY(3,1);      r32= MRPY(3,2);      r33= MRPY(3,3);

%%%%% q3 %%%%%
% -sin(q3)= r32
% sin(q3)= -r32

% cos(q3)*sin(q4)= r31
% -cos(q3)*cos(q4)= r33

% r31^2 + r33^2 = 2*cos(q3)^2
% cos(q3) = sqrt((r31^2 + r33^2)/2)
% cos(q3) = -sqrt((r31^2 + r33^2)/2)

q3 = atan2(-r32, sqrt((r31^2 + r33^2)));

%%%%% q4 %%%%%
% cos(q3)*sin(q4)= r31
% sin(q4)*cos(q3) = r31

% -cos(q3)*cos(q4)= r33
% cos(q4)*cos(q3) = -r33

% (sin(q4)*cos(q3)) / (cos(q4)*cos(q3)) = r31/-r33
% sin(q4)/cos(q4) = r31/-r33

q4 = atan2(r31,-r33);

%%%%% q1 %%%%%
% -cos(q1)*cos(q3) = r12
% cos(q1)*cos(q3) = -r12

% -cos(q3)*sin(q1) = r22
% sin(q1)*cos(q3) = -r22

% (sin(q1)*cos(q3)) / (cos(q1)*cos(q3)) = -r22/-r12
% sin(q1)/cos(q1) = -r22/-r12

q1 = atan2(-r22,-r12);

% Una vez se ha solucionado la parte de la orientación gracias al desacoplo
% que se puede hacer del robot pasaremos a obtener las variales restantes
% utilizando las ecuaciones de posición

%%%%% q5 %%%%%
% z= L0 - cos(q3)*cos(q4)*(L2 + q5);
% -(z-L0)/ cos(q3)*cos(q4) = L2+q5
% q5 = (L0-z)/cos(q3)*cos(q4)

q5 = (L0-z)/(cos(q3)*cos(q4)) -L2;

%%%%% q2 %%%%%
% x= cos(q1)*(L1A + q2) + (L2 + q5)*(sin(q1)*sin(q4) + cos(q1)*cos(q4)*sin(q3));
% x= cos(q1)*(L1A + q2) + (L2 + q5)*r13;
% x - (L2 + q5)*r13 = cos(q1)*(L1A + q2);
% (x - (L2 + q5)*r13)*cos(q1) = cos(q1)^2*(L1A + q2);
 
% y= sin(q1)*(L1A + q2) - (L2 + q5)*(cos(q1)*sin(q4) - cos(q4)*sin(q1)*sin(q3));
% y= sin(q1)*(L1A + q2) + (L2 + q5)*r23;
% (y - (L2 + q5)*r23)*sin(q1) = sin(q1)^2*(L1A + q2);
 
% sin(q1)^2*(L1A + q2) + cos(q1)^2*(L1A + q2) = (x - (L2 + q5)*r13)*cos(q1) + (y - (L2 + q5)*r23)*sin(q1)
% (L1A + q2) = (x - (L2 + q5)*r13)*cos(q1) + (y - (L2 + q5)*r23)*sin(q1)
% q2 = (x - (L2 + q5)*r13)*cos(q1) + (y - (L2 + q5)*r23)*sin(q1) -L1A

q2 = (x - (L2 + q5)*r13)*cos(q1) + (y - (L2 + q5)*r23)*sin(q1) -L1A;

end